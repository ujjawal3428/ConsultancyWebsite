import mongoose from "mongoose";

const collegeSchema = new mongoose.Schema({
  name: String,
  logo: String,
  description: String,
});

const degreeSchema = new mongoose.Schema({
  name: String,
  colleges: [collegeSchema],
});

const categorySchema = new mongoose.Schema({
  title: String,
  icon: String,
  degrees: [degreeSchema],
});

export default mongoose.model("Category", categorySchema);
