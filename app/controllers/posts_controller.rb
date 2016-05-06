class PostsController < ApplicationController
  
  def new
    @post = current_user.posts.build
  end
  
  def edit
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
  
end
