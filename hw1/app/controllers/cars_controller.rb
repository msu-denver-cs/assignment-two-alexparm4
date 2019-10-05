class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
    @parts = Part.all     #When a new car object is to be created,
                        #this evocation will allow any existing parts
                        #to be selected at creation time.  
                        #Citation: Guided by 03ActiveRecord PPP slide 33
  end

  # GET /cars/1/edit
  def edit
    @parts = Part.all     #When a new car object is to be edited,
                          #this evocation will allow any existing parts
                          #to be selected at the time of the edit.
                          #Citation: Guided by 03ActiveRecord PPP slide 33
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:make_id, :model, :vin, :part_ids=>[])
                                              #Most of this line was auto-generated, however
                                              #', :part_ids=>[]' is added to force a Car object
                                              #to also need Part(s).
                                              #Citation: Guided by 03ActiveRecord PPP slide 33
    end
end
