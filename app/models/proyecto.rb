class Proyecto < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('fin_aportaciones DESC') }

  validates :user_id, presence: true
  validates :titulo, presence:true, length: {minimum: 6}
  validates :descripcion_corta, presence:true, length: {minimum: 25, maximum: 255}
  validates :inicio_aportaciones, presence:true
  validates :fin_aportaciones, presence:true
  validates :cantidad_total, presence: true

end
