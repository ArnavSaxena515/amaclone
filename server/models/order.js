const mongoose = require("mongoose");
const { productSchema } = require("./product");
const orderSchema = mongoose.Schema({
  products: [
    { product: productSchema, quantity: { type: Number, required: true } },
  ],
  totalPrice: {
    required: true,
    type: Number,
  },
  address: {
    type: String,
    required: true,
  },
  userId: { reqruired: true, type: String },
  orderedAt: {
    type: Number,
    required: true,
  },
  status: { type: Number, default: 0 },
});

const Order = mongoose.model("Order", orderSchema);

module.exports = Order;
