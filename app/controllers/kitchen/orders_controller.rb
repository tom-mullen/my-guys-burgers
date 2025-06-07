class Kitchen::OrdersController < ApplicationController
  def index
    @orders = Order.includes(:line_items, :items).order(created_at: :desc)
  end
end