require "rails_helper"

RSpec.describe OffersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/offers").to route_to("offers#index")
    end

    it "routes to #show" do
      expect(get: "/offers/1").to route_to("offers#show", id: "1")
    end

    it "routes to #new" do
      expect(get: "user/offers/new").to route_to("user_offers#new")
    end

    it "routes to #edit" do
      expect(get: "user/offers/1/edit").to route_to("user_offers#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "user/offers").to route_to("user_offers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "user/offers/1").to route_to("user_offers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "user/offers/1").to route_to("user_offers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "user/offers/1").to route_to("user_offers#destroy", id: "1")
    end
  end
end
