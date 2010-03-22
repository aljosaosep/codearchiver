require 'test_helper'

class ProgramLanguagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_language" do
    assert_difference('ProgramLanguage.count') do
      post :create, :program_language => { }
    end

    assert_redirected_to program_language_path(assigns(:program_language))
  end

  test "should show program_language" do
    get :show, :id => program_languages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => program_languages(:one).to_param
    assert_response :success
  end

  test "should update program_language" do
    put :update, :id => program_languages(:one).to_param, :program_language => { }
    assert_redirected_to program_language_path(assigns(:program_language))
  end

  test "should destroy program_language" do
    assert_difference('ProgramLanguage.count', -1) do
      delete :destroy, :id => program_languages(:one).to_param
    end

    assert_redirected_to program_languages_path
  end
end
