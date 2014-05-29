# encoding: utf-8
class OrdersController < ApplicationController
  before_action :correct_user, only: [:show]
  after_action :set_order_shown, only: [:show]
  before_action :admin_user, only: [:index, :admin]

  def new
    @order = Order.includes([:cart]).where('express_token = ? AND carts.purchased_at IS NOT NULL', params[:token]).first
    if @order
      redirect_to @order
    else
      unless params[:token].blank?
        @order = Order.new(:express_token => params[:token])
      else
        flash[:danger] = 'El pago no ha sido realizado. Por favor, intente de nuevo.'
        redirect_to session_cart
      end
    end
  end

  def express
    response = EXPRESS_GATEWAY.setup_purchase(session_cart.build_order.price_in_cents,
                                              :ip => request.remote_ip,
                                              :return_url => new_order_url,
                                              :cancel_return_url => root_url,
                                              currency: 'EUR',
                                              brand_name: 'Fundación Universitaria San Pablo CEU',
                                              header_image: root_url + ActionController::Base.helpers.image_path('logo-fundacion-ceu.gif'),
                                              allow_guest_checkout: 'true',
                                              items: session_cart.cart_items_in_array_of_hashs
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def index
    @orders = Order.includes(:transactions, :user, :cart).search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @order = session_cart.build_order(order_params)
    id = nil #Para que puedan hacerse pagos anónimos, de no quererse se puede poner filtro :signed_in_user para create
    id = current_user.id unless current_user.nil?
    @order.user_id = id
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase(id, params[:visible_cart])
        redirect_to @order
      else
        render :action => 'failure'
      end
    else
      render :action => 'new'
    end
  end

  def admin
    @order = Order.find(params[:id])
  end

  def show

  end


  private

  def order_params
    params.require(:order).permit(:express_token, :invoice_name, :invoice_nif, :invoice_others)
  end

  def sort_column
    %w[orders.id users.family_name orders.invoice_name carts.purchased_at orders.express_token].include?(params[:sort]) ? params[:sort] : "orders.id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def correct_user
    @order = Order.find(params[:id])
    unless @order.user_id.nil? #Donaciones anónimas
      @user = User.find_by_id(@order.user_id)
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin?)
    end
  end

  def set_order_shown
    @order.update_attribute(:shown, true)
  end

end
