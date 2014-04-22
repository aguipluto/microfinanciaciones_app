class Proyecto < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  belongs_to :user
  has_many :cart_items
  has_many :blog_posts
  default_scope { order('fin_aportaciones ASC') }
  scope :aportables, where("visible = ? AND fin_aportaciones > ?", true, Time.now).order('fin_aportaciones ASC')

  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  #has_many :assets, :dependent => :destroy
  #accepts_nested_attributes_for :assets, :allow_destroy => true

  validates :user_id, presence: true
  validates :titulo, presence:true, length: {minimum: 6}
  validates :descripcion_corta, presence:true, length: {minimum: 25, maximum: 255}
  validates :inicio_aportaciones, presence:true
  validates :fin_aportaciones, presence:true
  validates :cantidad_total, presence: true

  def as_json(options = { })
    h = super(options)
    h[:total_collected]   = total_collected.to_i
    h[:fechaInicio] = fecha_inicio.strftime("%d/%m/%Y")
    h[:fechaFin] = fecha_fin.strftime("%d/%m/%Y")
    h[:queda]   = time_ago_in_words(fin_aportaciones)
    h[:attachments] = attachments
    h
  end

  def total_collected
    self.cart_items.map(&:purchased_cart_item_in_euro).sum
  end

  def fin_aportaciones_in_words
     time_ago_in_words(fin_aportaciones)
  end

  def past?
     fin_aportaciones < Time.current
  end

  def assign_class
    if total_collected > cantidad_total
      'success'
    elsif past? || visible == false
      'warning'
    end
  end

  def self.search(search)
    if search
      where('titulo LIKE ? OR descripcion_corta LIKE ? OR descripcion_larga LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end

end
