import mongoose from "mongoose";

const serviceCollegeSchema = new mongoose.Schema(
  {
    categoryId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "ServiceCategory",
      required: true,
    },
    degreeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "ServiceDegree",
      required: true,
    },
    name: {
      type: String,
      required: true,
      trim: true,
    },
    state: {
      type: String,
      required: true,
      trim: true,
    },
    city: {
      type: String,
      required: true,
      trim: true,
    },
    iconName: {
      type: String,
      default: "school",
    },
    description: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      enum: ["Government", "Private"],
      default: "Government",
    },
    admissionDeadline: {
      type: String,
      required: true,
    },
    duration: {
      type: Number,
      required: true,
      default: 36,
    },
    order: {
      type: Number,
      default: 0,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model("ServiceCollege", serviceCollegeSchema);
