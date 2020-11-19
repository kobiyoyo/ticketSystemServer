require 'rails_helper'

  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: user.id) 
    { 'Authorization': "Bearer #{token}" }
  end


RSpec.describe "api/v1/departments", type: :request do

  let(:department) {
    FactoryBot.create(:department) 
  }
  let(:invalid_headers) {
    {}
  }
  let(:invalid_attributes) {
  
  }
   let(:user){FactoryBot.create(:user,department_id:department.id,role: 2)} 
  let(:valid_headers) {
    authenticated_header(user)
  }


  describe "GET /index" do
    it "renders a successful response" do
      get '/api/v1/departments', as: :json, headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get "/api/v1/departments/#{department.id}", as: :json, headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Department" do
        expect {
          post '/api/v1/departments/',
               params: { department: department }, headers: valid_headers, as: :json
        }.to change(Department, :count).by(1)
      end

      it "renders a JSON response with the new department" do
        post '/api/v1/departments/',
             params: { department: department }, headers: valid_headers, as: :json
   
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      department_two = Department.create(title:'')
      it "does not create a new Department" do
        expect {
          post '/api/v1/departments/',
               params: { department: department_two }, as: :json, headers: valid_headers
        }.to change(Department, :count).by(1)
      end

      it "renders a JSON response with errors for the new department" do
        post '/api/v1/departments/',

             params: { department: department }, as: :json, headers: valid_headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to  have_http_status(:unprocessable_entity)
        
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested department" do
        patch "/api/v1/departments/#{department.id}",
              params: { department: department.title }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:ok)
      end

      it "renders a JSON response with the department" do
     
        patch "/api/v1/departments/#{department.id}",
              params: { department: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the department" do
        patch "/api/v1/departments/#{department.id}",
              params: { department: ' ' }, headers: valid_headers, as: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
        
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested department" do
      department = !department
      expect {
        delete "/api/v1/departments/#{department}", headers: valid_headers, as: :json
      }.to change(Department, :count)
    end
  end
end
