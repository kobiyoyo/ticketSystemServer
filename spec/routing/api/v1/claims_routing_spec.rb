require "rails_helper"

RSpec.describe Api::V1::ClaimsController, type: :routing do
  describe "routing" do


    it "routes to #create" do
      expect(post: "api/v1/tickets/1/claim").to route_to("api/v1/claims#create",ticket_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/tickets/1/unclaim").to route_to("api/v1/claims#destroy", ticket_id: "1")
    end
  end
end
