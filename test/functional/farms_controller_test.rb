require 'test_helper'

class FarmsControllerTest < ActionController::TestCase
  setup do
    @farm = farms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:farms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create farm" do
    assert_difference('Farm.count') do
      post :create, farm: { city: @farm.city, name: @farm.name, postal_code: @farm.postal_code, state: @farm.state, street_address: @farm.street_address }
    end

    assert_redirected_to farm_path(assigns(:farm))
  end

  test "should show farm" do
    get :show, id: @farm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @farm
    assert_response :success
  end

  test "should update farm" do
    put :update, id: @farm, farm: { city: @farm.city, name: @farm.name, postal_code: @farm.postal_code, state: @farm.state, street_address: @farm.street_address }
    assert_redirected_to farm_path(assigns(:farm))
  end

  test "should destroy farm" do
    assert_difference('Farm.count', -1) do
      delete :destroy, id: @farm
    end

    assert_redirected_to farms_path
  end
end
