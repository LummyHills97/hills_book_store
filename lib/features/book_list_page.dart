import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

class BookListPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> books;

  const BookListPage({
    super.key,
    required this.category,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books
        .where((b) => b['category'].toLowerCase() == category.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: filteredBooks.isEmpty
          ? const Center(
              child: Text(
                "No books available",
                style: TextStyle(fontSize: 16),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredBooks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return BookCard(
                  title: book['title'],
                  author: book['author'],
                  imagePath: book['image'],
                  price: double.tryParse(book['price'].replaceAll('₦', '').replaceAll('\$', '')) ?? 0.0,
                  onTap: () {
                    // Navigate to book detail later
                  },
                );
              },
            ),
    );
  }
}
