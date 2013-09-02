class HomeController < ApplicationController
  def index
    set_acceptance_required
    @notes = current_user ? current_user.notes : nil
  end
  
  def read_terms
    set_acceptance_required
    @latest_user_agreement = UserAgreement.get_current
  end
  
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
  
  def set_acceptance_required
    @acceptance_required = current_user && !current_user.is_admin? && !current_user.has_accepted_latest_terms?
  end
    
end
