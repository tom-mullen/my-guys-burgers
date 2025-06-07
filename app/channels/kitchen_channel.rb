class KitchenChannel < ApplicationCable::Channel
  def subscribed
    stream_from "kitchen"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
