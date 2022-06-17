class Public::HomesController < ApplicationController
  # トップページ
  def top
    # 新着順に6つ表示
    @posts = Post.order("id DESC").limit(6)
  end
end
