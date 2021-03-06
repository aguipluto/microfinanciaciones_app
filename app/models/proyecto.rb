class Proyecto < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  acts_as_taggable

  belongs_to :user
  has_many :cart_items
  has_many :blog_posts

  has_many :cart_items_purchased, -> { joins(:cart).where("purchased_at IS NOT NULL") }, class_name: 'CartItem'
  default_scope -> { order('fin_aportaciones ASC') }
  scope :aportables, -> (search=nil) { where("visible = ? AND fin_aportaciones > ? AND inicio_aportaciones < ? AND (titulo LIKE ? OR descripcion_larga LIKE ? OR descripcion_corta LIKE ? OR lugar LIKE ?)", true, Time.now, Time.now, "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").order('fin_aportaciones ASC') }
  scope :visibles, -> (search=nil) { where("visible = ? AND (titulo LIKE ? OR descripcion_larga LIKE ? OR descripcion_corta LIKE ? OR lugar LIKE ?)", true, "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").order('fin_aportaciones ASC') }
  scope :no_aportables, -> (search=nil) { where("visible = ? AND fin_aportaciones < ? AND (titulo LIKE ? OR descripcion_larga LIKE ? OR descripcion_corta LIKE ? OR lugar LIKE ?)", true, Time.now, "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").order('fin_aportaciones ASC') }

  has_many :attachments, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  has_many :volunteers
  has_many :users, through: :volunteers
  #has_many :assets, :dependent => :destroy
  #accepts_nested_attributes_for :assets, :allow_destroy => true

  validates :user_id, presence: true
  validates :titulo, presence: true, length: {minimum: 6}
  validates :descripcion_corta, presence: true, length: {minimum: 25, maximum: 255}
  validates :inicio_aportaciones, presence: true
  validates :fin_aportaciones, presence: true
  validates :cantidad_total, presence: true

  def as_json(options = {})
    h = super(options)
    h[:total_collected] = total_collected
    h[:fechaInicio] = fecha_inicio.strftime("%d/%m/%Y")
    h[:fechaFin] = fecha_fin.strftime("%d/%m/%Y")
    h[:queda] = time_ago_in_words(fin_aportaciones)
    h[:attachments] = attachments
    h
  end

  def anchobar
    if cantidad_total > 0
      ancho = (total_collected * 100) / cantidad_total
      if total_collected >= cantidad_total
        cantidad_total * 100 / (total_collected)
      else
        ancho
      end
    else
      total_collected
    end
  end

  def aportable?
    self.visible && Time.now < self.fin_aportaciones && Time.now > self.inicio_aportaciones
  end

  def totalbar
    if total_collected >= cantidad_total
      total_collected
    else
      cantidad_total
    end
  end

  def extrabar
    ((total_collected-cantidad_total) * 100) / (total_collected)
  end

  def fechaFin
    fecha_fin.strftime("%d/%m/%Y")
  end

  def fechaInicio
    fecha_inicio.strftime("%d/%m/%Y")
  end

  def queda
    time_ago_in_words(fin_aportaciones)
  end

  def total_collected
    self.cart_items.map(&:purchased_cart_item_in_euro).sum.to_i
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
      where('titulo LIKE ? OR descripcion_corta LIKE ? OR descripcion_larga LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

end
