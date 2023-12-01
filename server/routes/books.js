const express = require("express");
const Book = require("../model/book");

const booksRoute = express.Router();

// Get all books
booksRoute.get("/book/all-books", async (req, res) => {
    try {
        const books = await Book.find();
        res.json(books);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

// Get category based books
booksRoute.get("/book/category/:category", async (req, res) => {
    try {
        const category = req.params.category;
        const books = await Book.find({ category: category });
        res.json(books);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

// Get query based books
booksRoute.get("/book/search/:query", async (req, res) => {
    try {
        const query = req.params.query;
        const books = await Book.find({
            $or: [
                { name: { $regex: query, $options: 'i' } },
                { description: { $regex: query, $options: 'i' } },
                { category: { $regex: query, $options: 'i' } }
            ]
        });
        res.json(books);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})

// Get book by id
booksRoute.get("/book/id/:bookId", async (req, res) => {
    try {
        const bookId= req.params.bookId;
        const book = await Book.findById(bookId);
        res.json(book);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
})


module.exports = booksRoute;