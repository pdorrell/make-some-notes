class UserAgreementsController < ApplicationController
  before_action :set_user_agreement, only: [:show, :edit, :update, :publish]

  # GET /user_agreements
  # GET /user_agreements.json
  def index
    @user_agreements = UserAgreement.all
  end

  # GET /user_agreements/1
  # GET /user_agreements/1.json
  def show
  end

  # GET /user_agreements/new
  def new
    @user_agreement = UserAgreement.new
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
  
  def publish
    puts "Publish user agreement #{@user_agreement.inspect}"
    flash[:notice] = "Pretended to publish #{@user_agreement.id}"
    redirect_to @user_agreement
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_agreement
      @user_agreement = UserAgreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_agreement_params
      params.require(:user_agreement).permit(:comment, :text)
    end
end
