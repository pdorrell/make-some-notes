class UserAgreementsController < ApplicationController
  before_action :set_user_agreement, only: [:show, :edit, :update, :publish]
  
  before_action :authorise_update, except: [:index, :show]
  before_action :authorise_read, only: [:index, :show]
  
  # Note: this page includes JSON methods created by scaffolding, but any JSON
  # functionality has not been tested at all.
  
  # GET /user_agreements
  # GET /user_agreements.json
  def index
    @versioned_document = VersionedDocument.get_versioned_document
    @published_version = @versioned_document.published_version
    @new_version = @versioned_document.new_version
    @user_agreements = UserAgreement.all
  end

  # GET /user_agreements/1
  # GET /user_agreements/1.json
  def show
  end

  # GET /user_agreements/1/edit
  def edit
  end

  # POST /user_agreements
  # POST /user_agreements.json
  def edit_new_version
    @user_agreement = UserAgreement.create_new_version()
    render "edit"
  end

  # PATCH/PUT /user_agreements/1
  # PATCH/PUT /user_agreements/1.json
  def update
    respond_to do |format|
      if @user_agreement.update(user_agreement_params)
        format.html { redirect_to @user_agreement, notice: 'User agreement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action to publish a user agreement.
  def publish
    puts "Publish user agreement #{@user_agreement.inspect}"
    @user_agreement.publish
    flash[:notice] = "Published #{@user_agreement.id}"
    redirect_to @user_agreement
  end
  
  private
  
  # Check CanCan authorisation to read a user agreement
  def authorise_read
    authorize! :read, UserAgreement
  end
  
  # Check CanCan authorisation to update a user agreement
  def authorise_update
    authorize! :update, UserAgreement
  end
  
  # For those actions that act on a particular user agreement, 
  # set the user agreement as specified by the "id" parameter.
  def set_user_agreement
    @user_agreement = UserAgreement.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_agreement_params
    params.require(:user_agreement).permit(:comment, :text)
  end
end
