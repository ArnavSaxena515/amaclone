// Requiring packages
const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const constants = require("../constants");
// Creating a router
const authRouter = express.Router();

const secretKey = constants.secretKey;

authRouter.post("/api/signup", async (req, res) => {
  // get client data, post data into our database, return data to user to save authentication to avoid repeating login procedure

  try {
    const { name, email, password } = req.body;
    // Handle validations, maybe add encryption?
    // checking if user with this email ID already exists
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      // be sure to change response code
      return res.status(400).json({
        message:
          "Bad request: User with the same email ID already exists in database",
      });
    }
    let user = new User({
      email: email,
      name: name,
    });
    user.password = user.generateHash(password);
    user = await user.save();
    res.json(user);
  } catch (e) {
    console.log();
    res.status(500).json({
      error: "Something went wrong: " + e.message,
    });
  }
});

authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    console.log(email + "  " + password);
    const user = await User.findOne({ email });
    if (!user)
      return res.status(400).json({
        message: `Bad request: User with email ID ${email} not found in database. Try signing up instead`,
      });

    if (!user.validatePassword(password, user.password)) {
      console.log(password);
      return res.status(400).json({
        message: `Bad request: Incorrect password`,
      });
    }
    // todo change password key
    const token = jwt.sign({ id: user._id }, secretKey);
    res.json({ token, ...user._doc });

    // if user not found return error
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e);
  }
});

authRouter.post("/api/tokenValidation", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    // returns false if token is empty
    if (!token) {
      return res.json(false);
    }
    // verify if token is actually a valid one
    const verify = jwt.verify(token, secretKey);
    if (!verify) {
      return res.json(false);
    }

    //if token valid, we need to verify if a user associated with that token exists
    const user = await User.findById(verify.id);

    if (!user) return res.json(false);

    return res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(e);
  }
});

// get user data
// auth is the middleware that ensures only authorized requests can access this route
authRouter.get("/", auth, async (req, res) => {
  // after using the middleware, the request will now have another member value named user which contains the user id. this is the callback that executes after the middleware authorises the req
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});
module.exports = authRouter;
