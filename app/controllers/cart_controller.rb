# encoding: utf-8
class CartController < ApplicationController

 def show
   @current_cart = session_cart

   params['itemsinhash'] =  session_cart.cart_items_in_array_of_hashs
 end

end
