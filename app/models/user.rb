# encoding: utf-8
class User < ActiveRecord::Base
  #obfuscate_id

  has_many :proyectos
  has_many :carts
  has_many :purchased_carts, -> { where("purchased_at IS NOT NULL") }, class_name: 'Cart'
  has_many :cart_items
  has_many :cart_items_purchased, -> { joins(:cart).where("purchased_at IS NOT NULL") }, class_name: 'CartItem'
  has_many :blog_posts
  has_many :deleted_cart_items, -> { where(active: false) }, class_name: 'CartItem'
  has_many :suggests
  has_many :volunteers, dependent: :destroy


  before_create :create_remember_token
  before_save do
    self.email = email.downcase
    self.nif = nif.to_s.upcase.gsub(' ', '').gsub('-', '').gsub('/', '')
  end

  validates :terms_of_service, :acceptance => true
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :family_name, presence: true, length: {minimun: 3, maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}, :if => :validate_password?
  validates :password_confirmation, presence: true, :if => :validate_password?

  def validate_password?
    password.present? || password_confirmation.present?
  end

  # This method associates the attribute ":avatar" with a file attachment
  #has_attached_file :avatar, styles: {thumb: '100x100>', square: '200x200#', medium: '300x300>'},
  #                  :default_url => '/assets/images/user.png'
  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where('(provider = ? AND uid = ?) OR email = ?', auth.provider, auth.uid, auth.info.email).first_or_initialize.tap do |user|
      user.provider = auth.provider
      #Si es un nuevo usuario
      logger.debug "Person attributes hash: #{auth}"
      if user.email.blank?
        user.email = auth.info.email
        p = SecureRandom.urlsafe_base64[0..7]
        user.password = p
        user.password_confirmation = p
        user.confirmed = true
        user.name = auth.info.first_name
        user.family_name = auth.info.last_name
        unless auth.extra.raw_info.birthday.blank?
          user.birthdate = Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
        end
      end
      user.uid = auth.uid
      user.fb_name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save(validate: false)
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def assign_class
    if self.deleted?
      'danger'
    elsif !self.confirmed?
      'warning'
    end
  end

  def fb_image_large
    "http://graph.facebook.com/#{self.uid}/picture?type=large"
  end

  def fb_image_normal
    "http://graph.facebook.com/#{self.uid}/picture?type=normal"
  end

  def assign_title
    if self.deleted?
      'Usuario borrado'
    else
      'Usuario ' + self.id.to_s
    end
  end

  def name_second
    self.name + ' ' + self.family_name
  end

  def second_com_name
    self.family_name + ', ' + self.name
  end

  def self.search(search)
    if search
      where('name LIKE ? OR family_name LIKE ? OR email LIKE ? OR nif LIKE ?', true, "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def total_achieved
    self.cart_items_purchased.map(&:aportacion).sum.to_i
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

  def birthday
    if !birthdate.blank?
      birthdate.strftime("%d/%m/%Y")
    else
      ''
    end
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
