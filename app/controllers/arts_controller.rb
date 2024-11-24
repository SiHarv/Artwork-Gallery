class ArtsController < ApplicationController
  before_action :set_art, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!  # Ensure the user is logged in

  # GET /arts or /arts.json
  def index
    @arts = current_user.arts

    # Filter by search query
    if params[:query].present?
      @arts = @arts.where("title LIKE ?", "%#{params[:query]}%")
    end

    # Sorting logic
    if params[:sort_by].present?
      case params[:sort_by]
      when "title_asc"
        @arts = @arts.order(title: :asc)
      when "title_desc"
        @arts = @arts.order(title: :desc)
      when "created_at_asc"
        @arts = @arts.order(created_at: :asc)
      when "created_at_desc"
        @arts = @arts.order(created_at: :desc)
      when "price_asc"
        @arts = @arts.order(price: :asc)
      when "price_desc"
        @arts = @arts.order(price: :desc)
      when "medium_asc"
        @arts = @arts.order(medium: :asc)
      when "medium_desc"
        @arts = @arts.order(medium: :desc)
      end
    end
    @view_type = params[:view_type] || "tile"

    # Type of Art filtering
    if params[:type_of_art].present? && params[:type_of_art] != 'All'
      @arts = @arts.where(type_of_art: params[:type_of_art])
    end
    @view_type = params[:view_type] || "tile"
  end


  # GET /arts/1 or /arts/1.json
  def show
  end

  # GET /arts/new
  def new
    @art = Art.new
  end

  # GET /arts/1/edit
  def edit
  end

  # POST /arts or /arts.json
  def create
    @art = current_user.arts.build(art_params)

    respond_to do |format|
      if @art.save
        format.html { redirect_to art_url(@art), notice: "" }
        format.json { render :show, status: :created, location: @art }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arts/1 or /arts/1.json
  def update
    respond_to do |format|
      if art_params[:images].present?
        # New images are uploaded
        @art.images.attach(art_params[:images])
      else
        # No new images uploaded, preserve existing images
        existing_image_ids = params[:art][:existing_images].split(',')
        existing_images = ActiveStorage::Blob.where(id: existing_image_ids)
        @art.images.attach(existing_images)
      end

      if @art.update(art_params.except(:images, :existing_images))
        format.html { redirect_to art_url(@art), notice: '' }
        format.json { render :show, status: :ok, location: @art }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end




  # DELETE /arts/1 or /arts/1.json
  def destroy
    begin
      @art.destroy!
      respond_to do |format|
        format.html { redirect_to arts_url, notice: "Art was successfully deleted." }
        format.json { head :no_content }
      end
    rescue ActiveRecord::RecordNotDestroyed
      respond_to do |format|
        format.html { redirect_to arts_url, alert: "Delete the schedule with this art first." }
        format.json { render json: { error: "Failed to delete art" }, status: :unprocessable_entity }
      end
    end
  end



  # Select arts to be converted to PDF =============================================================
  def select_for_pdf
    @arts = current_user.arts
  end

  # PDF Converter
  def download_pdf
    selected_art_ids = params[:art_ids] # Array of selected art IDs
    @arts = Art.where(id: selected_art_ids)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "arts_collection",  # PDF filename
               template: "arts/pdf_template", # Path to the PDF template
               layout: 'layouts/pdf',  # Optional: Use a specific layout for PDF
               locals: { arts: @arts },  # Pass selected arts to the template
               disposition: 'attachment'  # This ensures the file is downloaded
      end
    end
  end
  # render pdf: "index",   # PDF filename
               #template: "arts/index", # Path to the template
                #layout: 'layouts/pdf'   # Optional: Use a specific layout for PDF




  private


    # Use callbacks to share common setup or constraints between actions.
    def set_art
      @art = current_user.arts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def art_params
      params.require(:art).permit(:title, :body, :price, :medium, :video, :status, :type_of_art, :dimension, images: [], existing_images: [])
    end
end
