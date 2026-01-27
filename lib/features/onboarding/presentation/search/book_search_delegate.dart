import 'package:flutter/material.dart';

import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

class BookSearchDelegate extends SearchDelegate<BookModel?> {
  @override
  String get searchFieldLabel => 'Search books';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = books.where((book) {
      final q = query.toLowerCase();
      return book.title.toLowerCase().contains(q) ||
          book.author.toLowerCase().contains(q) ||
          book.category.toLowerCase().contains(q);
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('No books found'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final book = results[index];
        return BookCard(
          title: book.title,
          author: book.author,
          imagePath: book.imagePath,
          price: book.price,
          onTap: () {
            close(context, book);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookDetailsScreen(
                  title: book.title,
                  author: book.author,
                  imagePath: book.imagePath,
                  price: book.price,
                  description: book.description,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Search by title, author, or category'),
      );
    }
    return buildResults(context);
  }
}
