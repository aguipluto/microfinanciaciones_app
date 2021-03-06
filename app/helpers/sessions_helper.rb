# encoding: utf-8
module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    session_cart
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def session_cart=(session_cart)
    @session_cart = session_cart
  end

  def session_cart
    return @session_cart if defined?(@session_cart)
    session_cart!
  end

  # use this method if you want to force a SQL query to get the cart.
  #def session_cart!
  #  if cookies[:cart_id]
  #    @session_cart ||= Cart.includes(:valid_cart_items).find_by_id(cookies[:cart_id])
  #    unless @session_cart
  #      @session_cart = Cart.create(:user_id => current_user.id)
  #      cookies[:cart_id] = @session_cart.id
  #    end
  #  elsif current_user
  #    @session_cart = Cart.create(:user_id => current_user.id)
  #    cookies[:cart_id] = @session_cart.id
  #  else
  #    @session_cart = Cart.create
  #    cookies[:cart_id] = @session_cart.id
  #  end
  #  @session_cart
  #end

  def session_cart!
    if cookies[:cart_id]
      @session_cart = Cart.includes(:valid_cart_items).find_by_id(cookies[:cart_id])
      if @session_cart
        @session_cart = nil if @session_cart.purchased_at
      end
      unless @session_cart
        if current_user
          @session_cart = Cart.create(:user_id => current_user.id)
          cookies[:cart_id] = @session_cart.id
        else
          @session_cart = Cart.create
          cookies[:cart_id] = @session_cart.id
        end
      end
    elsif current_user
      @session_cart = Cart.create(:user_id => current_user.id)
      cookies[:cart_id] = @session_cart.id
    else
      @session_cart = Cart.create
      cookies[:cart_id] = @session_cart.id
    end
    @session_cart
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:info] = "Por favor, inicie sesión."
      redirect_to signin_url
    end
  end

  def signed_in_user?
    unless signed_in?
      store_location
      flash[:info] = "Por favor, inicie sesión."
      redirect_to signin_url
    end
    signed_in?
  end

  def sign_out
    self.current_user = nil
    self.session_cart = nil
    cookies.delete(:remember_token)
    cookies.delete(:cart_id)
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default, anchor=nil)
      redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def admin_user
    if signed_in_user? && !current_user.admin?
      redirect_to root_path
    end
  end

  def blog_editor_user
    if signed_in_user? && !(current_user.blog_editor? || current_user.admin?)
      redirect_to root_path
    end
  end

  def blog_editor_user?
    signed_in? && (current_user.admin? || current_user.blog_editor?)
  end

  def current_user_admin?
    signed_in? && current_user.admin?
  end

  def current_user_bog_editor?
    signed_in? && current_user.blog_editor?
  end


end
