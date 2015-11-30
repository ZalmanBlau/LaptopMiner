# class CreateLaptops < ActiveRecord::Migration
#   def change
#     create_table :laptops do |t|
#       t.string :title
#       t.string :brand
#       t.string :page_link
#       t.text :description
#       t.decimal :price
#       t.integer :ram 
#       t.integer :hard_drive_gb
#       t.string :proccessor
#       t.integer :weight
#       t.integer :battery_life
#       t.decimal :screen_size
#       t.integer :modelNumber
#       t.integer :upc

#       t.timestamps null: false
#     end
#   end
# end

# # 1. title
#     # gsub for color
#     product["name"].gsub(/ - \D*$/, "")
#     # 2. brand
#     product["manufacturer"]
#     # 3. color
#     product["color"]
#     # 4. image link
#     product["largeFrontImage"]
#     # 5. url link
#     product["url"]
#     # 6. description
#     product["longDescription"]
#     # 7. price
#     product["regularPrice"]
#     # 8. ram
#     product["name"].match(/ ([^-]+)GB Memory (?:- [^-]+){2}$/)[1]
#     # 9. storage
#     product["driveCapacityGb"]
#     # 10. proccessor
#     product["name"].match(/^\w+ - [^-]+\w - ([^-]+) /)[1]
#     # 11. ghz
#     #not available
#     # 12. weight
#     product["weight"].gsub(/ pounds/, "")
#     # 13. battery
#     product["batteryLifeMin"]
#     # 14. screen size
#     product["screenSizeIn"]
#     # 15. model number
#     product["modelNumber"]
#     # 16. upc
#     product["upc"]