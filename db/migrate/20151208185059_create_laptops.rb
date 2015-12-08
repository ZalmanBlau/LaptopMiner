class CreateLaptops < ActiveRecord::Migration
  def change
    create_table :laptops do |t|
        t.string :name
        t.string :brand
        t.string :color
        t.string :url
        t.string :image_url
        t.text :description
        t.float :price
        t.integer :ram 
        t.integer :hard_drive_gb
        t.string :proccessor
        t.float :weight
        t.integer :battery_life
        t.float :screen_size
        t.string :model_number
        t.string :upc
    end
  end
end