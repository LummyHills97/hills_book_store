import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/Providers/cart_provider.dart'; // FIX: Add this import
import 'package:provider/provider.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  final String title;
  final String author;
  final String imagePath;
  final double price;
  final String description;

  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Book Cover ---
            Center(
              child: Hero(
                tag: 'book_$title',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    height: 260,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 260,
                        width: 180,
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.book,
                          size: 60,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Title & Author ---
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "by $author",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),

            // --- Price ---
            Text(
              "₦${price.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 20),

            // --- Description ---
            const Text(
              "About this book",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // --- Add to Cart Button ---
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                final isInCart = cart.isInCart(title);
                
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final book = BookModel(
                        title: title,
                        author: author,
                        imagePath: imagePath,
                        price: price,
                        category: '',
                        description: description,
                      );
                      
                      cart.addItem(book);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text("$title added to cart!"),
                              ),
                            ],
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green.shade900,
                          duration: const Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      isInCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      isInCart ? "Add More" : "Add to Cart",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}