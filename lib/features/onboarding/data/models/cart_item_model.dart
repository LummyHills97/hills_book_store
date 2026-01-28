import 'package:flutter/foundation.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';

class CartItem {
  final BookModel book;
  int quantity;

  CartItem({
    required this.book,
    this.quantity = 1,
  });

  double get totalPrice => book.price * quantity;
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shipping => _items.isEmpty ? 0 : 1500;

  double get total => subtotal + shipping;

  bool isInCart(String bookTitle) {
    return _items.any((item) => item.book.title == bookTitle);
  }

  void addItem(BookModel book) {
    final existingIndex =
        _items.indexWhere((item) => item.book.title == book.title);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(book: book));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuantity(int index, int quantity) {
    if (index >= 0 && index < _items.length) {
      if (quantity <= 0) {
        removeItem(index);
      } else {
        _items[index].quantity = quantity;
        notifyListeners();
      }
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        notifyListeners();
      } else {
        removeItem(index);
      }
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  CartItem? getItemByTitle(String title) {
    try {
      return _items.firstWhere((item) => item.book.title == title);
    } catch (e) {
      return null;
    }
  }
}
