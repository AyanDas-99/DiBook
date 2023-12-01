const express = require('express');
const auth = require('../middleware/auth');
const userRoute = express.Router();
const User = require('../model/user');
const Cart = require('../model/cart');

// statusCode 200 if updated
userRoute.post("/user/update-address", auth, async (req, res) => {
    try {
        const { address } = req.body;
        if (address != undefined) {
            await User.findByIdAndUpdate(req.user, { address: address });
            res.send(true);
        } else {
            res.status(500).json({"error": "address is not defined"})
        }
    } catch (e) {
        res.status(500).json({"error": e.message});
    }
})

// get cart from user
userRoute.get("/user/cart", auth, async(req, res) => {
    try {
        let cart = await Cart.findOne({user_id: req.user});
        res.json(cart);
    } catch(e) {
        res.status(500).json({"error": e.message});
    }
})


module.exports = userRoute;