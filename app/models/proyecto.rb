class Proyecto < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('fin_aportaciones DESC') }

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

end
