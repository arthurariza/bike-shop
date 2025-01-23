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

Customization.find_or_create_by!(name: 'Color', category: bicycles)
Customization.find_or_create_by!(name: 'Wheel Size', category: bicycles)
Customization.find_or_create_by!(name: 'Frame Material', category: bicycles)
Customization.find_or_create_by!(name: 'Suspension', category: bicycles)
