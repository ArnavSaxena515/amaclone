const express = require("express");
const productRouter = express.Router();
const User = require("../models/user");
const mongoose = require("mongoose");
const auth = require("../middlewares/auth");
const {Product} = require("../models/product");
const https = require("node:https");
const ratingsSchema = require("../models/ratings");

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const requestedCategory = req.query.category;
    const products = await Product.find({ category: requestedCategory });
    console.log(products);
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: "Something went wrong\n" + e });
  }
});
productRouter.get(
  "/api/products/search/:searchQuery",
  auth,
  async (req, res) => {
    try {
      console.log("getting products");
      console.log(req.params.searchQuery);
      const products = await Product.find({
        name: { $regex: req.params.searchQuery, $options: "i" },
      });
      //TODO: implement fuzzy search
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: "Something went wrong\n" + e });
    }
  }
);

productRouter.post("/api/rate-product",auth, async (req, res) => {
  try {
    
    const { userId, rating, productId } = req.body;
    // find the product
    const productToRate = await Product.find({
      _id: productId,
    });
    
    if (!productToRate) {
      res.status(400).json({ error: "Invalid request: Product not found" });
      return;
    }
    
    let ratingsArray = productToRate[0]["ratings"];
    
    //TODO see if the search can be optimized
    let ratingUpdated = false;
    //update existing rating
    for (let index = 0; index < ratingsArray.length; index++) {
      if (ratingsArray[index]["userId"] === userId) {
        console.log("existing rating found")
        console.log(ratingsArray[index]);
        ratingsArray[index]["rating"] = rating;
        console.log(ratingsArray[index]["rating"])
        ratingUpdated = true;
        break;
      }
    }
  // add a new rating if it didnt exist previously
    if(!ratingUpdated){
      ratingsArray.push({ userId: userId, rating: rating });
    }
    console.log(ratingsArray);
    productToRate[0].ratings = ratingsArray;
    console.log(productToRate[0]);
    productToRate[0].calculateAverageRating();
    await productToRate[0].save();

    res.json({ message: "Product Rating updated" });
  } catch (e) {
    res.status(500).json({ error: "Something went wrong\n" + e });
  }
});

productRouter.get("/api/deal-of-the-day", auth,async(req,res)=>{
  console.log("Getting deal of day");
  let dealOfDay = await Product.find({}).sort({averageRating:-1}).limit(1);
  console.log(dealOfDay);
  res.json(dealOfDay);
})
module.exports = productRouter;
