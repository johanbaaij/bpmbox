class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :update, :destroy]

  # GET /releases
  def index
    @releases = Release.all

    render json: @releases
  end

  # GET /releases/1
  def show
    render json: @release
  end

  # POST /releases
  def create
    @release = Release.new(release_params)

    if @release.save
      render json: @release, status: :created, location: @release
    else
      render json: @release.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /releases/1
  def update
    if @release.update(release_params)
      render json: @release
    else
      render json: @release.errors, status: :unprocessable_entity
    end
  end

  # DELETE /releases/1
  def destroy
    @release.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def release_params
      params.require(:release).permit(:title, :artist_id)
    end
end
