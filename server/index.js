// Requiring the necessary node packages
const express = require("express");
const authRouter = require("./routes/auth.js");
const adminRouter = require("./routes/admin.js");
const productRouter = require("./routes/product.js");
const userRouter = require("./routes/user.js");

const mongoose = require("mongoose");
const constants = require("./constants");
const mongoURL = constants.mongoURL;
console.log(mongoURL);
const PORT = 3000;

// Initialising the app
const app = express();

// adding middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Connecting to mongoose
mongooses
  .connect(mongoURL)
  .then(() => {
    console.log("Connected to mongodb");
  })
  .catch((e) => {
    console.log(e);
  });

// this ip address can be accessed anywhere. need to use this for debugging
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Listening on port ${PORT}`);
});
