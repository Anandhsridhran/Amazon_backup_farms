require 'test_helper'

class BarnsControllerTest < ActionController::TestCase
  setup do
    @barn = barns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barn" do
    assert_difference('Barn.count') do
      post :create, barn: { name: @barn.name }
    end

    assert_redirected_to barn_path(assigns(:barn))
  end

  test "should show barn" do
    get :show, id: @barn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @barn
    assert_response :success
  end

  test "should update barn" do
    put :update, id: @barn, barn: { name: @barn.name }
    assert_redirected_to barn_path(assigns(:barn))
  end

  test "should destroy barn" do
    assert_difference('Barn.count', -1) do
      delete :destroy, id: @barn
    end

    assert_redirected_to barns_path
  end
end
