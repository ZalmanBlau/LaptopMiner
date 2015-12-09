class Waterfall

  def initialize(answers) 
    @answers = answers
  end

  attr_accessor :answers, :price
  attr_reader :feature_quality, :amazon_data

  def self.run(answers)
    @water_fall = Waterfall.new(answers)
    @water_fall.fire_search
  end

  def self.questions
    {
      price: {
        description: "How much would you like to spend?",
        options: [
          "$200 - $450 (low end)",
          "$450 - $700 (recommended)",
          "$700 - $1500 (pretty good stuff)",
          "$1500 - $3500 (super awesome stuff)"
        ]
      },
      speed: {
        description: "How much computing power do you need?",
        options: [
          "Not important. I just need a computer that works decently",
          "A decent amount will do the job. I'm mostly browsing the internet or using lightweight applications",
          "I'm a frequent user of heavy applications like Adobe Photoshop, 3D gaming or the like"
        ]
      },
      size: {
        description: "What size screen would you like?",
        options: [
          "13 inch. Good for carrying around",
          "15 inch. Good for work related activity",
          "The biggest possible. Good for work, not so good mobility wise"
        ]
      },
      storage: {
        description: "How much storage do you want for your music, video's, photo's and apps/games?",
        options: [
          "Not too much. 360 GB is good",
          "Decent. 500 GB will do",
          "I need lots !!! Upwards of 750 GB"
        ]
      }
    }
  end

  def set_feature_indexes
    # lower index == to higher quality / more preferential 
    @feature_indexes = {}

    answers.each_pair do |q, answer|
      if answer == "a"
        @feature_indexes[q.to_sym] = 0
      elsif answer == "b"
        @feature_indexes[q.to_sym] = 1
      elsif answer == "c"
        @feature_indexes[q.to_sym] = 2
      elsif answer == "d"
        @feature_indexes[q.to_sym] = 3
      end
    end

    @feature_indexes[:ram] = @feature_indexes[:speed]
    @feature_indexes[:processor] = @feature_indexes[:speed]
    @feature_indexes.delete(:speed)

    @original_indexes = feature_indexes
  end

#private

  def original_indexes
    #non mutated indexes
    @original_indexes
  end

  def feature_indexes
    # lower index =  higher quality / more preferential  
    @feature_indexes 
  end

  def features
    {
      price: [[200, 450], [450, 700], [700, 1500], [1500, 3500]],
      processor: [["i7"], ["i5"], ["i3", "2", "Celeron", "Pentium"]],
      ram: [[8], [6], [4]],
      size: [[17], [15.6], [13]],
      storage: [[1], [750], [500], [320]]
    }
  end

  def search_terms
    @search_terms = {
      price: features[:price][feature_indexes[:price]],
      processor: features[:processor][feature_indexes[:processor]],
      ram: features[:ram][feature_indexes[:ram]],
      size: features[:size][feature_indexes[:size]],
      storage: features[:storage][feature_indexes[:storage]]
    }
  end

  def total_results
    @total_results
  end

########

  def feature_downgrade
    @index ||= 0
    @downgrade_list ||= features.keys[1..-1].reverse
    list_size ||= @downgrade_list.size
    binding.pry
    key         = @downgrade_list[@index]
    rounds      = 0
    continue    = true

    while continue && rounds < list_size
      if feature_indexes[key] < features.size
        @feature_indexes[key] += 1 
        continue = false
      end
      rounds += 1
      @index = @index < list_size - 1 ? @index + 1 : 0
    end
  end

  def widen_search
    rounds = 0
    while total_results == 0 && rounds <= 3
      feature_downgrade
      qualified_laptops
      rounds += 1
    end
  end

######
  def qualified_laptops
    s_terms = search_terms
    binding.pry
    query = "proccessor ~* '#{s_terms[:processor][0]}' AND ram >= #{s_terms[:ram][0]} AND screen_size >= #{s_terms[:size][0]} AND screen_size <= #{s_terms[:size][0] + 1} AND hard_drive_gb >= #{s_terms[:storage][0]} AND price <= #{s_terms[:price][1]}"
    laptops = Laptop.where(query)
    @total_results = laptops.size
    laptops
  end
  #Sorting products by most desirable attributes (lowest cost as of this version).

  def final_picks
    top_products = []
    all_products = data  
    all_products.sort_by {|item| item.price }
    if all_products.size >= 3
      top_products = all_products[-3..-1]
    else 
      top_products = all_products[-(all_products.size)..-1]
    end
  end

  def fire_search
    set_feature_indexes
    qualified_laptops
    widen_search
    final_picks
  end

end 