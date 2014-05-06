class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :user
  belongs_to :post
  has_many :votes

  validates_presence_of :body

  def is_abusive
    if votes.where(value: -1).count >= 3
      update_attribute(:abusive, true)
    end
  end

  def positive_votes
    votes.where(value: 1).count
  end

  def negative_votes
    votes.where(value: -1).count
  end
end
