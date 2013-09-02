class UserAgreementsController < ApplicationController
  before_action :set_user_agreement, only: [:show, :edit, :update, :destroy]

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
  def create
    @user_agreement = UserAgreement.new(user_agreement_params)

    respond_to do |format|
      if @user_agreement.save
        format.html { redirect_to @user_agreement, notice: 'User agreement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_agreement }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_agreement.errors, status: :unprocessable_entity }
      end
    end
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

  # DELETE /user_agreements/1
  # DELETE /user_agreements/1.json
  def destroy
    @user_agreement.destroy
    respond_to do |format|
      format.html { redirect_to user_agreements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_agreement
      @user_agreement = UserAgreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_agreement_params
      params.require(:user_agreement).permit(:text, :published_at)
    end
end
