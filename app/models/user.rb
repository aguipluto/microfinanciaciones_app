class User < ActiveRecord::Base
  has_many :proyectos, dependent: :nullify
  has_many    :carts,  dependent: :nullify
  has_many    :purchased_carts,  -> { where("purchased_at IS NOT NULL") }, class_name: 'Cart'
  has_many    :cart_items
  has_many    :deleted_cart_items,  -> { where( active: false) }, class_name: 'CartItem'

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: { thumb: '100x100>', square: '200x200#',medium: '300x300>'},
                    :default_url => '/assets/images/user.png'

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def purchased_cart_items
    purchaseds = []
    purchased_carts.each do |c|
      c.valid_cart_items.each do |ci|
        purchaseds.push(ci)
      end
    end
    purchaseds
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
