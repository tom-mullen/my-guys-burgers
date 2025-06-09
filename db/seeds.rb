# Clear existing data
LineItem.destroy_all
Item.destroy_all
Order.destroy_all

# Create main items with Five Guys UK pricing (GBP)
Item.create!([
  # Mains
  { name: "Little Hamburger", category: "main", price: 6.95 },
  { name: "Grilled Cheese Sandwich", category: "main", price: 4.95 },
  { name: "HotDog", category: "main", price: 5.95 },
  { name: "Ketchup", category: "topping", price: 0.00 },
  { name: "Mayo", category: "topping", price: 0.00 },
  { name: "Mustard", category: "topping", price: 0.00 },
  { name: "Cheese", category: "topping", price: 1.00 },
  { name: "Bacon", category: "topping", price: 1.50 },

  # Sides
  { name: "Mini Salted Fries", category: "side", price: 3.25 },
  { name: "Mini Cajun Fries", category: "side", price: 3.25 },

  # Drinks
  { name: "Chocolate Shake", category: "drink", price: 2.00 },
  { name: "Vanilla Shake", category: "drink", price: 2.00 },
  { name: "Water", category: "drink", price: 0.00 }
])

puts "Seeded #{Item.count} items"
