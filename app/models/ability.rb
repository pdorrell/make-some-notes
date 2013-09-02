class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.is_admin?
        can :manage, :all
      end
      can :read, Note
      if user.has_accepted_latest_terms?
        can :manage, Note
      end
      can :accept, UserAgreement
    end
  end
end
