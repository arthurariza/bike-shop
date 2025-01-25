# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

bicycles = Category.find_or_create_by!(name: 'Bicycles')

Product.find_or_create_by!(name: 'Road Bike', category: bicycles, in_stock: true, price: "1000.00")
Product.find_or_create_by!(name: 'Mountain Bike', category: bicycles, in_stock: true, price: "1200.00")
Product.find_or_create_by!(name: 'BMX', category: bicycles, in_stock: true, price: "900.00")

color = Customization.find_or_create_by!(name: 'Color', category: bicycles)
wheel_size = Customization.find_or_create_by!(name: 'Wheel Size', category: bicycles)
frame_material = Customization.find_or_create_by!(name: 'Frame Material', category: bicycles)
suspension = Customization.find_or_create_by!(name: 'Suspension', category: bicycles)

red_color = CustomizationItem.find_or_create_by!(name: 'Red', price: 100, customization: color)
blue_color = CustomizationItem.find_or_create_by!(name: 'Blue', price: 100, customization: color)

twenty_six_wheel_size = CustomizationItem.find_or_create_by!(name: '26"', price: 100, customization: wheel_size)
twenty_nine_wheel_size = CustomizationItem.find_or_create_by!(name: '29"', price: 100, customization: wheel_size)
aluminum_frame_material = CustomizationItem.find_or_create_by!(name: 'Aluminum', price: 100, customization: frame_material)
carbon_fiber_frame_material = CustomizationItem.find_or_create_by!(name: 'Carbon Fiber', price: 100, customization: frame_material)
high_suspension = CustomizationItem.find_or_create_by!(name: 'High', price: 100, customization: suspension)
low_suspension = CustomizationItem.find_or_create_by!(name: 'Low', price: 100, customization: suspension)

ProhibitedCombination.find_or_create_by!(customization_item: red_color, prohibited_item: aluminum_frame_material)
ProhibitedCombination.find_or_create_by!(customization_item: twenty_six_wheel_size, prohibited_item: low_suspension)
ProhibitedCombination.find_or_create_by!(customization_item: aluminum_frame_material, prohibited_item: twenty_nine_wheel_size)
ProhibitedCombination.find_or_create_by!(customization_item: high_suspension, prohibited_item: blue_color)
ProhibitedCombination.find_or_create_by!(customization_item: carbon_fiber_frame_material, prohibited_item: blue_color)
