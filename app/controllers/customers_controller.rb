class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    @user_type = 'Customers'
  end

  # GET /list_admins
  def list_admins
    if params[:type] == 'superadmin'
      @customers = Customer.find_other_superadmins(current_customer.id)
      @user_type = 'Superadmins'
    else
      if current_customer.role_check == 'superadmin'
        @customers = Customer.find_other_admins(0)
        @user_type = 'Admins'
      else
        @customers = Customer.find_other_admins(current_customer.id)
        @user_type = 'Admins'
      end
    end

  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @user_type = 'Customer'
  end

  def new_admin
    @customer = Customer.new
    @user_type = 'admin'
  end

  def new_superadmin
    @customer = Customer.new
    @user_type = 'superadmin'
  end

  # GET /customers/1/edit
  def edit
  end

  def create_admin
    @customer = Customer.new(customer_params)
    @customer.role_check = 'admin'
    respond_to do |format|
      if @customer.save
        format.html { redirect_to manage_admins_url, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_superadmin
    @customer = Customer.new(customer_params)
    @customer.role_check = 'superadmin'
    respond_to do |format|
      if @customer.save
        format.html { redirect_to manage_superadmins_url, notice: 'SuperAdmin was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      if current_customer.role_check != 'customer'
        format.html { redirect_to root_url, notice: 'User was successfully deleted.' }
      else
        format.html { redirect_to customers_url, notice: 'Customer was successfully deleted.' }
      end
      format.json { head :no_content }
    end
  end

  # GET /home
  def home
    @reservation = Reservation.find_user_reservation(current_customer.id)
    @current_user = Customer.find_by_id(current_customer.id)
  end

  #GET /manage_admins
  def manage_admins

  end

  #GET /manage_superadmins
  def manage_superadmins

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:email, :name, :password, :rental_charges)
    end
end
