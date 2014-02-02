class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  after_create :update_comment_abusiveness

  belongs_to :user
  belongs_to :comment

  private
  def update_comment_abusiveness
    comment.is_abusive
  end
end
