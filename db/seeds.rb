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
    params = {}
    # 1. title
    # gsub for color
    begin 
        params[:name] = product["name"].gsub(/ - \D*$/, "")

        # 2. brand
        params[:brand] = product["manufacturer"]

        # 4. image link
        params[:image_url] = product["largeFrontImage"]

        # 5. url link
        params[:url] = product["url"]

        # 6. description
        params[:description] = product["longDescription"]

        # 7. price
        params[:price] = product["regularPrice"]
        # 8. ram
        params[:ram] = product["shortDescription"].match(/([^;]+)GB memory/)[1]
        # 9. storage
        params[:hard_drive_gb] = product["driveCapacityGb"]

        # 10. proccessor
        params[:proccessor] = product["shortDescription"].match(/details: (.+) processor/)[1]
        # 13. screen size
        params[:screen_size] = product["screenSizeIn"] 
    rescue StandardError => e
        next 
    end
    begin 
        # 3. color
            params[:color] = product["color"]
        # 11. weight
        params[:weight] = product["weight"].gsub(/ pounds/, "")
        # 12. battery
        params[:battery_life] = product["batteryLifeMin"]
        
        # 14. model number
        params[:model_number] = product["modelNumber"]
        # 15. upc
        params[:upc] = product["upc"]
    rescue
    end

    Laptop.create(params) 
  end
end
# class CreateLaptops < ActiveRecord::Migration
#   def change
#     create_table :laptops do |t|

#     end
#   end
# end
