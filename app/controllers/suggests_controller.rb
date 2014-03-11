# encoding: utf-8
class SuggestsController < ApplicationController
  before_action :admin_user, only: [:index, :show, :update]
  include ApplicationHelper

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = Suggest.new(suggest_params)
    @suggest.user_id = current_user.id if current_user
    if @suggest.save
      flash[:success] = "¡Muchas gracias, atenderemos su solicitud lo antes posible!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @suggest = Suggest.find(params[:id])
    @suggest.update_attribute(:shown, true)
    response = {:suggest => @suggest, :unread_suggests => suggestsNotShown}
    respond_to do |format|
      format.json { render :json => response }
      format.html
    end
  end

  def index
    @suggests = Suggest.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
  end

  def update
    @suggest = Suggest.find(params[:id])
    respond_to do |format|
      if @suggest.update_attributes(suggest_params)
        SuggestMailer.answer_email(@suggest).deliver!
        response = {:suggest => @suggest, :result => '0'}
        format.json { render :json => response }
      else
        response = {:errors => @suggest.errors, :result => '-1'}
        format.json { render :json => response }
      end
    end
  end

  private
  def suggest_params
    params.require(:suggest).permit(:name, :email, :tel, :title, :suggestion, :answer)
  end

  def sort_column
    Suggest.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
