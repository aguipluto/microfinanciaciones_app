# encoding: utf-8
class CartController < ApplicationController

  def show
    @current_cart = session_cart
  end

  def show2
    @current_cart = session_cart
  end

  def get_number_of_items
    result = session_cart.valid_cart_items.count
    respond_to do |format|
      format.json { render :json => {:result => result} }
    end
  end
end
