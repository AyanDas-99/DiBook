const mongoose = require("mongoose");

const bookSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    description: {
        required: true,
        type: String,
    },
    category: {
        required: true,
        type: String,
    },
    mrp: {
        required: true,
        type: Number,
    },
    stock: {
        required: true,
        type: Number,
    },
    rating: {
        required: true,
        type: Number,
    },
    price: {
        required: true,
        type: Number,
    },
    images: {
        required: true,
        type: [String],
    },
    user: {
        required: true,
        type: String,
    }
})

const Book = mongoose.model("Book", bookSchema);
module.exports =  Book;