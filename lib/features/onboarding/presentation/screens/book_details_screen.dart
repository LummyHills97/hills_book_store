import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/Providers/cart_provider.dart';
import 'package:hills_book_store/core/utils/currency_formatter.dart';
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: theme.appBarTheme.titleTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Book Cover ---
            Center(
              child: Hero(
                tag: 'book_$title',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      height: 320,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 320,
                          width: 220,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.dividerColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.auto_stories,
                            size: 80,
                            color: theme.iconTheme.color?.withValues(alpha: 0.3),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- Title & Author ---
            Text(
              title,
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 18,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                const SizedBox(width: 6),
                Text(
                  author,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Price Card ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          theme.colorScheme.primary.withValues(alpha: 0.2),
                          theme.colorScheme.secondary.withValues(alpha: 0.1),
                        ]
                      : [
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                          theme.colorScheme.secondary.withValues(alpha: 0.05),
                        ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        CurrencyFormatter.format(price),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- Description ---
            Text(
              'About this book',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),

            // --- Add to Cart Button ---
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                final isInCart = cart.isInCart(title);

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                              Icon(
                                Icons.check_circle,
                                color: isDark ? theme.colorScheme.primary : Colors.white,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '$title added to cart!',
                                  style: TextStyle(
                                    color: isDark ? theme.colorScheme.onSurface : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: isDark ? theme.colorScheme.surface : theme.colorScheme.primary,
                          duration: const Duration(seconds: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isInCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          isInCart ? 'Add More to Cart' : 'Add to Cart',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}