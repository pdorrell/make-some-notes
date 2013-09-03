class HomeController < ApplicationController
  
  # Home page, which may include a notice that the user has to accept some
  # Terms and Conditions.
  # If a user is logged in, it will also display a list of the user's notes (by title).
  def index
    set_acceptance_required
    @notes = current_user ? current_user.notes : nil
  end

  # Page to display Terms and Conditions, with UI to accept them if the user is required
  # to accept them.
  def read_terms
    set_acceptance_required
    @latest_user_agreement = UserAgreement.get_current
  end
  
  # Action to accept the latest Terms and Conditions.
  def accept_terms_and_conditions
    puts "accept_terms_and_conditions, params = #{params.inspect}"
    authorize! :accept, UserAgreement
    user_agreement_version = params[:user_agreement][:version]
    @user_agreement = UserAgreement.find_by(version: user_agreement_version)
    current_user.accept_terms_and_conditions(@user_agreement)
    flash[:notice] = "Thank you for accepting the new terms and conditions."
    redirect_to root_path
  end
  
  private
  
  # Determine if the use needs to accept a new set of Terms and Conditions, based on
  # the record of which was the last Terms and Conditions they accepted.
  def set_acceptance_required
    @acceptance_required = current_user && !current_user.is_admin? && !current_user.has_accepted_latest_terms?
  end
    
end
