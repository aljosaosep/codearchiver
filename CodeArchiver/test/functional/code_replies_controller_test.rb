require 'test_helper'

class CodeRepliesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:code_replies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code_reply" do
    assert_difference('CodeReply.count') do
      post :create, :code_reply => { }
    end

    assert_redirected_to code_reply_path(assigns(:code_reply))
  end

  test "should show code_reply" do
    get :show, :id => code_replies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => code_replies(:one).to_param
    assert_response :success
  end

  test "should update code_reply" do
    put :update, :id => code_replies(:one).to_param, :code_reply => { }
    assert_redirected_to code_reply_path(assigns(:code_reply))
  end

  test "should destroy code_reply" do
    assert_difference('CodeReply.count', -1) do
      delete :destroy, :id => code_replies(:one).to_param
    end

    assert_redirected_to code_replies_path
  end
end
