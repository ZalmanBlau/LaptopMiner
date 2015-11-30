require "rails_helper"

RSpec.describe LaptopsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/laptops").to route_to("laptops#index")
    end

    it "routes to #new" do
      expect(:get => "/laptops/new").to route_to("laptops#new")
    end

    it "routes to #show" do
      expect(:get => "/laptops/1").to route_to("laptops#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/laptops/1/edit").to route_to("laptops#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/laptops").to route_to("laptops#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/laptops/1").to route_to("laptops#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/laptops/1").to route_to("laptops#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/laptops/1").to route_to("laptops#destroy", :id => "1")
    end

  end
end
