# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # can :manage, :session
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      cannot :manage, :all
      can :manage, Post, user_id: user.id
      can :manage, User, id: user.id
      cannot :index, User
    end
  end
end
