require 'rails_helper'

  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: user.id) 
    { 'Authorization': "Bearer #{token}" }
  end

RSpec.describe "/tickets", type: :request do
   let(:department) {
    FactoryBot.create(:department) 
  }
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
  
  }
   let(:user){FactoryBot.create(:user,department_id:department.id,role: 2)} 
  let(:valid_headers) {
    authenticated_header(user)
  }

  describe "GET /index" do
    it "renders a successful response" do   
      get '/api/v1/tickets', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get ticket_url(ticket), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Ticket" do
        expect {
          post tickets_url,
               params: { ticket: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Ticket, :count).by(1)
      end

      it "renders a JSON response with the new ticket" do
        post tickets_url,
             params: { ticket: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Ticket" do
        expect {
          post tickets_url,
               params: { ticket: invalid_attributes }, as: :json
        }.to change(Ticket, :count).by(0)
      end

      it "renders a JSON response with errors for the new ticket" do
        post tickets_url,
             params: { ticket: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested ticket" do
        ticket = Ticket.create! valid_attributes
        patch ticket_url(ticket),
              params: { ticket: invalid_attributes }, headers: valid_headers, as: :json
        ticket.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the ticket" do
        ticket = Ticket.create! valid_attributes
        patch ticket_url(ticket),
              params: { ticket: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the ticket" do
        ticket = Ticket.create! valid_attributes
        patch ticket_url(ticket),
              params: { ticket: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested ticket" do
      ticket = Ticket.create! valid_attributes
      expect {
        delete ticket_url(ticket), headers: valid_headers, as: :json
      }.to change(Ticket, :count).by(-1)
    end
  end
end
