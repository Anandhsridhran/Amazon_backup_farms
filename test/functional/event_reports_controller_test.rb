require 'test_helper'

class EventReportsControllerTest < ActionController::TestCase
  setup do
    @event_report = event_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_report" do
    assert_difference('EventReport.count') do
      post :create, event_report: { event_code: @event_report.event_code, event_description: @event_report.event_description, input_value: @event_report.input_value, location_id: @event_report.location_id, output_value: @event_report.output_value }
    end

    assert_redirected_to event_report_path(assigns(:event_report))
  end

  test "should show event_report" do
    get :show, id: @event_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_report
    assert_response :success
  end

  test "should update event_report" do
    put :update, id: @event_report, event_report: { event_code: @event_report.event_code, event_description: @event_report.event_description, input_value: @event_report.input_value, location_id: @event_report.location_id, output_value: @event_report.output_value }
    assert_redirected_to event_report_path(assigns(:event_report))
  end

  test "should destroy event_report" do
    assert_difference('EventReport.count', -1) do
      delete :destroy, id: @event_report
    end

    assert_redirected_to event_reports_path
  end
end
