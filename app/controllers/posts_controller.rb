class PostsController < ApplicationController
  before_action :loged_in?

  def new
    @post = current_user.posts.build
  end
  
  def edit
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if post.save?
      flash[:notice] = "Пост создан"
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:picture, :name, :content)
  end
  
end
