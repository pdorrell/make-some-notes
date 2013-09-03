class Ability
  include CanCan::Ability

  # Rules for who can do what:
  # Admin user can do anything
  # All logged in users can read notes
  # Logged in users who have accepted the required terms and conditions
  # (or admin user who doesn't have to accept them) can create/edit/delete notes.
  # All logged in users can accept a version of terms and conditions
  #
  # Note: all controller methods for retrieving or acting on notes (by id or otherwise) 
  # retrieve only notes that belong to the user, so there is no additional check for ownership here.
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
