class ScreeningsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_screening, only: [:show, :edit, :update, :destroy]

  def index
    @screenings = Screening.all
  end

  def show
  end

  def new
    @screening = Screening.new
  end

  def edit
  end

  def create
    @screening = Screening.new(screening_params)

    respond_to do |format|
      if @screening.save
        format.html { redirect_to @screening, notice: 'Screening was successfully created.' }
        format.json { render :show, status: :created, location: @screening }
      else
        format.html { render :new }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @screening.update(screening_params)
        format.html { redirect_to @screening, notice: 'Screening was successfully updated.' }
        format.json { render :show, status: :ok, location: @screening }
      else
        format.html { render :edit }
        format.json { render json: @screening.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @screening.destroy
    respond_to do |format|
      format.html { redirect_to screenings_url, notice: 'Screening was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_screening
      @screening = Screening.find(params[:id])
    end

    def screening_params
      params.require(:screening).permit(:movie_id, :room_id, :date)
    end
end
