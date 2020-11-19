class Api::V1::ClaimsController < ApplicationController
  before_action :authorize_admin,only: [:destroy]
  before_action :authorize_agent,only: [:create]

  # POST /api/v1/tickets/:ticket_id/claim
  def create

    if @current_user.agent?
      @ticket = Ticket.find(params[:ticket_id])
      is_claimed = @current_user.claims.exists?(claimed_ticket:@ticket)
      if !is_claimed 
        
        @ticket.agents << @current_user
        @ticket.update(status:'working')
        response = { message: 'Ticket successfully claimed!'}
        render json: response
      else
          response = { message: 'Ticket already claimed! by an agent'}
          render json: response
      end
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end


  # DELETE /api/v1/tickets/:ticket_id/unclaim
  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @user = @ticket.agents
    @ticket.update(status:'open')
    @ticket.agents.delete(@user)
    response = { message: 'Ticket successfully unclaimed!'}
    render json: response
  end
  private

    def authorize_admin
      return unless !@current_user.admin?
      response = { message: 'Only Admin can have access!'}
      render json: response
    end
    def authorize_agent
      return unless !@current_user.agent?
      response = { message: 'Only Agent can have access!'}
      render json: response
    end
end
