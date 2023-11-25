const express = require('express');
const mongoose = require('mongoose');
const authRoute = require('./routes/auth');
const bookUploadRoute = require('./routes/book_upload');
const booksRoute = require('./routes/books');
const cors = require('cors');

const PORT = 3000;
const app = express()
const DB = "mongodb+srv://ayandas:ayandaspassword@cluster0.zrqugro.mongodb.net/?retryWrites=true&w=majority&appName=AtlasApp";

app.use(cors());
app.use(express.json());
app.use(authRoute);
app.use(bookUploadRoute);
app.use(booksRoute);

app.get("/hello", (req, res) => {
    res.send("Unrestricted access denied");
});

// DB connection
mongoose.connect(DB).then(()=> {
    console.log('DB Connection successfull')
}).catch(e=> {
    console.log(e)
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected to port: ${PORT}`)
});