const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const { productSchema } = require("./product");

userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      // using regular expressioin to validate email
      validator: (value) => {
        //todo: fix regex
        //        const re =
        //          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        //        return value.match(re);
      },
      // error message in case regexp validation fails
      message: "Please enter a valid email address",
    },
  },
  password: {
    //TODO implement password validation
    required: true,
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  // add cart
  cart: [
    {
      product: productSchema,
      quantity: { type: Number, required: true },
    },
  ],
});
// method to generate hash for a new password
userSchema.methods.generateHash = (password) => {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};
// method to compare hash
userSchema.methods.validatePassword = (password, hash) => {
  console.log(this.password);

  return bcrypt.compareSync(password, hash);
};
const User = mongoose.model("User", userSchema);

module.exports = User;
