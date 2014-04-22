class BlogPostsController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]
  before_action :blog_editor_user, only: [:new, :create, :edit, :update]

  def approve
    @blog_post = BlogPost.find(params[:id])
    @blog_post.approved = true
    if @blog_post.save
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @blogpost = BlogPost.new(blogpost_params)
    @blogpost.user = current_user
    if @blogpost.save
      flash[:success] = "Post pendiente de aprobación."
      redirect_to @blogpost
    else
      render 'new'
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy
    respond_to do |format|
      format.html do
        redirect_to blog_url
      end
      format.js
    end
  end

  def edit
    @blogpost = BlogPost.find(params[:id])
  end

  def home
    @blog_posts = BlogPost.where(approved: true).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @blog_posts = BlogPost.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @blogpost = BlogPost.new
  end

  def show
    @blogpost = BlogPost.find(params[:id])
  end

  def update
    @blogpost = BlogPost.find(params[:id])
    unless current_user_admin?
      @blog_post.approved = false
    end
    if @blogpost.update_attributes(blogpost_params)
      flash[:success] = "Post actualizado correctamente"
      redirect_to @blogpost
    end
  end

  private

  def blogpost_params
    params.require(:blog_post).permit(:title, :content, :author, :proyecto_id)
  end

  def sort_column
    BlogPost.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def correct_user
    @user = BlogPost.find(params[:id]).user
    redirect_to(root_url) unless ((current_user?(@user) && @user.blog_editor?) || current_user.admin?)
  end

end
