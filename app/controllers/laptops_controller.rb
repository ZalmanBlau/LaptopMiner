class LaptopsController < ApplicationController

  def index 
    binding.pry
    @raw_data = Waterfall.run(params["questions"])
  end 

  def search 
    @questions = Waterfall.questions
  end
end
