class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    @schedules = current_user.schedules

    if params[:query].present?
      query = "%#{params[:query].downcase}%"
      @schedules = @schedules.joins(:art, :location)
                             .where("LOWER(schedules.date) LIKE ? OR LOWER(arts.title) LIKE ? OR LOWER(locations.name_of_place) LIKE ? OR LOWER(locations.address) LIKE ?", query, query, query, query)
    end
  end


  def show
    # @schedule is set by the set_schedule method
  end


  def new
    @schedule = current_user.schedules.build
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)

    puts "Location ID: #{@schedule.location_id}" # Debugging output

    if @schedule.save
      redirect_to schedules_path, notice: ''
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path, notice: ''
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_url, notice: ''
  rescue ActiveRecord::RecordNotFound
    redirect_to schedules_url, alert: 'Schedule not found.'
  end

  # Select arts to be converted to PDF =============================================================
  def select_for_pdf
    @schedules = current_user.schedules
  end

  # PDF Converter
  def download_pdf
    selected_schedule_ids = params[:schedule_ids] # Array of selected art IDs
    @schedules = Schedule.where(id: selected_schedule_ids)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Schedules_Report",  # PDF filename
               template: "schedules/pdf_template", # Path to the PDF template
               layout: 'layouts/pdf',  # Optional: Use a specific layout for PDF
               locals: { schedules: @schedules },  # Pass selected arts to the template
               disposition: 'attachment'  # This ensures the file is downloaded
      end
    end
  end

  # Calendar View
  def events
    @schedules = current_user.schedules

    events = @schedules.map do |schedule|
      {
        id: schedule.id,
        title: schedule.location.present? ? "#{schedule.location.name_of_place}, #{schedule.location.address}" : "Location Removed",
        start: schedule.date,
        extendedProps: {
          location: schedule.location.present? ? "#{schedule.location.name_of_place} - #{schedule.location.address}" : "Location Removed",
          description: schedule.description,
          art_title: schedule.art&.title || "No Art Title"
        }
      }
    end

    render json: events
  end


  private

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to schedules_url, alert: 'Schedule not found.'
  end

  def schedule_params
    params.require(:schedule).permit(:date, :location_id, :description, :art_id)
  end
end
