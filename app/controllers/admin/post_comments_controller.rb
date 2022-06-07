class Admin::PostCommentsController < ApplicationController
  #不適切なコメントの削除
  def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = "不適切なコメントを削除しました。"
    redirect_to request.referer
  end
end
