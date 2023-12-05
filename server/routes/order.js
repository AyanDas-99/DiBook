const express = require('express');
const Order = require('../model/order');
const auth = require('../middleware/auth');
const { json } = require('express');

const orderRoute = express.Router();

orderRoute.post("/order/place-order", auth, async (req, res) => {
    try {
        const { bookId, quantity, address } = req.body;
        console.log(req.body);
        let order = await Order.findOne({ book_id: bookId });
        order = new Order({
            book_id: bookId,
            quantity: quantity,
            address: address,
            status: "Not dispatched"
        });
        order = await order.save();
        return res.json(order);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})


orderRoute.post("/order/cancel-order", auth, async (req, res) => {
    try {
        const orderId= req.body.orderId;
        await Order.findByIdAndDelete(orderId);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

module.exports = orderRoute;