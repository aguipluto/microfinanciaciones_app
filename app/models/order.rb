class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  has_many :transactions, :class_name => 'OrderTransaction'

  scope :successful, -> { includes(:transactions).where("order_transactions.success = ?", true)}

  #validates_presence_of :user Ya que la aportación puede ser anónima

  def price_in_cents
    (cart.sub_total*100).round
  end

  def justify
    self.invoice_name + ' / ' +  self.invoice_nif
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

  private

  def express_purchase_options
    {
        :ip => ip_address,
        :token => express_token,
        :payer_id => express_payer_id,
        currency: 'EUR'
    }
  end

end
