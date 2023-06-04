// this middlware is responsible for validating if user id is associated with an admin account or not

const jwt = require("jsonwebtoken");
const constants = require("../constants");
const User = require("../models/user");
const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      console.log("No auth token, access denied");
      return res.status(401).json({
        message: "No auth token, access denied",
      });
    }
    const verify = jwt.verify(token, constants.secretKey);
    if (!verify) {
      console.log("Token verification failed. Authorization denied");
      return res.status(401).json({
        message: "Token verification failed. Authorization denied",
      });
    }
    const user = await User.findById(verify.id);
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({
        message: "You are not an admin",
      });
    }

    req.user = verify.id;
    req.token = token;

    // next is the callback it must execute if all validation succeeds. this callback decides what will be done next and is passed as an argument
    next();
  } catch (err) {
    console.log("ERROR: " + err.message);
    res.status(500).json({
      error: err.message,
    });
  }
};

module.exports = admin;
