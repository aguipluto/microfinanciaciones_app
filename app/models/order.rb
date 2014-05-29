class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  has_many :transactions, :class_name => 'OrderTransaction'

  before_save { self.invoice_nif = invoice_nif.upcase.gsub(' ', '').gsub('-', '').gsub('/', '') }


  validates_format_of :invoice_nif, :with => /\A[0-9]{8}([-]?)[A-Za-z]\Z/, :on => :update, :message => "tiene que tener un formato como el siguiente: 12345678A o 12345678-A"
  validate :dni_letter_must_match_number

  scope :successful, -> { where("order_transactions.success = ?", true) }

  validates_presence_of :invoice_name
  validates :invoice_nif, length: {minimun: 9, maximum: 10}

  def price_in_cents
    (cart.sub_total*100).round
  end

  def justify
    self.invoice_name + ' / ' + self.invoice_nif
  end

  def name_second
    self.first_name + ' ' + self.second_name
  end

  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.second_name = details.params["last_name"]
    end
  end

  def purchase(user_id=nil, visible_cart=false)
    response = EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response, user_id: user_id)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    cart.update_attribute(:visible_cart, visible_cart) if response.success?
    response.success?
  end

  def self.search(search )
    if search
      where("order_transactions.success = ? AND (users.family_name LIKE ? OR users.name LIKE ? OR orders.invoice_name LIKE ? OR orders.express_token LIKE ?)", true, "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")

    else
      where("order_transactions.success = ?", true)
    end
  end

  private

  def dni_letter_must_match_number
    if "TRWAGMYFPDXBNJZSQVHLCKE"[invoice_nif[0..7].to_i % 23].chr != invoice_nif[8] && "TRWAGMYFPDXBNJZSQVHLCKE"[invoice_nif[0..7].to_i % 23].chr != invoice_nif[9]
      errors.add(:invoice_nif, "no parece correcto")
    end
  end

  def express_purchase_options
    {
        :ip => ip_address,
        :token => express_token,
        :payer_id => express_payer_id,
        currency: 'EUR'
    }
  end

end
