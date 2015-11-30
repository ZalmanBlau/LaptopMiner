require 'rails_helper'

RSpec.describe "laptops/edit", type: :view do
  before(:each) do
    @laptop = assign(:laptop, Laptop.create!())
  end

  it "renders the edit laptop form" do
    render

    assert_select "form[action=?][method=?]", laptop_path(@laptop), "post" do
    end
  end
end
