class Public::SearchesController < ApplicationController
  # 検索
  def search
    @posts = Post.looks(params[:word]).page(params[:page]).per(10)
    # 投稿数
    @post_count = Post.looks(params[:word]).count
  end
end
