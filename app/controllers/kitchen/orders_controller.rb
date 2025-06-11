class Kitchen::OrdersController < ApplicationController
  def index
    @orders = @joint.orders.includes(:line_items, :items).order(created_at: :desc)
  end

  def destroy_all
    @joint.orders.find_each do |order|
      order.destroy
    end

    redirect_to joint_kitchen_path(@joint)
  end
end
