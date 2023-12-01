const express = require('express');
const mongoose = require('mongoose');
const authRoute = require('./routes/auth');
const bookUploadRoute = require('./routes/book_upload');
const booksRoute = require('./routes/books');
const messageUploadRoute = require('./routes/message_upload');
const messagesRoute = require('./routes/messages');
const userRoute = require('./routes/user');
const cartRoute = require('./routes/cart');

const cors = require('cors');

const PORT = 3000;
const app = express()
const DB = "mongodb+srv://ayandas:ayandaspassword@cluster0.zrqugro.mongodb.net/?retryWrites=true&w=majority&appName=AtlasApp";

app.use(cors());
app.use(express.json());
app.use(authRoute);
app.use(bookUploadRoute);
app.use(booksRoute);
app.use(messageUploadRoute);
app.use(messagesRoute);
app.use(userRoute);
app.use(cartRoute);

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