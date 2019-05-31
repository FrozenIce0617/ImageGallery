class PinsController < ApplicationController
  before_action :set_pin, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1
  # GET /pins/1.json
  def show; end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit; end

  # POST /pins
  # POST /pins.json
  def create
    @pin = current_user.pins.build(pin_params)
    # @pin = Pin.new(pin_params)

    respond_to do |format|
      if @pin.save
        format.html do
          redirect_to @pin, notice: 'Pin was successfully created.'
        end
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html do
          redirect_to @pin, notice: 'Pin was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html do
        redirect_to pins_url, notice: 'Pin was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pin
    @pin = Pin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pin_params
    params.require(:pin).permit(:description, :image)
  end
end

def correct_user
  @pin = current_user.pins.find_by(id: params[:id])
  redirect_to pins_path, notice: 'Not authorized to edit this pin' if @pin.nil?
end
