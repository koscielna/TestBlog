class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    htns = 0

    if created_at < 7.days.ago
      htns = 0
    elsif created_at < 3.days.ago
      htns = 1
    elsif created_at < 1.day.ago
      htns = 2
    else
      htns = 3
    end

    if comments.count >= 3
      htns += 1
      htns = 3 if htns > 3
    end

    return htns
  end

end
