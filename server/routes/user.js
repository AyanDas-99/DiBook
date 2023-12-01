const express = require('express');
const auth = require('../middleware/auth');
const userRoute = express.Router();
const user = require('../model/user');
const User = require('../model/user');

// statusCode 200 if updated
userRoute.post("/user/update-address", auth, async (req, res) => {
    try {
        address = req.body.address;
        await User.findByIdAndUpdate(req.user, {address: address});
        res.send(true);
    } catch (e) {
        res.send(false);
    }
})


module.exports = userRoute;