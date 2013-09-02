require 'test_helper'

class UserAgreementsControllerTest < ActionController::TestCase
  setup do
    @user_agreement = user_agreements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_agreements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_agreement" do
    assert_difference('UserAgreement.count') do
      post :create, user_agreement: { published_at: @user_agreement.published_at, text: @user_agreement.text }
    end

    assert_redirected_to user_agreement_path(assigns(:user_agreement))
  end

  test "should show user_agreement" do
    get :show, id: @user_agreement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_agreement
    assert_response :success
  end

  test "should update user_agreement" do
    patch :update, id: @user_agreement, user_agreement: { published_at: @user_agreement.published_at, text: @user_agreement.text }
    assert_redirected_to user_agreement_path(assigns(:user_agreement))
  end

  test "should destroy user_agreement" do
    assert_difference('UserAgreement.count', -1) do
      delete :destroy, id: @user_agreement
    end

    assert_redirected_to user_agreements_path
  end
end
