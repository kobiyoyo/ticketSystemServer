class Api::V1::TicketsController < ApplicationController
  before_action :set_ticket, only: [:update, :destroy,:show]
  before_action :authorize_customer,only: [:create]
  before_action :authorize_agent,only: [:update,:closed_ticket_per_month]
  # GET api/v1/tickets

  def index
    if @current_user.agent?
       @tickets = Ticket.where(status: :open).order('created_at DESC').includes(:agents)
    elsif @current_user.customer?
      @tickets = @current_user.tickets.where(status: :open).order('created_at DESC').includes(:agents)
    else
      @tickets = Ticket.all.order('created_at DESC').includes(:agents)
    end
    render json: @tickets
  end
  # GET api/v1/tickets/closed_ticket_per_month
  def closed_ticket_per_month
    @tickets = Ticket.where(closed_at: 1.month.ago..)
    render json: @tickets
  end


   # GET api/v1/tickets/closed
  def closed
    display_tickets(:closed)
    render json: @tickets
  end

  # GET api/v1/tickets/working
  def working
    display_tickets(:working)
    render json: @tickets
  end

  # GET api/v1/tickets/rejected
  def rejected
    display_tickets(:rejected)
    render json: @tickets
  end

  # GET api/v1/tickets/resolved
  def resolved
    display_tickets(:resolved)
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
      response = { message: 'Only Customers can have access!'}
      render json: response
    end
    def authorize_agent
      return unless !@current_user.agent?
      response = { message: 'Only Agents can have access!'}
      render json: response
    end

    def display_tickets(stats)
        
        if @current_user.agent?
          
          @tickets = @current_user.claimed_tickets.where(status: stats).order('created_at DESC').includes(:agents)

        elsif @current_user.customer?
         
          @tickets = @current_user.tickets.where(status: stats).order('created_at DESC').includes(:agents)
 
        else 
          @tickets = Ticket.all.order('created_at DESC').includes(:agents)
         
        end
    end
end
