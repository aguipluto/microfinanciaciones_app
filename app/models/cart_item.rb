class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :cart
  belongs_to :proyecto

  validates_numericality_of :aportacion, :greater_than => 0
  validates :proyecto_id, :presence => true

  def visible_name
    if self.cart.visible_cart?
      self.user.name_second
    else
      'U000' + self.user.id.to_s
    end
  end

  def justify
    if !self.cart.order.nil?
      self.cart.order.justify
    else
      'No ha sido completado el pago'
    end
  end

  def express_token
    if !self.cart.order.nil?
      self.cart.order.express_token
    else
      ''
    end
  end

  def purchased_at_formated
    dateAndTime(ci.cart.purchased_at)
  end

  def self.before(at)
    where("cart_items.created_at <= ?", at)
  end

  def aportacion_in_cents
    (aportacion*100).round
  end

  def purchased_cart_item_in_euro
    if self.cart.purchased_at
      self.aportacion
    else
      0
    end
  end

  def inactivate!
    self.update_attributes(:active => false)
  end

  def self.search(search = '', orders = nil)
    #if search
    if orders == 'Pagadas'
      where('proyectos.titulo LIKE ? OR users.name LIKE ? OR users.family_name LIKE ? OR orders.express_token LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    elsif orders == 'Sin Pagar'
      where('(proyectos.titulo LIKE ? OR users.name LIKE ? OR users.family_name LIKE ?) AND carts.purchased_at IS NULL ', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      where('proyectos.titulo LIKE ? OR users.name LIKE ? OR users.family_name LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%")
    end
    #else
    #  scoped
    #end
  end


end
