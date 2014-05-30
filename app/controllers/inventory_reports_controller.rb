class InventoryReportsController < ApplicationController

  before_filter :require_user

  # GET /inventory_reports
  # GET /inventory_reports.json
  def index
    @inventory_reports = InventoryReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_reports }
    end
  end

  # GET /inventory_reports/1
  # GET /inventory_reports/1.json
  def show
    @inventory_report = InventoryReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_report }
    end
  end

  # GET /inventory_reports/new
  # GET /inventory_reports/new.json
  def new
    @inventory_report = InventoryReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_report }
    end
  end

  # GET /inventory_reports/1/edit
  def edit
    @inventory_report = InventoryReport.find(params[:id])
  end

  # POST /inventory_reports
  # POST /inventory_reports.json
  def create
    @inventory_report = InventoryReport.new(params[:inventory_report])
    @barn = @inventory_report.barn
    @inventory_report.pig_deaths.each {|p| @barn.total_pigs -= p.count}
    
    respond_to do |format|
      if @inventory_report.save
        @barn.save
        format.html { redirect_to @inventory_report, notice: 'Inventory report was successfully created.' }
        format.json { render json: @inventory_report, status: :created, location: @inventory_report }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_reports/1
  # PUT /inventory_reports/1.json
  def update
    @inventory_report = InventoryReport.find(params[:id])

    respond_to do |format|
      if @inventory_report.update_attributes(params[:inventory_report])
        format.html { redirect_to @inventory_report, notice: 'Inventory report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_reports/1
  # DELETE /inventory_reports/1.json
  def destroy
    @inventory_report = InventoryReport.find(params[:id])
    @inventory_report.destroy

    respond_to do |format|
      format.html { redirect_to inventory_reports_url }
      format.json { head :no_content }
    end
  end
end
