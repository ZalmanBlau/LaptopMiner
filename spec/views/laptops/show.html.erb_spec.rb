require 'rails_helper'

RSpec.describe "laptops/show", type: :view do
  before(:each) do
    @laptop = assign(:laptop, Laptop.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
