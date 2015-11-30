require 'rails_helper'

RSpec.describe "laptops/new", type: :view do
  before(:each) do
    assign(:laptop, Laptop.new())
  end

  it "renders new laptop form" do
    render

    assert_select "form[action=?][method=?]", laptops_path, "post" do
    end
  end
end
