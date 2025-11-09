import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/service_category.dart';
import '../models/service_degree.dart';
import '../models/service_college.dart';

class ServiceManagementService {
  static const String baseUrl = 'http://localhost:55611/#/admin';

  // ==================== CATEGORIES ====================

  // Get all categories
  Future<List<ServiceCategory>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Get active categories
  Future<List<ServiceCategory>> getActiveCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories?active=true'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Get category by ID
  Future<ServiceCategory?> getCategoryById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories/$id'));

      if (response.statusCode == 200) {
        return ServiceCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }

  // Create category
  Future<String> createCategory(ServiceCategory category) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/categories'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(category.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data['_id'] ?? data['id'];
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  // Update category
  Future<void> updateCategory(String id, ServiceCategory category) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/categories/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(category.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  // Delete category
  Future<void> deleteCategory(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/categories/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete category');
      }
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

  // ==================== DEGREES ====================

  // Get all degrees
  Future<List<ServiceDegree>> getDegrees() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/degrees'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceDegree.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load degrees');
      }
    } catch (e) {
      throw Exception('Error fetching degrees: $e');
    }
  }

  // Get degrees by category
  Future<List<ServiceDegree>> getDegreesByCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/degrees?categoryId=$categoryId&active=true'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceDegree.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load degrees');
      }
    } catch (e) {
      throw Exception('Error fetching degrees: $e');
    }
  }

  // Get degree by ID
  Future<ServiceDegree?> getDegreeById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/degrees/$id'));

      if (response.statusCode == 200) {
        return ServiceDegree.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching degree: $e');
    }
  }

  // Create degree
  Future<String> createDegree(ServiceDegree degree) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/degrees'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(degree.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data['_id'] ?? data['id'];
      } else {
        throw Exception('Failed to create degree');
      }
    } catch (e) {
      throw Exception('Error creating degree: $e');
    }
  }

  // Update degree
  Future<void> updateDegree(String id, ServiceDegree degree) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/degrees/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(degree.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update degree');
      }
    } catch (e) {
      throw Exception('Error updating degree: $e');
    }
  }

  // Delete degree
  Future<void> deleteDegree(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/degrees/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete degree');
      }
    } catch (e) {
      throw Exception('Error deleting degree: $e');
    }
  }

  // ==================== COLLEGES ====================

  // Get all colleges
  Future<List<ServiceCollege>> getColleges() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/colleges'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceCollege.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load colleges');
      }
    } catch (e) {
      throw Exception('Error fetching colleges: $e');
    }
  }

  // Get colleges by degree
  Future<List<ServiceCollege>> getCollegesByDegree(String degreeId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/colleges?degreeId=$degreeId&active=true'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceCollege.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load colleges');
      }
    } catch (e) {
      throw Exception('Error fetching colleges: $e');
    }
  }

  // Get colleges by category
  Future<List<ServiceCollege>> getCollegesByCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/colleges?categoryId=$categoryId&active=true'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServiceCollege.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load colleges');
      }
    } catch (e) {
      throw Exception('Error fetching colleges: $e');
    }
  }

  // Get college by ID
  Future<ServiceCollege?> getCollegeById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/colleges/$id'));

      if (response.statusCode == 200) {
        return ServiceCollege.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching college: $e');
    }
  }

  // Create college
  Future<String> createCollege(ServiceCollege college) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/colleges'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(college.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return data['_id'] ?? data['id'];
      } else {
        throw Exception('Failed to create college');
      }
    } catch (e) {
      throw Exception('Error creating college: $e');
    }
  }

  // Update college
  Future<void> updateCollege(String id, ServiceCollege college) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/colleges/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(college.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update college');
      }
    } catch (e) {
      throw Exception('Error updating college: $e');
    }
  }

  // Delete college
  Future<void> deleteCollege(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/colleges/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete college');
      }
    } catch (e) {
      throw Exception('Error deleting college: $e');
    }
  }

  // ==================== BULK OPERATIONS ====================

  // Get complete service structure (for frontend display)
  Future<Map<String, dynamic>> getCompleteServiceStructure() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/structure'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load service structure');
      }
    } catch (e) {
      throw Exception('Error fetching service structure: $e');
    }
  }
}
