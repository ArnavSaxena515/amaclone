const express = require("express");
const adminRouter = express.Router();
const User = require("../models/user");
const mongoose = require("mongoose");
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const https = require("node:https");
const cloudinary = require("cloudinary");
const cloudDetails = require("../constants");
const Order = require("../models/order");
cloudinary.config({
  cloud_name: cloudDetails.name,
  api_key: cloudDetails.apiKey,
  api_secret: cloudDetails.apiSecret,
  secure: true,
});

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category, sellerId } =
      req.body;
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
      res.status(200).json({ products: products });
    } else {
      res.status(200).json({ products: [] });
    }
  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});

adminRouter.get("/admin/get-all-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
   
    if (orders && orders.length > 0) {
      res.status(200).json({ orders: orders });
    } else {
      res.status(200).json({ orders: [] });
    }
  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});

adminRouter.delete("/admin/delete-product", admin, async (req, res) => {

  try {
    //TODO: implement code to check if seller Id matches the sellerId stored in product's details
    const sellerId = req.header("sellerId");
    const productId = req.body.productId;

    const productToDelete = await Product.find({ _id: productId });

    const imageUrlsForProduct = productToDelete[0].images;
  
    await Product.deleteOne({ _id: productId });
    res.status(200).json({ message: "Product deleted" });
  } catch (e) {
    res.status(500).json({ error: "Something went wrong: " + e });
  }
});
adminRouter.get('/admin/analytics', admin, async(req,res)=>{
  try{
    const orders = await Order.find({});
    let totalEarnings = 0;
    for(let i = 0; i<orders.length;i++){
      for(let j = 0; j < orders[i].products.length; j++){
        totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price
      }
    }
    //fetch orders category wise
    let mobileEarnings = await fetchAnalyticsCategoryWise('Mobiles');
    let essentialsEarnings = await fetchAnalyticsCategoryWise('Essentials');
    let appliancesEarnings = await fetchAnalyticsCategoryWise('Appliances');
    let booksEarnings = await fetchAnalyticsCategoryWise('Books');
    let fashionEarnings = await fetchAnalyticsCategoryWise('Fashion');

    let earnings = {
      totalEarnings,mobileEarnings,essentialsEarnings,appliancesEarnings,booksEarnings,fashionEarnings
    }
    console.log(earnings);
    res.json(earnings);

  }catch(e){
    res.status(500).json({ error: "Something went wrong: " + e });
  }
})

const  fetchAnalyticsCategoryWise = async (category)=>{
  let earnings = 0;
  let categoryOrders = await Order.find({
   'products.product.category':category
  });


  for(let i = 0; i<categoryOrders.length;i++){
    for(let j = 0; j < categoryOrders[i].products.length; j++){
      earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price
    }
  }
  console.log(category);
  console.log(earnings);
  return earnings;
}