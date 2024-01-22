const express = require("express");
const userRouter = express.Router();
const User = require("../models/user");
const mongoose = require("mongoose");
const auth = require("../middlewares/auth");
const { productSchema, Product } = require("../models/product");
const Order = require("../models/order");

userRouter.post("/api/user/add-product-to-cart", auth, async (req, res) => {
  // post route to add products to user's cart

  const { productId } = req.body;

  try {
    const product = await Product.findById(productId);
    let user = await User.findById(req.user);

    let productFound = false;

    if (user.cart.length === 0) {
      user.cart.push({ product: product, quantity: 1 });
    } else {
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          // product found in cart
          productFound = true;
          user.cart[i].quantity += 1;

          break;
        }
      }
      if (!productFound) {
        user.cart.push({ product: product, quantity: 1 });
      }
    }
    console.log(user.cart);
    await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

userRouter.delete("/api/user/remove-from-cart/:id", auth, async (req, res) => {
  // post route to add products to user's cart

  const { id } = req.params;
  console.log(id);
  try {
    const product = await Product.findById(id);
    console.log(product);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        // product found in cart
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }

        break;
      }
    }
    console.log(user.cart);
    await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

userRouter.get("/api/user/get-cart", auth, async (req, res) => {
  try {
    let user = User.findById(req.user);
    console.log(user.cart);
    res.json(user.cart);
  } catch (e) {
    res.status(500).json({ error: error });
  }
});

userRouter.post("/api/user/save-user-address", auth, async (req, res) => {
  try {
    
    const { address } = req.body;
    console.log("Address");
    console.log(address);
    let user = await User.findById(req.user);
    user.address = address;
    await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});
// order product
userRouter.post("/api/user/order", auth, async (req, res) => {
  try {
    
    const { cart, totalPrice, address } = req.body;
    let products = [];
    console.log("Orders");
    console.log(cart);
    for (let i = 0; i < cart.length; i++) {
      {
        let product = await Product.findById(cart[i].product._id);
        if (product.quantity >= cart[i].quantity) {
          product.quantity -= cart[i].quantity;
          products.push({ product, quantity: cart[i].quantity });
          await product.save();
        } else {
          return res
            .status(400)
            .json({ message: `${product.name} is out of stock at the moment` });
        }
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);

  
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

userRouter.get("/api/user/order", auth, async (req, res) => {
  console.log("sending orders")
  try {
    const orders = await Order.find({"userId":req.user});
    console.log(orders);
    res.json(orders);

  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});
module.exports = userRouter;
