require 'test_helper'

class ControllerAdminsControllerTest < ActionController::TestCase
  setup do
    @controller_admin = controller_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:controller_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create controller_admin" do
    assert_difference('ControllerAdmin.count') do
      post :create, controller_admin: { location_id: @controller_admin.location_id }
    end

    assert_redirected_to controller_admin_path(assigns(:controller_admin))
  end

  test "should show controller_admin" do
    get :show, id: @controller_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @controller_admin
    assert_response :success
  end

  test "should update controller_admin" do
    put :update, id: @controller_admin, controller_admin: { location_id: @controller_admin.location_id }
    assert_redirected_to controller_admin_path(assigns(:controller_admin))
  end

  test "should destroy controller_admin" do
    assert_difference('ControllerAdmin.count', -1) do
      delete :destroy, id: @controller_admin
    end

    assert_redirected_to controller_admins_path
  end
end
