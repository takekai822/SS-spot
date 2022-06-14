class Public::SearchesController < ApplicationController
  def search
    @posts = Post.looks(params[:word]).page(params[:page]).per(10)
  end
end
