class OrderTransactionsController < ApplicationController
  def index
    @order_transactions = OrderTransaction.paginate(page: params[:page], per_page: 50)
  end

  def show
    @ordertrans = OrderTransaction.find(params[:id])
  end


end
