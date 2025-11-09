import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/content_item.dart';

class ContentService {
  static const String baseUrl = 'http://localhost:55611/#/admin';

  // Get all content items
  Future<List<ContentItem>> getAllContent({String? category}) async {
    try {
      final url = category != null ? '$baseUrl?category=$category' : baseUrl;

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ContentItem.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load content');
      }
    } catch (e) {
      throw Exception('Error fetching content: $e');
    }
  }

  // Get single content item
  Future<ContentItem> getContentById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        return ContentItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load content');
      }
    } catch (e) {
      throw Exception('Error fetching content: $e');
    }
  }

  // Create new content
  Future<ContentItem> createContent(ContentItem content) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(content.toJson()),
      );

      if (response.statusCode == 201) {
        return ContentItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create content');
      }
    } catch (e) {
      throw Exception('Error creating content: $e');
    }
  }

  // Update content
  Future<ContentItem> updateContent(String id, ContentItem content) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(content.toJson()),
      );

      if (response.statusCode == 200) {
        return ContentItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update content');
      }
    } catch (e) {
      throw Exception('Error updating content: $e');
    }
  }

  // Delete content
  Future<void> deleteContent(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete content');
      }
    } catch (e) {
      throw Exception('Error deleting content: $e');
    }
  }
}
