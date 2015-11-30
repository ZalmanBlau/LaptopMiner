# class AmazonApi
#   def initialize(search_specs)
#     @price = search_specs[:price]
#     @keywords = search_specs[:keywords]
#   end

#   attr_reader :price, :keywords, :response

#   def self.call(search_specs)
#     api = AmazonApi.new(search_specs)
#     api.request
#     api.response
#   end

#   def request
#     @request = Vacuum.new
#     cred 

#       response = @request.item_search(
#         query: {
#           'Keywords' => "Laptop, #{keywords}",
#           'SearchIndex' => 'Electronics',
#           'MinimumPrice' => "#{minimum_price}",
#           'MaximumPrice' => "#{maximum_price}",
#           'ResponseGroup' => 'ItemAttributes, OfferFull, EditorialReview',
#           'ResponseElement' => 'Features',
#           'ItemPage' => "1"


#         }
#       )
#       t = Time.now + 1
#       while Time.now < t 
#         #Wait
#       end
#       response = response.to_h
#   end
# end
class AmazonApi
  def initialize(search_specs)
    @minimum_price = search_specs[:min_price]
    @maximum_price = search_specs[:max_price]
    @keywords = search_specs[:keywords]
  end

  attr_reader :minimum_price, :maximum_price, :keywords

  def self.call(search_specs)
    api = AmazonApi.new(search_specs)
    api.api_call
  end

  def cred
    @request.configure(
      aws_access_key_id: AmazonConfig.key_id,
      aws_secret_access_key: AmazonConfig.secret_key,
      associate_tag: AmazonConfig.associate_tag
      )
  end

  def api_call
    @request = Vacuum.new
    cred 

      response = @request.item_search(
        query: {
          'Keywords' => "#{keywords}",
          'SearchIndex' => 'Electronics',
          'MinimumPrice' => "#{minimum_price}",
          'MaximumPrice' => "#{maximum_price}",
          'ResponseGroup' => 'ItemAttributes, OfferFull, EditorialReview',
          'ResponseElement' => 'Features',
          'ItemPage' => "1"


        }
      )
      t = Time.now + 1
      while Time.now < t 
        #Wait
      end
      response = response.to_h
  end

  def web_scraper(amazon_page)
    html = open("#{amazon_page}")
    nokogiri_doc = Nokogiri::HTML(html)
    pound_html = nokogiri_doc.at('div.attrG div.pdTab td.value:contains("pounds")')
    battery_html = nokogiri_doc.at('div.attrG div.pdTab td.value:contains("hours")')

    array = []
    pound_html ? array << pound_html.text : array << nil
    battery_html ? array << battery_html.text : array << nil
    array
  end

#Total-Pages: ["ItemSearchResponse"]["Items"]["TotalPages"]
#Productgroup: ["ItemSearchResponse"]["Items"]["Item"][0]["ItemAttributes"]["ProductGroup"]
#Details_url: ["ItemSearchResponse"]["Items"]["Item"][0]["DetailPageURL"]
#Price: ["ItemSearchResponse"]["Items"]["Item"][0]["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]
#Title: ["ItemSearchResponse"]["Items"]["Item"][0]["ItemAttributes"]["Title"]
end

now = Time.now.sec
Time.now.sec > now