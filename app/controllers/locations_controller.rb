class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @query = params[:query].to_s.downcase
    if @query.present?
      @locations = current_user.locations.where(
        'LOWER(name_of_place) LIKE ? OR LOWER(address) LIKE ? OR LOWER(email) LIKE ?',
        "%#{@query}%", "%#{@query}%", "%#{@query}%"
      )
    else
      @locations = current_user.locations
    end
  end


  def show
    @location = Location.find(params[:id])
    @schedules = @location.schedules
    # @location is set by the before_action
  end

  def new
    @location = Location.new
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @location = current_user.locations.build(location_params)
    if @location.save
      redirect_to locations_path, notice: ''
    else
      render :new
    end
  end



  # PATCH/PUT /locations/1
  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to @location, notice: ""
    else
      render :edit
    end
  end

  def destroy
    @location = current_user.locations.find(params[:id])
    @location.destroy
    redirect_to locations_path, notice: ''
  end


  # Select arts to be converted to PDF =============================================================
  def select_for_pdf
    @locations = current_user.locations
  end

  # PDF Converter
  def download_pdf
    selected_location_ids = params[:location_ids] # Array of selected art IDs
    @locations = Location.where(id: selected_location_ids)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Location_Report",  # PDF filename
               template: "locations/pdf_template", # Path to the PDF template
               layout: 'layouts/pdf',  # Optional: Use a specific layout for PDF
               locals: { locations: @locations },  # Pass selected arts to the template
               disposition: 'attachment'  # This ensures the file is downloaded
      end
    end
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end


  def location_params
    params.require(:location).permit(:name_of_place, :address, :email, :phone_number, :notes)
  end
end
