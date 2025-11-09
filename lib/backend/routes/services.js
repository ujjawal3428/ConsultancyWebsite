import express from "express";
import ServiceCategory from "../models/ServiceCategory.js";
import ServiceDegree from "../models/ServiceDegree.js";
import ServiceCollege from "../models/ServiceCollege.js";

const router = express.Router();

// ==================== CATEGORIES ====================

// GET all categories
router.get("/categories", async (req, res) => {
  try {
    const { active } = req.query;
    const filter = active === "true" ? { isActive: true } : {};
    
    const categories = await ServiceCategory.find(filter).sort({ order: 1 });
    res.json(categories);
  } catch (error) {
    res.status(500).json({ message: "Error fetching categories", error: error.message });
  }
});

// GET single category
router.get("/categories/:id", async (req, res) => {
  try {
    const category = await ServiceCategory.findById(req.params.id);
    
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    
    res.json(category);
  } catch (error) {
    res.status(500).json({ message: "Error fetching category", error: error.message });
  }
});

// POST create category
router.post("/categories", async (req, res) => {
  try {
    const category = new ServiceCategory(req.body);
    const savedCategory = await category.save();
    res.status(201).json(savedCategory);
  } catch (error) {
    res.status(500).json({ message: "Error creating category", error: error.message });
  }
});

// PUT update category
router.put("/categories/:id", async (req, res) => {
  try {
    const category = await ServiceCategory.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    
    res.json(category);
  } catch (error) {
    res.status(500).json({ message: "Error updating category", error: error.message });
  }
});

// DELETE category
router.delete("/categories/:id", async (req, res) => {
  try {
    const category = await ServiceCategory.findByIdAndDelete(req.params.id);
    
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    
    res.json({ message: "Category deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting category", error: error.message });
  }
});

// ==================== DEGREES ====================

// GET all degrees
router.get("/degrees", async (req, res) => {
  try {
    const { categoryId, active } = req.query;
    const filter = {};
    
    if (categoryId) filter.categoryId = categoryId;
    if (active === "true") filter.isActive = true;
    
    const degrees = await ServiceDegree.find(filter)
      .populate("categoryId")
      .sort({ order: 1 });
    res.json(degrees);
  } catch (error) {
    res.status(500).json({ message: "Error fetching degrees", error: error.message });
  }
});

// GET single degree
router.get("/degrees/:id", async (req, res) => {
  try {
    const degree = await ServiceDegree.findById(req.params.id).populate("categoryId");
    
    if (!degree) {
      return res.status(404).json({ message: "Degree not found" });
    }
    
    res.json(degree);
  } catch (error) {
    res.status(500).json({ message: "Error fetching degree", error: error.message });
  }
});

// POST create degree
router.post("/degrees", async (req, res) => {
  try {
    const degree = new ServiceDegree(req.body);
    const savedDegree = await degree.save();
    res.status(201).json(savedDegree);
  } catch (error) {
    res.status(500).json({ message: "Error creating degree", error: error.message });
  }
});

// PUT update degree
router.put("/degrees/:id", async (req, res) => {
  try {
    const degree = await ServiceDegree.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    
    if (!degree) {
      return res.status(404).json({ message: "Degree not found" });
    }
    
    res.json(degree);
  } catch (error) {
    res.status(500).json({ message: "Error updating degree", error: error.message });
  }
});

// DELETE degree
router.delete("/degrees/:id", async (req, res) => {
  try {
    const degree = await ServiceDegree.findByIdAndDelete(req.params.id);
    
    if (!degree) {
      return res.status(404).json({ message: "Degree not found" });
    }
    
    res.json({ message: "Degree deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting degree", error: error.message });
  }
});

// ==================== COLLEGES ====================

// GET all colleges
router.get("/colleges", async (req, res) => {
  try {
    const { categoryId, degreeId, active } = req.query;
    const filter = {};
    
    if (categoryId) filter.categoryId = categoryId;
    if (degreeId) filter.degreeId = degreeId;
    if (active === "true") filter.isActive = true;
    
    const colleges = await ServiceCollege.find(filter)
      .populate("categoryId")
      .populate("degreeId")
      .sort({ order: 1 });
    res.json(colleges);
  } catch (error) {
    res.status(500).json({ message: "Error fetching colleges", error: error.message });
  }
});

// GET single college
router.get("/colleges/:id", async (req, res) => {
  try {
    const college = await ServiceCollege.findById(req.params.id)
      .populate("categoryId")
      .populate("degreeId");
    
    if (!college) {
      return res.status(404).json({ message: "College not found" });
    }
    
    res.json(college);
  } catch (error) {
    res.status(500).json({ message: "Error fetching college", error: error.message });
  }
});

// POST create college
router.post("/colleges", async (req, res) => {
  try {
    const college = new ServiceCollege(req.body);
    const savedCollege = await college.save();
    res.status(201).json(savedCollege);
  } catch (error) {
    res.status(500).json({ message: "Error creating college", error: error.message });
  }
});

// PUT update college
router.put("/colleges/:id", async (req, res) => {
  try {
    const college = await ServiceCollege.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    
    if (!college) {
      return res.status(404).json({ message: "College not found" });
    }
    
    res.json(college);
  } catch (error) {
    res.status(500).json({ message: "Error updating college", error: error.message });
  }
});

// DELETE college
router.delete("/colleges/:id", async (req, res) => {
  try {
    const college = await ServiceCollege.findByIdAndDelete(req.params.id);
    
    if (!college) {
      return res.status(404).json({ message: "College not found" });
    }
    
    res.json({ message: "College deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting college", error: error.message });
  }
});

// ==================== BULK OPERATIONS ====================

// GET complete service structure
router.get("/structure", async (req, res) => {
  try {
    const categories = await ServiceCategory.find({ isActive: true }).sort({ order: 1 });
    const structure = {};

    for (const category of categories) {
      const degrees = await ServiceDegree.find({
        categoryId: category._id,
        isActive: true,
      }).sort({ order: 1 });

      const degreeMap = {};

      for (const degree of degrees) {
        const colleges = await ServiceCollege.find({
          degreeId: degree._id,
          isActive: true,
        }).sort({ order: 1 });

        degreeMap[degree.name] = colleges;
      }

      structure[category.key] = {
        config: category,
        degrees: degreeMap,
      };
    }

    res.json(structure);
  } catch (error) {
    res.status(500).json({ message: "Error fetching structure", error: error.message });
  }
});

export default router;
