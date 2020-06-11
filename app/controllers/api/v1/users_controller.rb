class Api::V1::UsersController < ApplicationController
	skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_user,only: [:show, :update, :destroy]
  before_action :authorize_admin,only: [:destroy,:index,:show,:update,:create]
  
  # GET api/v1/users
  def index
    @users = User.all.order('created_at DESC')

    render json: @users
  end
  # POST /create
  def create
    @user = User.create(user_params)
   if @user.save
    response = { message: 'User created successfully by admin'}
    render json: response, status: :created 
   else
    render json: @user.errors, status: :unprocessable_entity
   end 
  end

  def show
  end

	# POST /register
  def register
    @user = User.create(user_params)
   if @user.save
    response = { message: 'User created successfully'}
    render json: response, status: :created 
   else
    render json: @user.errors, status: :unprocessable_entity
   end 
  end
  # DELETE api/v1/users/1
  def destroy
    @user.destroy
    response = {message: 'User successfully deleted'}
    render json: response
  end

  # PATCH/PUT api/v1/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  # POST /login
  def login
    authenticate params[:email], params[:password]
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password
    )
  end
  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end
       # authorize admin
    def authorize_admin
      return unless !@current_user.admin?
      response = { message: 'Only Admins can have access!'}
      render json: response
    end
end
