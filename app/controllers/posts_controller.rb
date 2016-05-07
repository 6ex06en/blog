class PostsController < ApplicationController
  before_action :loged_in?
  before_action ->(id = params[:id]){ post_owner?(id) }, except: [:new, :create]


  def new
    @post = current_user.posts.build
  end

  def show
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Пост создан"
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Пост обновлен"
      redirect_to :back
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:picture, :name, :content)
  end

  def post_owner?(params_id)
    @post = Post.find_by(id: params_id)
    redirect_to root_path unless @post && owner?(@post)
  end

end
