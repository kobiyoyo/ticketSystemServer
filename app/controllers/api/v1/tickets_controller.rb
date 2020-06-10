class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :update, :destroy]
  before_action :authorize_customer,only: [:create]
  # GET api/v1/tickets
  def index
    @tickets = Ticket.all

    render json: @tickets
  end

  # GET api/v1/tickets/1
  def show
    render json: @ticket
  end

  # POST api/v1/tickets
  def create
    @ticket = @current_user.tickets.build(ticket_params)
    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/tickets/1
  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/v1/tickets/1
  def destroy
    @ticket.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.permit(:department_id, :priority, :message, :subject, :status, :ticket_no, :user_id)
    end
    def authorize_customer
      return unless !@current_user.customer?
      response = { message: 'Only customers can have access!'}
      render json: response
    end
end
