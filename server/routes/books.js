const express = require("express");
const Book = require("../model/book");

const booksRoute = express.Router();

booksRoute.get("/all-books", async(req, res) => {
    try {
    const books = await Book.find();
    res.json(books);
} catch(e) {
    res.status(500).json({error: e.message});
}
})

module.exports = booksRoute;