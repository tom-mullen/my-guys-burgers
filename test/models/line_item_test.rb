require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "copies price from item on create" do
    item = Item.create!(name: "Test Item", price: 15.99)
    order = Order.create!(customer_name: "Test Customer")
    line_item = LineItem.create!(order: order, item: item)

    assert_equal 15.99, line_item.price
  end

  test "preserves explicitly set price" do
    item = Item.create!(name: "Test Item", price: 15.99)
    order = Order.create!(customer_name: "Test Customer")
    line_item = LineItem.create!(order: order, item: item, price: 12.99)

    assert_equal 12.99, line_item.price
  end

  test "validates price presence" do
    order = Order.create!(customer_name: "Test Customer")
    line_item = LineItem.new(order: order, item: nil)

    assert_not line_item.valid?
    assert_includes line_item.errors[:price], "can't be blank"
  end

  test "validates price is not negative" do
    item = Item.create!(name: "Test Item", price: 15.99)
    order = Order.create!(customer_name: "Test Customer")
    line_item = LineItem.new(order: order, item: item, price: -5.00)

    assert_not line_item.valid?
    assert_includes line_item.errors[:price], "must be greater than or equal to 0"
  end
end
