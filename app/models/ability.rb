class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin?
        can :manage, :all
      end
      can :read, Note
      can :edit
      can :manage, Note
      can :accept, UserAgreement
    end
  end
end
