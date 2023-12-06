const express = require('express');
const Order = require('../model/order');
const Book = require('../model/book');
const auth = require('../middleware/auth');
const { json } = require('express');

const orderRoute = express.Router();

orderRoute.post("/order/place-order", auth, async (req, res) => {
    try {
        const { bookId, quantity, address } = req.body;
        console.log(req.body);

        let book = await Book.findById(bookId);
        
        if(book.stock == 0) {
            return res.json({error: "Book not available"});
        } else if(quantity > book.stock) {
            return res.json({error: "Order quantity is more than stock left"});
        }

        book.stock -= quantity;

        let order = new Order({
            user_id: req.user,
            book_id: bookId,
            quantity: quantity,
            address: address,
            status: "Not dispatched"
        });

        order = await order.save();
        book = await book.save();
        
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