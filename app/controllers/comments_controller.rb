class CommentsController < ApplicationController
  expose(:comment)

  def mark_as_not_abusive
    comment.update_attribute(:abusive, false)
    redirect_to comment.post
  end

  def vote_up
    comment.votes.find_or_create_by(value: 1, user: current_user)
    redirect_to comment.post
  end
end
