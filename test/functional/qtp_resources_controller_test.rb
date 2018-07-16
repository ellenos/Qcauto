require 'test_helper'

class QtpResourcesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qtp_resources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qtp_resource" do
    assert_difference('QtpResource.count') do
      post :create, :qtp_resource => { }
    end

    assert_redirected_to qtp_resource_path(assigns(:qtp_resource))
  end

  test "should show qtp_resource" do
    get :show, :id => qtp_resources(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => qtp_resources(:one).to_param
    assert_response :success
  end

  test "should update qtp_resource" do
    put :update, :id => qtp_resources(:one).to_param, :qtp_resource => { }
    assert_redirected_to qtp_resource_path(assigns(:qtp_resource))
  end

  test "should destroy qtp_resource" do
    assert_difference('QtpResource.count', -1) do
      delete :destroy, :id => qtp_resources(:one).to_param
    end

    assert_redirected_to qtp_resources_path
  end
end
