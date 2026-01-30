import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = 'All';
  
  // Simulated user library data
  final Set<String> favoriteBooks = {
    'Americanah',
    'Half of a Yellow Sun',
    'Things Fall Apart',
    'Purple Hibiscus',
    'The Secret Lives of Baba Segi\'s Wives',
  };
  
  final Set<String> finishedBooks = {
    'Things Fall Apart',
    'Sulwe',
    'We\'re Going on a Bear Hunt',
    'Hopeless',
    'The Dating Plan',
  };
  
  final Map<String, double> currentlyReadingProgress = {
    'Americanah': 0.45,
    'Half of a Yellow Sun': 0.23,
    'Purple Hibiscus': 0.78,
  };

  // Stats
  int get totalBooksRead => finishedBooks.length;
  int get totalPages => finishedBooks.length * 250;
  int get hoursRead => finishedBooks.length * 8;
  int get readingStreak => 7;
  int get todayMinutes => 45;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<BookModel> get currentlyReadingBooks {
    return books.where((book) => currentlyReadingProgress.containsKey(book.title)).toList();
  }

  List<BookModel> get favoriteBooksList {
    return books.where((book) => favoriteBooks.contains(book.title)).toList();
  }

  List<BookModel> get finishedBooksList {
    return books.where((book) => finishedBooks.contains(book.title)).toList();
  }

  List<BookModel> get filteredBooks {
    if (selectedCategory == 'All') return books;
    return books.where((book) => book.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(theme),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          _buildReadingStats(theme, isDark),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          if (currentlyReadingBooks.isNotEmpty) ...[
            _buildCurrentlyReading(theme, isDark),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
          _buildTabBar(theme, isDark),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          _buildTabContent(theme, isDark),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'My Library',
          style: theme.textTheme.displayMedium?.copyWith(fontSize: 28),
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: theme.iconTheme.color),
          onPressed: () {
            // Implement search
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list, color: theme.iconTheme.color),
          onPressed: () => _showFilterSheet(theme),
        ),
      ],
    );
  }

  Widget _buildReadingStats(ThemeData theme, bool isDark) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1B4332), const Color(0xFF2D6A4F)]
                  : [const Color(0xFF1B4332), const Color(0xFF2D6A4F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Reading Streak',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              '🔥',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$readingStreak days',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$todayMinutes',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'minutes',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _buildMiniStat('$totalBooksRead', 'Books Read', Icons.menu_book),
                  const SizedBox(width: 12),
                  _buildMiniStat('${(totalPages / 1000).toStringAsFixed(1)}k', 'Pages', Icons.description),
                  const SizedBox(width: 12),
                  _buildMiniStat('${hoursRead}h', 'Time', Icons.schedule),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentlyReading(ThemeData theme, bool isDark) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Continue Reading',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: currentlyReadingBooks.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final book = currentlyReadingBooks[index];
                final progress = currentlyReadingProgress[book.title] ?? 0.0;
                return _buildReadingCard(book, progress, theme, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingCard(BookModel book, double progress, ThemeData theme, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(
              title: book.title,
              author: book.author,
              imagePath: book.imagePath,
              price: book.price,
              description: book.description,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                book.imagePath,
                height: 110,
                width: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 110,
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.auto_stories,
                      size: 40,
                      color: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: theme.dividerColor,
                      color: theme.colorScheme.primary,
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(progress * 100).toInt()}% completed',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme, bool isDark) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [theme.colorScheme.primary, theme.colorScheme.secondary]
                    : [theme.colorScheme.primary, theme.colorScheme.secondary],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: isDark ? theme.colorScheme.onPrimary : Colors.white,
            unselectedLabelColor: theme.textTheme.bodyMedium?.color,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'All (${filteredBooks.length})'),
              Tab(text: 'Favorites (${favoriteBooksList.length})'),
              Tab(text: 'Finished (${finishedBooksList.length})'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(ThemeData theme, bool isDark) {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildBookGrid(filteredBooks, theme, isDark),
          _buildBookGrid(favoriteBooksList, theme, isDark),
          _buildBookGrid(finishedBooksList, theme, isDark),
        ],
      ),
    );
  }

  Widget _buildBookGrid(List<BookModel> bookList, ThemeData theme, bool isDark) {
    if (bookList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_stories_outlined,
                size: 64,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No books here yet',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Start exploring to add books',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.58,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        return _buildBookCover(bookList[index], theme, isDark);
      },
    );
  }

  Widget _buildBookCover(BookModel book, ThemeData theme, bool isDark) {
    final isFavorite = favoriteBooks.contains(book.title);
    final isFinished = finishedBooks.contains(book.title);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(
              title: book.title,
              author: book.author,
              imagePath: book.imagePath,
              price: book.price,
              description: book.description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                book.imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.auto_stories,
                        size: 32,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (isFavorite)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            if (isFinished)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [theme.colorScheme.primary, theme.colorScheme.secondary]
                          : [theme.colorScheme.primary, theme.colorScheme.secondary],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: isDark ? theme.colorScheme.onPrimary : Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Finished',
                        style: TextStyle(
                          color: isDark ? theme.colorScheme.onPrimary : Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(ThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Filter by Category',
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['All', 'Fiction', 'Mystery', 'Romance', 'Drama', 'History', 'Religion']
                  .map((category) => FilterChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                          Navigator.pop(context);
                        },
                        selectedColor: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.surface,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? (theme.brightness == Brightness.dark
                                  ? theme.colorScheme.onPrimary
                                  : Colors.white)
                              : theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: selectedCategory == category
                                ? theme.colorScheme.primary
                                : theme.dividerColor,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}