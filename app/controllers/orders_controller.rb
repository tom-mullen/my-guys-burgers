class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit ]

  def index
    @orders = @joint.orders.includes(:line_items, :items).order(created_at: :desc)
  end

  def show
  end

  def new
    @order = @joint.orders.new
    @items = Item.by_category
  end

  def edit
  end

  def create
    @items = Item.by_category
    creator = Orders::Creator.new(joint: @joint, params: params)
    creator.call

    respond_to do |format|
      if creator.success?
        @order = creator.order
        format.html { redirect_to [ @joint, @order ], notice: "Great - Your order is with the kitchen!" }
        format.json { render :show, status: :created, location: @order }
      else
        @order = creator.order
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: creator.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = Order.find(params.expect(:id))
  end

  def order_params
    params.require(:order)
  end
end
