class AdminController < ApplicationController

  def index
  end

  def posts
    @posts = Post.includes(:user)
  end

  def comments
  end

  def users
  end

  def show_post
    @post = Post.includes(:user).find(params[:id])
  end

end
