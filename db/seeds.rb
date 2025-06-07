# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
LineItem.destroy_all
Item.destroy_all
Order.destroy_all

# Create main items with Five Guys UK pricing (GBP)
Item.create!([
  # Main items
  { name: "Little Hamburger", category: "main", price: 6.95 },
  { name: "Grilled Cheese Sandwich", category: "main", price: 4.95 },
  { name: "HotDog", category: "main", price: 5.95 },
  
  # Toppings (Five Guys toppings are typically free)
  { name: "Ketchup", category: "topping", price: 0.00 },
  { name: "Mayo", category: "topping", price: 0.00 },
  { name: "Mustard", category: "topping", price: 0.00 },
  { name: "Cheese", category: "topping", price: 1.00 }, # Cheese usually costs extra
  { name: "Bacon", category: "topping", price: 1.50 }, # Bacon usually costs extra
  
  # Sides
  { name: "Mini Salted Fries", category: "side", price: 3.25 },
  { name: "Mini Cajun Fries", category: "side", price: 3.25 },
  
  # Drinks
  { name: "Chocolate Shake", category: "drink", price: 2.00 },
  { name: "Vanilla Shake", category: "drink", price: 2.00 },
  { name: "Water", category: "drink", price: 0.00 }
])

puts "Seeded #{Item.count} items"