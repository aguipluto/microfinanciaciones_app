class Cart < ActiveRecord::Base
  belongs_to :user
  has_one :order
  has_many :valid_cart_items, -> { where(active: true) },   class_name: 'CartItem'
  has_many :deleted_cart_items, -> { where(active: true) },   class_name: 'CartItem'

  accepts_nested_attributes_for :valid_cart_items

  def sub_total
    valid_cart_items.map(&:aportacion).sum
  end

  def add_proyecto(proyecto_id, user_id, aportacion=1)
    items = valid_cart_items.where(proyecto_id: proyecto_id)
    if items.size < 1
      cart_item = valid_cart_items.build(proyecto_id: proyecto_id, user_id: user_id, aportacion: aportacion)
      logger.debug "New cartitem: #{valid_cart_items.first.attributes.inspect}"
      logger.debug "errores cartitem: #{cart_item.errors.inspect}"
    else
      cart_item = items.first
      update_cart(cart_item, aportacion)
      logger.debug 'The cart item hasnt be saved'
    end
    cart_item
  end

  def remove_proyecto(proyecto_id)
    citems = self.cart_items.each {|ci| ci.inactivate! if proyecto_id.to_i == ci.proyecto_id }
    return citems
  end

  def cart_items_in_array_of_hashs
      array = []
    valid_cart_items.each do |ci|
      hash = {}
      hash[:name] =  ci.proyecto.titulo
      hash[:description] = ci.proyecto.descripcion_corta
      hash[:quantity] = 1
      hash[:amount] = ci.aportacion_in_cents
      array.push(hash)
    end
    array
  end

  private
  def update_cart(cart_item, aportacion = 0)
    self.valid_cart_items.find(cart_item.id).update_attributes(:aportacion => (cart_item.aportacion + aportacion))
  end
end
