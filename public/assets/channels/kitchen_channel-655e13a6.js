import consumer from "channels/consumer"

consumer.subscriptions.create("KitchenChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the kitchen!")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from the kitchen!")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const ordersContainer = document.getElementById('orders');
    if (ordersContainer && data.order_html) {
      ordersContainer.insertAdjacentHTML('afterbegin', data.order_html);
    }
  }
});
