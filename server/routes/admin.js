const express = require("express");
const adminRouter = express.Router();
const User = require("../models/user");
const mongoose = require("mongoose");
const admin = require("../middlewares/admin");
const Product = require("../models/product");

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category, sellerId } =
      req.body;
    console.log(req.body);
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
      sellerId,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: "Something went wrong\n" + e });
  }
});
module.exports = adminRouter;

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const sellerId = req.header("sellerId");
    const products = await Product.find({ sellerId: sellerId });

    if (products && products.length > 0) {
      console.log("Products");
      console.log(products);
      res.status(200).json({ products: products });
    } else {
      console.log("no products yet");
    }
  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});
