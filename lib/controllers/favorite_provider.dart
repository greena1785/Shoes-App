import 'package:flutter/material.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  // Getter for favorites
  List<Map<String, dynamic>> get favorites => _favorites;

  // Add item to favorites
  void addToFavorites(Map<String, dynamic> item) {
    _favorites.add(item);
    notifyListeners(); // Notify listeners about the change
  }

  // Remove item from favorites
  void removeFromFavorites(String id) {
    _favorites.removeWhere((item) => item['id'] == id);
    notifyListeners(); // Notify listeners about the change
  }

  // Method to update favorites (useful when adding from ProductPage)
  void updateFavorites() {
    notifyListeners(); // Notify listeners about the change
  }
}
