require 'test_helper'

class InventoryReportsControllerTest < ActionController::TestCase
  setup do
    @inventory_report = inventory_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_report" do
    assert_difference('InventoryReport.count') do
      post :create, inventory_report: { barn_id: @inventory_report.barn_id, cause_of_death: @inventory_report.cause_of_death, dosage: @inventory_report.dosage, how_administered: @inventory_report.how_administered, medicine_given: @inventory_report.medicine_given, report_date: @inventory_report.report_date, total_pig_deaths: @inventory_report.total_pig_deaths, total_pigs_treated: @inventory_report.total_pigs_treated, user_initials: @inventory_report.user_initials }
    end

    assert_redirected_to inventory_report_path(assigns(:inventory_report))
  end

  test "should show inventory_report" do
    get :show, id: @inventory_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_report
    assert_response :success
  end

  test "should update inventory_report" do
    put :update, id: @inventory_report, inventory_report: { barn_id: @inventory_report.barn_id, cause_of_death: @inventory_report.cause_of_death, dosage: @inventory_report.dosage, how_administered: @inventory_report.how_administered, medicine_given: @inventory_report.medicine_given, report_date: @inventory_report.report_date, total_pig_deaths: @inventory_report.total_pig_deaths, total_pigs_treated: @inventory_report.total_pigs_treated, user_initials: @inventory_report.user_initials }
    assert_redirected_to inventory_report_path(assigns(:inventory_report))
  end

  test "should destroy inventory_report" do
    assert_difference('InventoryReport.count', -1) do
      delete :destroy, id: @inventory_report
    end

    assert_redirected_to inventory_reports_path
  end
end
