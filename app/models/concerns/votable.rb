module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def likes
    votes.where(mark: 1)
  end

  def dislikes
    votes.where(mark: -1)
  end

  def rating
    votes.sum(:mark)
  end
end
