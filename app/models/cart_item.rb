class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :cart
  belongs_to :proyecto

  validates_numericality_of :aportacion, :greater_than => 0
  validates :proyecto_id,    :presence => true

  def self.before(at)
    where( "cart_items.created_at <= ?", at )
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

end
