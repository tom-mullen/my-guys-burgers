require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Customer name", with: @order.customer_name
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Customer name", with: @order.customer_name
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    accept_confirm { click_on "Destroy this order", match: :first }

    assert_text "Order was successfully destroyed"
  end

  test "creating an order with items from each category" do
    # Get fixture items
    main_item = items(:hamburger)
    topping_item = items(:bacon)
    side_item = items(:fries)
    shake_item = items(:chocolate_shake)
    
    # Navigate to new order page
    visit new_order_path
    
    # Check page loaded correctly
    assert_text "WHAT'S YOUR NAME?"
    
    # Enter customer name
    fill_in "order_customer_name", with: "John Doe"
    
    # Select one item from each category
    choose "order_items_main_#{main_item.id}"
    choose "order_items_topping_#{topping_item.id}" 
    choose "order_items_side_#{side_item.id}"
    choose "order_items_shake_#{shake_item.id}"
    
    # Submit the form
    click_button "Place Order!"
    
    # Get the order that was just created
    order = Order.find_by(customer_name: "John Doe")
    assert_not_nil order, "Order with customer name 'John Doe' should exist"
    
    # Should be redirected to order show page
    assert_current_path order_path(order)
    
    # Check order was created with correct customer name
    assert_equal "John Doe", order.customer_name
    
    # Check line items were created correctly
    assert_equal 4, order.line_items.count
    
    # Verify each line item has correct item and price
    line_items_by_category = order.line_items.includes(:item).group_by { |li| li.item.category }
    
    assert_equal main_item.id, line_items_by_category["main"].first.item_id
    assert_equal main_item.price, line_items_by_category["main"].first.price
    
    assert_equal topping_item.id, line_items_by_category["topping"].first.item_id
    assert_equal topping_item.price, line_items_by_category["topping"].first.price
    
    assert_equal side_item.id, line_items_by_category["side"].first.item_id
    assert_equal side_item.price, line_items_by_category["side"].first.price
    
    assert_equal shake_item.id, line_items_by_category["shake"].first.item_id
    assert_equal shake_item.price, line_items_by_category["shake"].first.price
    
    # Check that order details are displayed on the page
    assert_text "John Doe"
    assert_text main_item.name
    assert_text topping_item.name
    assert_text side_item.name
    assert_text shake_item.name
  end
end
