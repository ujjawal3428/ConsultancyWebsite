
export const getAllCategories = async (req, res) => {
  const categories = await Category.find();
  res.json(categories);
};

export const addCategory = async (req, res) => {
  const newCategory = new Category(req.body);
  await newCategory.save();
  res.json({ message: "Category added successfully" });
};

export const updateCategory = async (req, res) => {
  await Category.findByIdAndUpdate(req.params.id, req.body);
  res.json({ message: "Category updated successfully" });
};

export const deleteCategory = async (req, res) => {
  await Category.findByIdAndDelete(req.params.id);
  res.json({ message: "Category deleted successfully" });
};
