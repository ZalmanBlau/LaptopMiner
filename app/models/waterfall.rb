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
      processor: [["i7"], ["i5"], ["2", "Celeron", "Pentium"]],
      ram: [[8], [6], [4]],
      size: [[17], [15], [13]],
      storage: [["1tb"], ["750gb"], ["500gb"], ["320gb"]]
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

  def total_pages
    amazon_data["ItemSearchResponse"]["Items"]["TotalPages"].to_i
  end

  def narrow_search
    if total_pages > 1 
      binding.pry
      min_price = search_terms[price][0]
      max_price = search_terms[price][1]
      if feature_indexes[:price] == 0 && max_price > min_price + 100
        index = 0
        while index < 3
          @search_terms[:price][1] -= 50
          amazon_fetcher
          index += 1
        end
      else
        unless @feature_indexes[:price] + 1 == features.size
          @feature_indexes[:price] += 1 
        end
      end
      narrow_search
    end
  #widen search by $50 if narrowing went to far. 
    if total_pages < 1 
      while total_pages < 1
        binding.pry
        @search_terms[:price][1] += 50
      end
    end  
  end

  def widen_search
    binding.pry
    i = 0
    while total_pages < 1 && i < 4
      binding.pry
      feature_downgrade
      amazon_fetcher
      i += 1
    end
    i < 4
  end

######

  def amazon_fetcher
    terms = search_terms
    search_specs = {
      keywords: "intel, #{terms[:processor].join(", ")}, #{terms[:ram].join(", ")}gb ram, #{terms[:storage].join(", ")}, #{terms[:size].join(", ")}inch",
      min_price: terms[:price][0],
      max_price: terms[:price][1]
    }
    @amazon_data = AmazonApi.call(search_specs)
  end

  #Sorting products from most desirable (lowest cost as of this version)
    #to least desirable (most expensive and invalid data).
    #Note: items that cost less then $200 are usaully non matching, and will be placed
    #last along with other invalids.
    #*the number 400,000 is arbitrary, any non realisticly high number that can filter 
    #the good from the bad will do. 

  def final_picks
    all_products = []
    amazon_data["ItemSearchResponse"]["Items"]["Item"].each do |product|
      all_products << product
    end
    all_products.sort_by do |item| 
      if item.is_a?(Hash)
        price = item["OfferSummary"]["LowestNewPrice"]
        price = price.nil? || price < 200 ? 400000 : price["Amount"].to_i 
      else
        400000
      end
    end
    all_products[-3..-1]
  end

  def fire_search
    set_feature_indexes
    amazon_fetcher
    widen_search
    narrow_search
    final_picks
  end

end 