# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'
require 'json'
####################################################################
#################     api scraper   ################################
####################################################################

# def best_buy_api(page)
#   url = "https://api.bestbuy.com/v1/products(categoryPath.id=abcat0502000&(categoryPath.id=abcat0502000))?apiKey=ky83gxmggjydu5awjnm8ffaz&pageSize=100&page=#{page}&format=json"
#   file = open(url)
#   json = File.read(file)
#   JSON.parse(json)
# end

# laptop_pages = []
# laptop_pages << best_buy_api(1)
# totalPages = laptop_pages[0]["totalPages"]

# (totalPages - 1).times {|index| laptop_pages << best_buy_api(index + 2)}

# laptops_hash = {
#   laptop_pages: laptop_pages
# }

# File.open("./public/laptops.json","w") do |f|
#   f.write(laptops_hash.to_json)
# end

####################################################################
#################     Conversion to Database  ######################
####################################################################

json = File.read("./public/laptops.json")
data = JSON.parse(json)

#information to store
data["laptop_pages"].each do |page| 
  page["products"].each do |product| 

    # 1. title
    # gsub for color
    product["name"].gsub(/ - \D*$/, "")
    # 2. brand
    product["manufacturer"]
    # 3. color
    product["color"]
    # 4. image link
    product["largeFrontImage"]
    # 5. url link
    product["url"]
    # 6. description
    product["longDescription"]
    # 7. price
    product["regularPrice"]
    # 8. ram
    product["name"].match(/ ([^-]+)GB Memory (?:- [^-]+){2}$/)[1]
    # 9. storage
    product["driveCapacityGb"]
    # 10. proccessor
    product["name"].match(/^\w+ - [^-]+\w - ([^-]+) /)[1]
    # 11. ghz
    #not available
    # 12. weight
    product["weight"].gsub(/ pounds/, "")
    # 13. battery
    product["batteryLifeMin"]
    # 14. screen size
    product["screenSizeIn"]
    # 15. model number
    product["modelNumber"]
    # 16. upc
    product["upc"]
  end
end







