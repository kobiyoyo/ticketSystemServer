class Api::V1::DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]
  before_action :authorize_admin,only: [:create,:destroy,:index,:show,:update]
 


 
  # GET api/v1/departments
  def index
    @departments = Department.all.order('created_at DESC')

    render json: @departments
  end

  # GET api/v1/departments/1
  def show
    render json: @department
  end

  # POST api/v1/departments
  def create
    @department = Department.new(department_params)

    if @department.save
      render json: @department, status: :created
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/departments/1
  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/v1/departments/1
  def destroy
    @department.destroy
    response = {message: 'Department successfully deleted'}
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def department_params
      params.permit(:title)
    end
    # authorize admin
    def authorize_admin
      return unless !@current_user.admin?
      response = { message: 'Only Admin can have access!'}
      render json: response
    end

end
