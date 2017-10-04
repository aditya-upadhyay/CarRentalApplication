class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    if(current_customer.role_check == 'admin')
      @reservations = Reservation.all
    else
     @reservations = Reservation.find_by_customer(current_customer)
     if @reservations.empty?
       flash[:notice] = "No reservations made"
     end
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @reserve_car_id = params[:id]
  end

  # GET /reservations/1/edit
  def edit
    puts @reservation.inspect
    @reserve_car_id = @reservation.car_id
  end

  #GET /checkout
  def checkout
    @reservation = Reservation.find_by_id(params[:id])
    Car.find_by_id(@reservation.car_id).update_attribute(:status, 'Checkedout')
    flash[:notice]='Car successfully checkout.'
    redirect_to root_path
  end

  #GET /return_car
  def return_car
    @reservation = Reservation.find_by_id(params[:id])
    @car = Car.find_by_id(@reservation.car_id)
    reservation_duration = ((@reservation.return_time-@reservation.checkout_time)/3600).to_f;
    @rental_charges = reservation_duration * @car.hourly_rental_rate
    @car.update_attribute(:status, 'Available')
    @user = Customer.find_by_id(@reservation.customer_id)
    @user.update_attribute(:rental_charges, @rental_charges+@user.rental_charges)

    flash[:notice]='Car successfully returned.'
    redirect_to root_path
  end

  # POST /reservations
  # POST /reservations.json
  def create

    @reservation = Reservation.new(reservation_params)
    @reservation.customer = current_customer

    @reservation.car_id = reservation_params[:car_id]

    Car.find_by_id(reservation_params[:car_id]).update_attribute(:status, "Reserved")

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    puts @reservation.inspect
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:checkout_time, :return_time, :customer_id, :car_id)
    end
end
