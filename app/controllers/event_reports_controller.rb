class EventReportsController < ApplicationController

  before_filter :require_user
  
  # GET /event_reports
  # GET /event_reports.json
  def index
    if (params[:location_id])
      @event_reports = Location.find(params[:location_id]).event_reports
    else
      @event_reports = EventReport.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_reports }
    end
  end

  # GET /event_reports/1
  # GET /event_reports/1.json
  def show
    @event_report = EventReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_report }
    end
  end

  # GET /event_reports/new
  # GET /event_reports/new.json
  def new
    @event_report = EventReport.new
    @locations = Location.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_report }
    end
  end

  # GET /event_reports/1/edit
  def edit
    @event_report = EventReport.find(params[:id])
    @locations = Location.all
  end

  # POST /event_reports
  # POST /event_reports.json
  def create
    @event_report = EventReport.new(params[:event_report])

    respond_to do |format|
      if @event_report.save
        # Notify people about the event        
        
        users = @event_report.location.farm.users
        users.each {|u| u.notify(@event_report)}

        format.html { redirect_to @event_report, notice: 'Event report was successfully created.' }
        format.json { render json: @event_report, status: :created, location: @event_report }
      else
        format.html { render action: "new" }
        format.json { render json: @event_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_reports/1
  # PUT /event_reports/1.json
  def update
    @event_report = EventReport.find(params[:id])

    respond_to do |format|
      if @event_report.update_attributes(params[:event_report])
        format.html { redirect_to @event_report, notice: 'Event report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_reports/1
  # DELETE /event_reports/1.json
  def destroy
    @event_report = EventReport.find(params[:id])
    @event_report.destroy

    respond_to do |format|
      format.html { redirect_to event_reports_url }
      format.json { head :no_content }
    end
  end

  
end
