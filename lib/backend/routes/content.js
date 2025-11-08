import express from "express";
import Content from "../models/Content.js";

const router = express.Router();

// GET all content (with optional category filter)
router.get("/", async (req, res) => {
  try {
    const { category } = req.query;
    const filter = category ? { category } : {};
    
    const content = await Content.find(filter).sort({ createdAt: -1 });
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: "Error fetching content", error: error.message });
  }
});

// GET single content by ID
router.get("/:id", async (req, res) => {
  try {
    const content = await Content.findById(req.params.id);
    
    if (!content) {
      return res.status(404).json({ message: "Content not found" });
    }
    
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: "Error fetching content", error: error.message });
  }
});

// POST create new content
router.post("/", async (req, res) => {
  try {
    const { title, description, category, imageUrl, isPublished } = req.body;
    
    // Validation
    if (!title || !description || !category) {
      return res.status(400).json({ 
        message: "Title, description, and category are required" 
      });
    }
    
    const content = new Content({
      title,
      description,
      category,
      imageUrl,
      isPublished: isPublished !== undefined ? isPublished : true,
    });
    
    const savedContent = await content.save();
    res.status(201).json(savedContent);
  } catch (error) {
    res.status(500).json({ message: "Error creating content", error: error.message });
  }
});

// PUT update content
router.put("/:id", async (req, res) => {
  try {
    const { title, description, category, imageUrl, isPublished } = req.body;
    
    const content = await Content.findByIdAndUpdate(
      req.params.id,
      {
        title,
        description,
        category,
        imageUrl,
        isPublished,
      },
      { new: true, runValidators: true }
    );
    
    if (!content) {
      return res.status(404).json({ message: "Content not found" });
    }
    
    res.json(content);
  } catch (error) {
    res.status(500).json({ message: "Error updating content", error: error.message });
  }
});

// DELETE content
router.delete("/:id", async (req, res) => {
  try {
    const content = await Content.findByIdAndDelete(req.params.id);
    
    if (!content) {
      return res.status(404).json({ message: "Content not found" });
    }
    
    res.json({ message: "Content deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting content", error: error.message });
  }
});

export default router;
