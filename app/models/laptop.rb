class Laptop < ActiveRecord::Base
  validates :name, uniqueness: true
end
