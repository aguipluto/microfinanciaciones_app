# encoding: utf-8
class User < ActiveRecord::Base
  #obfuscate_id

  has_many :proyectos, dependent: :nullify
  has_many :carts, dependent: :nullify
  has_many :purchased_carts, -> { where("purchased_at IS NOT NULL") }, class_name: 'Cart'
  has_many :cart_items
  has_many :blog_posts, dependent: :nullify
  has_many :deleted_cart_items, -> { where(active: false) }, class_name: 'CartItem'
  has_many :suggests, dependent: :nullify
  has_many :volunteers

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  validates :terms_of_service, :acceptance => true
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :family_name, presence: true, length: {minimun: 3, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password             , length: { minimum: 6 }, :if => :validate_password?
  validates :password_confirmation, presence: true        , :if => :validate_password?

  def validate_password?
    password.present? || password_confirmation.present?
  end

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {thumb: '100x100>', square: '200x200#', medium: '300x300>'},
                    :default_url => '/assets/images/user.png'
  mount_uploader :image, ImageUploader


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

  def assign_class
    unless confirmed
       'warning'
    end
  end

  def self.search(search)
    if search
      where('name LIKE ? OR family_name LIKE ? OR email LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end

  def send_password_token
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_send = Time.zone.now
    save!
    UserMailer.password_reset_email(self).deliver!
  end

  def is_volunteer?(proyecto)
    self.volunteers.find_by(proyecto_id: proyecto.id)
  end

  def make_volunteer!(proyecto)
    self.volunteers.create!(proyecto_id: proyecto.id)
  end

  def not_volunteer!(proyecto)
    self.volunteers.find_by(proyecto_id: proyecto.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
