class LaptopsController < ApplicationController

  def index 
    binding.pry
    #example questions =  {"price"=>"a", "speed"=>"b", "size"=>"b", "storage"=>"b"}
    #Waterfall.run(questions)
    @raw_data = Waterfall.run(params["questions"])
  end 

  def search 
    @questions = Waterfall.questions
  end
end
