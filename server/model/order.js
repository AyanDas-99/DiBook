const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
    book_id: String,
    quantity: Number,
    address: String,
    status: String
});


const Order = mongoose.model("Order", orderSchema);
module.exports = Order;