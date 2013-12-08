# encoding: utf-8
class CartController < ApplicationController

 def show
   @current_cart = session_cart
 end

end
