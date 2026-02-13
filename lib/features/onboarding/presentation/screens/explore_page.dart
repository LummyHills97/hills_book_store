import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/Community%20detail%20screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';
// Import the new community detail screen

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  late TabController _tabController;

  // Track joined communities and challenges
  Set<String> joinedCommunities = {};
  Set<String> joinedChallenges = {};

  final List<String> _categories = [
    'All',
    'Fiction',
    'Mystery',
    'Romance',
    'Drama',
    'History',
    'Religion',
  ];

  final Map<String, IconData> categoryIcons = {
    'All': Icons.apps_rounded,
    'Fiction': Icons.auto_stories_rounded,
    'Mystery': Icons.search_rounded,
    'Romance': Icons.favorite_rounded,
    'Drama': Icons.theater_comedy_rounded,
    'History': Icons.menu_book_rounded,
    'Religion': Icons.church_rounded,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 180,
              floating: false,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 50),
                title: Text(
                  'Explore',
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 28),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                              theme.scaffoldBackgroundColor,
                            ]
                          : [
                              theme.colorScheme.primary.withValues(alpha: 0.05),
                              theme.scaffoldBackgroundColor,
                            ],
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: theme.scaffoldBackgroundColor,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                    indicatorColor: theme.colorScheme.primary,
                    indicatorWeight: 3,
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: const [
                      Tab(text: 'Books'),
                      Tab(text: 'Communities'),
                      Tab(text: 'Bookstores'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBooksTab(theme, isDark),
            _buildCommunitiesTab(theme, isDark),
            _buildBookstoresTab(theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildBooksTab(ThemeData theme, bool isDark) {
    final selectedCategory = _categories[_selectedCategoryIndex];
    final filteredBooks = selectedCategory == 'All'
        ? books
        : books.where((b) => b.category == selectedCategory).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildSearchBar(theme),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isSelected = index == _selectedCategoryIndex;
                final category = _categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategoryIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: isDark
                                  ? [theme.colorScheme.primary, theme.colorScheme.secondary]
                                  : [theme.colorScheme.primary, theme.colorScheme.secondary],
                            )
                          : null,
                      color: isSelected ? null : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
                        width: 1.4,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          categoryIcons[category],
                          size: 18,
                          color: isSelected
                              ? (isDark ? theme.colorScheme.onPrimary : Colors.white)
                              : theme.iconTheme.color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? (isDark ? theme.colorScheme.onPrimary : Colors.white)
                                : theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory == 'All' ? 'All Books' : selectedCategory,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${filteredBooks.length} books',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          filteredBooks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: theme.iconTheme.color?.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No books in this category",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredBooks.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookCard(
                        title: book.title,
                        author: book.author,
                        imagePath: book.imagePath,
                        price: book.price,
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
                      );
                    },
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCommunitiesTab(ThemeData theme, bool isDark) {
    final communities = [
      {
        'id': 'fiction_lovers',
        'name': 'Fiction Lovers Club',
        'members': '1.2k',
        'icon': Icons.auto_stories,
        'color': Colors.blue,
        'description': 'Join fellow fiction enthusiasts',
      },
      {
        'id': 'mystery_society',
        'name': 'Mystery Readers Society',
        'members': '856',
        'icon': Icons.search,
        'color': Colors.purple,
        'description': 'Solve mysteries together',
      },
      {
        'id': 'romance_club',
        'name': 'Romance Book Club',
        'members': '2.1k',
        'icon': Icons.favorite,
        'color': Colors.red,
        'description': 'Share your favorite love stories',
      },
      {
        'id': 'nigerian_lit',
        'name': 'Nigerian Literature',
        'members': '945',
        'icon': Icons.public,
        'color': theme.colorScheme.primary,
        'description': 'Celebrate African stories',
      },
    ];

    final challenges = [
      {
        'id': 'challenge_2026',
        'title': '2026 Reading Challenge',
        'participants': '3.5k',
        'progress': 0.42,
        'target': '50 books',
      },
      {
        'id': 'feb_sprint',
        'title': 'February Book Sprint',
        'participants': '892',
        'progress': 0.65,
        'target': '5 books',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Challenges',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          ...challenges.map((challenge) => _buildChallengeCard(challenge, theme, isDark)),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Book Communities',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
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
          const SizedBox(height: 14),
          ...communities.map((community) => _buildCommunityCard(community, theme, isDark)),
        ],
      ),
    );
  }

  Widget _buildBookstoresTab(ThemeData theme, bool isDark) {
    // Mock bookstore data - Replace with API call when backend is ready
    final bookstores = [
      {
        'name': 'CSS Bookshop Lagos',
        'address': '50/52 Broad Street, Lagos Island',
        'distance': '2.3 km',
        'rating': 4.5,
        'image': Icons.store,
        'lat': 6.4541, // Lagos Island coordinates
        'lng': 3.3947,
      },
      {
        'name': 'Terra Kulture',
        'address': 'Plot 1376 Tiamiyu Savage Street, Victoria Island',
        'distance': '3.1 km',
        'rating': 4.8,
        'image': Icons.store,
        'lat': 6.4281,
        'lng': 3.4219,
      },
      {
        'name': 'Quintessence',
        'address': '17 Karimu Kotun Street, Victoria Island',
        'distance': '3.5 km',
        'rating': 4.6,
        'image': Icons.store,
        'lat': 6.4274,
        'lng': 3.4207,
      },
      {
        'name': 'Rovingheights Books',
        'address': '16 Awolowo Road, Ikoyi',
        'distance': '4.2 km',
        'rating': 4.7,
        'image': Icons.store,
        'lat': 6.4541,
        'lng': 3.4316,
      },
      {
        'name': 'Jazzhole Records & Books',
        'address': '14 Glover Road, Ikoyi',
        'distance': '4.8 km',
        'rating': 4.4,
        'image': Icons.store,
        'lat': 6.4496,
        'lng': 3.4352,
      },
    ];

    return Column(
      children: [
        // This Container will be replaced with Google Map widget
        // For now showing placeholder with instructions
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      theme.colorScheme.primary.withValues(alpha: 0.2),
                      theme.colorScheme.surface,
                    ]
                  : [
                      theme.colorScheme.primary.withValues(alpha: 0.1),
                      theme.colorScheme.surface,
                    ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 64,
                      color: theme.iconTheme.color?.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Map View (Google Maps Integration)',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Showing ${bookstores.length} nearby bookstores',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'See bookstores_map_widget.dart',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton.small(
                  backgroundColor: theme.colorScheme.surface,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Getting your location...'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                  child: Icon(Icons.my_location, color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bookstores.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final store = bookstores[index];
              return _buildBookstoreCard(store, theme, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: TextField(
        controller: _searchController,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: theme.iconTheme.color?.withValues(alpha: 0.6)),
          hintText: "Search books, authors...",
          hintStyle: theme.textTheme.bodyMedium,
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            // Handle search
          }
        },
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge, ThemeData theme, bool isDark) {
    final challengeId = challenge['id'] as String;
    final isJoined = joinedChallenges.contains(challengeId);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [theme.colorScheme.primary, theme.colorScheme.secondary]
              : [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: isDark ? theme.colorScheme.onPrimary : Colors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge['title'],
                      style: TextStyle(
                        color: isDark ? theme.colorScheme.onPrimary : Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${challenge['participants']} participants',
                      style: TextStyle(
                        color: isDark
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.7)
                            : Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isJoined) {
                      joinedChallenges.remove(challengeId);
                    } else {
                      joinedChallenges.add(challengeId);
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isJoined
                            ? 'Left ${challenge['title']}'
                            : 'Joined ${challenge['title']}!',
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isJoined
                      ? Colors.white.withValues(alpha: 0.3)
                      : (isDark ? theme.colorScheme.onPrimary : Colors.white),
                  foregroundColor: isJoined
                      ? (isDark ? theme.colorScheme.onPrimary : Colors.white)
                      : theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isJoined ? 'Joined ✓' : 'Join',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: challenge['progress'],
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? theme.colorScheme.tertiary : Colors.white,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Goal: ${challenge['target']}',
            style: TextStyle(
              color: isDark ? theme.colorScheme.onPrimary : Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(Map<String, dynamic> community, ThemeData theme, bool isDark) {
    final communityId = community['id'] as String;
    final isJoined = joinedCommunities.contains(communityId);

    return InkWell(
      onTap: () {
        // Navigate to CommunityDetailScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommunityDetailScreen(
              communityId: communityId,
              communityName: community['name'] as String,
              description: community['description'] as String,
              icon: community['icon'] as IconData,
              color: community['color'] as Color,
              members: community['members'] as String,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: (community['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                community['icon'] as IconData,
                color: community['color'] as Color,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community['name'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    community['description'] as String,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 14,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${community['members']} members',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isJoined) {
                    joinedCommunities.remove(communityId);
                  } else {
                    joinedCommunities.add(communityId);
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isJoined
                          ? 'Left ${community['name']}'
                          : 'Joined ${community['name']}!',
                    ),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isJoined ? theme.colorScheme.surface : theme.colorScheme.primary,
                foregroundColor: isJoined ? theme.textTheme.bodyLarge?.color : theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: isJoined ? BorderSide(color: theme.dividerColor) : BorderSide.none,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                isJoined ? 'Joined ✓' : 'Join',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookstoreCard(Map<String, dynamic> store, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              store['image'] as IconData,
              color: theme.colorScheme.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store['name'] as String,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  store['address'] as String,
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text(
                      '${store['rating']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      store['distance'] as String,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // This will open Google Maps with directions
              // Using url_launcher package
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening directions to ${store['name']}...'),
                  backgroundColor: theme.colorScheme.primary,
                ),
              );
            },
            icon: Icon(Icons.directions, color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }
}