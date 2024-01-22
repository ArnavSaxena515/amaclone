const mongoose = require("mongoose");
const ratingsSchema = require("./ratings");


const productSchema = mongoose.Schema({
  name: {
    type: String,
    trim: true,
    required: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],

  quantity: {
    type: Number,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
  sellerId: {
    // type: mongoose.Types.ObjectId,
    type: String,
    required: true,
  },
  ratings: [ratingsSchema],
  averageRating: {
    type: Number,
    index:true,
  },
});


productSchema.methods.calculateAverageRating =
  function calculateAverageRating() {
    console.log(this.model);
    let length = this.ratings.length;
    let sum = 0;
    this.ratings.forEach((element) => {
      sum = sum + element["rating"];
    });
    this.averageRating = sum / length;
  };
const Product = mongoose.model("Product", productSchema);

module.exports = {Product, productSchema};
