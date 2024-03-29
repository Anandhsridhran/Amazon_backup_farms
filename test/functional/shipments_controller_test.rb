require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  setup do
    @shipment = shipments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post :create, shipment: { barn_id: @shipment.barn_id, pig_supplier: @shipment.pig_supplier, shipment_date: @shipment.shipment_date, total_doa: @shipment.total_doa, total_pigs: @shipment.total_pigs }
    end

    assert_redirected_to shipment_path(assigns(:shipment))
  end

  test "should show shipment" do
    get :show, id: @shipment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipment
    assert_response :success
  end

  test "should update shipment" do
    put :update, id: @shipment, shipment: { barn_id: @shipment.barn_id, pig_supplier: @shipment.pig_supplier, shipment_date: @shipment.shipment_date, total_doa: @shipment.total_doa, total_pigs: @shipment.total_pigs }
    assert_redirected_to shipment_path(assigns(:shipment))
  end

  test "should destroy shipment" do
    assert_difference('Shipment.count', -1) do
      delete :destroy, id: @shipment
    end

    assert_redirected_to shipments_path
  end
end
