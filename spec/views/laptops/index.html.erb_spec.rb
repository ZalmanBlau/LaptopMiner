require 'rails_helper'

RSpec.describe "laptops/index", type: :view do
  before(:each) do
    assign(:laptops, [
      Laptop.create!(),
      Laptop.create!()
    ])
  end

  it "renders a list of laptops" do
    render
  end
end
