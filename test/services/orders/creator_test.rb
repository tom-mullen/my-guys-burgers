require "test_helper"

class Orders::CreatorTest < ActiveSupport::TestCase
  def setup
    @main_item = items(:hamburger)
    @topping_item1 = items(:bacon)
    @topping_item2 = Item.create!(name: "Cheese", category: "topping", price: 1.00)
    @side_item = items(:fries)
    @shake_item = items(:chocolate_shake)
  end

  test "creates order with single selections" do
    params = ActionController::Parameters.new({
      order: {
        customer_name: "John Doe",
        items_main: @main_item.id.to_s,
        items_side: @side_item.id.to_s,
        items_shake: @shake_item.id.to_s
      }
    })

    creator = Orders::Creator.new(params)
    creator.call

    assert creator.success?
    assert_equal "John Doe", creator.order.customer_name
    assert_equal 3, creator.order.line_items.count
    
    # Check that correct items were added
    item_ids = creator.order.line_items.pluck(:item_id)
    assert_includes item_ids, @main_item.id
    assert_includes item_ids, @side_item.id
    assert_includes item_ids, @shake_item.id
  end

  test "creates order with multiple toppings" do
    params = ActionController::Parameters.new({
      order: {
        customer_name: "Jane Doe",
        items_main: @main_item.id.to_s,
        items_topping_ids: [@topping_item1.id.to_s, @topping_item2.id.to_s],
        items_side: @side_item.id.to_s
      }
    })

    creator = Orders::Creator.new(params)
    creator.call

    assert creator.success?
    assert_equal "Jane Doe", creator.order.customer_name
    assert_equal 4, creator.order.line_items.count
    
    # Check that all items were added including both toppings
    item_ids = creator.order.line_items.pluck(:item_id)
    assert_includes item_ids, @main_item.id
    assert_includes item_ids, @topping_item1.id
    assert_includes item_ids, @topping_item2.id
    assert_includes item_ids, @side_item.id
  end

  test "fails validation when customer name is missing" do
    params = ActionController::Parameters.new({
      order: {
        customer_name: "",
        items_main: @main_item.id.to_s,
        items_side: @side_item.id.to_s
      }
    })

    creator = Orders::Creator.new(params)
    creator.call

    assert_not creator.success?
    assert_includes creator.errors.messages[:customer_name], "Your name can't be blank!"
  end

  test "copies item prices to line items" do
    params = ActionController::Parameters.new({
      order: {
        customer_name: "Test Customer",
        items_main: @main_item.id.to_s,
        items_topping_ids: [@topping_item1.id.to_s],
        items_side: @side_item.id.to_s
      }
    })

    creator = Orders::Creator.new(params)
    creator.call

    assert creator.success?
    
    # Check that prices were copied correctly
    line_items = creator.order.line_items.includes(:item)
    line_items.each do |line_item|
      assert_equal line_item.item.price, line_item.price
    end
  end
end