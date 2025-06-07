require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "validates price presence" do
    item = Item.new(name: "Test Item")
    assert_not item.valid?
    assert_includes item.errors[:price], "can't be blank"
  end

  test "validates price is not negative" do
    item = Item.new(name: "Test Item", price: -10.00)
    assert_not item.valid?
    assert_includes item.errors[:price], "must be greater than or equal to 0"
  end

  test "validates price can be zero" do
    item = Item.new(name: "Free Item", price: 0)
    assert item.valid?
  end

  test "by_category scope orders items by category" do
    # Clear existing items to avoid fixture interference
    Item.destroy_all
    
    # Create items in random order
    shake = Item.create!(name: "Shake", category: "shake", price: 5.00)
    main = Item.create!(name: "Burger", category: "main", price: 10.00)
    side = Item.create!(name: "Fries", category: "side", price: 3.00)
    topping = Item.create!(name: "Cheese", category: "topping", price: 1.00)
    
    # Get items ordered by category
    ordered_items = Item.by_category
    
    # Assert the order is correct: main, topping, side, shake
    assert_equal "main", ordered_items[0].category
    assert_equal "topping", ordered_items[1].category
    assert_equal "side", ordered_items[2].category
    assert_equal "shake", ordered_items[3].category
  end
end