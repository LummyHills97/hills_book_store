import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';
import 'package:hills_book_store/features/onboarding/data/models/cart_item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  // Getter for cart items
  List<CartItem> get items => _items;

  // Get total number of items (counting quantities)
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Calculate subtotal (sum of all items * their quantities)
  double get subtotal {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.book.price * item.quantity),
    );
  }

  // Shipping cost (free if cart is empty, otherwise ₦1500)
  double get shipping => _items.isEmpty ? 0 : 1500;

  // Calculate total (subtotal + shipping)
  double get total => subtotal + shipping;

  // Add item to cart
  void addItem(BookModel book) {
    // Check if book already exists in cart by comparing titles
    final existingIndex = _items.indexWhere(
      (item) => item.book.title == book.title,
    );

    if (existingIndex >= 0) {
      // Book already in cart, just increment quantity
      _items[existingIndex].quantity++;
    } else {
      // New book, add to cart with quantity 1
      _items.add(CartItem(book: book, quantity: 1));
    }

    // Notify all listeners (widgets) that the cart has changed
    notifyListeners();
  }

  // Remove item from cart by index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  // Increment quantity of an item
  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Decrement quantity of an item (remove if quantity becomes 0)
  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        // If quantity is 1, remove the item instead
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Clear all items from cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Check if a specific book is in the cart
  bool isInCart(String bookTitle) {
    return _items.any((item) => item.book.title == bookTitle);
  }

  // Get quantity of a specific book in cart
  int getBookQuantity(String bookTitle) {
    final item = _items.firstWhere(
      (item) => item.book.title == bookTitle,
      orElse: () => CartItem(
        book: BookModel(
          title: '',
          author: '',
          imagePath: '',
          price: 0,
          category: '',
          description: '',
        ),
        quantity: 0,
      ),
    );
    return item.quantity;
  }
}