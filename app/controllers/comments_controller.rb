class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params) #przypisanie zezwolonych atrybutów do nowego obiektu komentarza
  expose(:post)

  def create
    comment.post = post
    comment.user = current_user
    comment.save

    redirect_to comment.post
  end

  def mark_as_not_abusive
    comment.update_attribute(:abusive, false)
    redirect_to comment.post
  end

  def vote_up
    comment.votes.find_or_create_by(value: 1, user: current_user)
    redirect_to comment.post
  end

  def vote_down
    comment.votes.find_or_create_by(value: -1, user: current_user)
    redirect_to comment.post
  end

  private

  def comment_params
    if params[:comment]
      params.require(:comment).permit(:body)
    end
  end
end
