class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, User, id: user.id
    end

    can :access, :dashboard if user.admin?
    can :access, :user_imports if user.admin?
  end
end
