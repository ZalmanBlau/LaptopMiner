class LaptopsController < ApplicationController

  def index 
    @raw_data = Waterfall.run(params["questions"])
  end 

  def search 
    @questions = Waterfall.questions
  end
end
