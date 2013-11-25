# config/initializers/cartman.rb
Cartman.config do |c|
  c.cart_expires_in = 604800 # one week, in seconds.  This is the default
  c.unit_cost_field = :unit_cost # for cart totaling
  c.quantity_field = :quantity # for quantity totaling
  c.redis = Redis.new # set the redis connection here
end