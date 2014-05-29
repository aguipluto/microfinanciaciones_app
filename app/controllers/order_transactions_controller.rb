class OrderTransactionsController < ApplicationController
  before_action :admin_user, only: [:index, :show]

  def index
    @order_transactions = OrderTransaction.paginate(page: params[:page], per_page: 50)
  end

  def show
    @transaction = OrderTransaction.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
