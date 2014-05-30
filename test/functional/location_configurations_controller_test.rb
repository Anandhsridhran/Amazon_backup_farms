require 'test_helper'

class LocationConfigurationsControllerTest < ActionController::TestCase
  setup do
    @location_configuration = location_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_configuration" do
    assert_difference('LocationConfiguration.count') do
      post :create, location_configuration: { building_temperature: @location_configuration.building_temperature, location_id: @location_configuration.location_id, propane_sensor_reset: @location_configuration.propane_sensor_reset, water_sensor_reset: @location_configuration.water_sensor_reset }
    end

    assert_redirected_to location_configuration_path(assigns(:location_configuration))
  end

  test "should show location_configuration" do
    get :show, id: @location_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location_configuration
    assert_response :success
  end

  test "should update location_configuration" do
    put :update, id: @location_configuration, location_configuration: { building_temperature: @location_configuration.building_temperature, location_id: @location_configuration.location_id, propane_sensor_reset: @location_configuration.propane_sensor_reset, water_sensor_reset: @location_configuration.water_sensor_reset }
    assert_redirected_to location_configuration_path(assigns(:location_configuration))
  end

  test "should destroy location_configuration" do
    assert_difference('LocationConfiguration.count', -1) do
      delete :destroy, id: @location_configuration
    end

    assert_redirected_to location_configurations_path
  end
end
