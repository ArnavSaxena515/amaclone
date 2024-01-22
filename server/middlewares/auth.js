// this middlware is responsible for authentication and validation of requests. if valid, we store the user ID

const jwt = require("jsonwebtoken");
const constants = require("../constants");
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {

      return res.status(401).json({ message: "No auth token, access denied" });
    }
    const verify = jwt.verify(token, constants.secretKey);
    if (!verify) {
      return res
        .status(401)
        .json({ message: "Token verification failed. Authorization denied" });
    }
    
    req.user = verify.id;
    req.token = token;
    // next is the callback it must execute if all validation succeeds. this callback decides what will be done next and is passed as an argument
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = auth;
