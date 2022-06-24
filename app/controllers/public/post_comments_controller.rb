class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user

  # コメント投稿
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      render "public/post_comments/post_comment"
    else
      render "public/posts/show"
    end
  end

  # コメント削除
  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    render "public/post_comments/post_comment"
  end

  private
  # ストロングパラメータ
  def post_comment_params
    params.require(:post_comment).permit(:comment, :rate)
  end

  # ゲストユーザーの利用制限のアクション
  def ensure_guest_user
    if current_user.name == 'ゲストユーザー'
      redirect_to request.referer, notice: 'ゲストユーザーでは利用できない機能です'
    end
  end
end
