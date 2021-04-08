class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    can :read, :all
    can :create,  [Question, Answer, Comment]
    can :update,  [Question, Answer], user: user
    can :destroy, [Question, Answer], user: user
    can :toogle_notify, [Question], user: user
    can :like,    [Question, Answer] do |votable|
      votable.user_id != user.id
    end
    can :dislike, [Question, Answer] do |votable|
      votable.user_id != user.id
    end
    can :unvote, [Question, Answer] do |votable|
      votable.user_id != user.id
    end
    can :make_best, Answer do |answer|
      user.author_of?(answer.question)
    end
    can :destroy, Attachment do |attachment|
      attachment.attachable.user_id == user.id
    end
  end
end