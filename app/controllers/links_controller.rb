class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
    @import = Link::Import.new

    respond_to do |format|
      format.html
      format.csv { send_data @links.to_csv, filename: "UTM-links-#{Date.today}.csv" }
    end
  end

  def import
    @import = Link::Import.new link_import_params
    if @import.save
      redirect_to links_path, notice: "Imported #{@import.imported_count} links."
    else
      @links = Link.all
      flash[:alert] = "There were #{@import.errors.count} errors with your CSV file."
      render action: :index 
    end
    # count = Link.import params[:file]
    # redirect_to links_path, notice: "Imported #{count} links"
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def link_import_params
      params.require(:link_import).permit(:file)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :reg_url, :src_name, :pfm_name, :opt_identifier, :final_url)
    end
end
