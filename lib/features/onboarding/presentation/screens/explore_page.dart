import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 180,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 50),
                title: const Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade50, Colors.white],
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green.shade900,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.green.shade900,
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
            _buildBooksTab(),
            _buildCommunitiesTab(),
            _buildBookstoresTab(),
          ],
        ),
      ),
    );
  }

  // BOOKS TAB (unchanged)
  Widget _buildBooksTab() {
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
            child: _buildSearchBar(),
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
                      color: isSelected ? Colors.green.shade900 : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? Colors.green.shade900 : Colors.grey.shade300,
                        width: 1.4,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.green.shade900.withValues(alpha: 0.19),
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
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Colors.black87,
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  '${filteredBooks.length} books',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
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
                        Icon(Icons.book_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          "No books in this category",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
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
                  ),
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // COMMUNITIES TAB - UPDATED with join functionality
  Widget _buildCommunitiesTab() {
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
        'color': Colors.green,
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
          // Active Challenges
          const Text(
            'Active Challenges',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          ...challenges.map((challenge) => _buildChallengeCard(challenge)),
          const SizedBox(height: 24),

          // Book Communities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Book Communities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...communities.map((community) => _buildCommunityCard(community)),
        ],
      ),
    );
  }

  // BOOKSTORES TAB - unchanged for now, will update with map
  Widget _buildBookstoresTab() {
    final bookstores = [
      {
        'name': 'CSS Bookshop Lagos',
        'address': '50/52 Broad Street, Lagos Island',
        'distance': '2.3 km',
        'rating': 4.5,
        'image': Icons.store,
      },
      {
        'name': 'Terra Kulture',
        'address': 'Plot 1376 Tiamiyu Savage Street, Victoria Island',
        'distance': '3.1 km',
        'rating': 4.8,
        'image': Icons.store,
      },
      {
        'name': 'Quintessence',
        'address': '17 Karimu Kotun Street, Victoria Island',
        'distance': '3.5 km',
        'rating': 4.6,
        'image': Icons.store,
      },
      {
        'name': 'Rovingheights Books',
        'address': '16 Awolowo Road, Ikoyi',
        'distance': '4.2 km',
        'rating': 4.7,
        'image': Icons.store,
      },
      {
        'name': 'Jazzhole Records & Books',
        'address': '14 Glover Road, Ikoyi',
        'distance': '4.8 km',
        'rating': 4.4,
        'image': Icons.store,
      },
    ];

    return Column(
      children: [
        // Map Placeholder - Will add actual map integration
        Container(
          height: 250,
          color: Colors.grey.shade200,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      'Map View',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Showing ${bookstores.length} nearby bookstores',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: FloatingActionButton.small(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Getting your location...'),
                      ),
                    );
                  },
                  child: Icon(Icons.my_location, color: Colors.green.shade900),
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
              return _buildBookstoreCard(store);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey.shade600),
          hintText: "Search books, authors...",
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            // Handle search
          }
        },
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    final challengeId = challenge['id'] as String;
    final isJoined = joinedChallenges.contains(challengeId);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.red.shade400],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${challenge['participants']} participants',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Join/Joined Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isJoined) {
                      joinedChallenges.remove(challengeId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Left ${challenge['title']}'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    } else {
                      joinedChallenges.add(challengeId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Joined ${challenge['title']}!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isJoined ? Colors.white30 : Colors.white,
                  foregroundColor: isJoined ? Colors.white : Colors.orange.shade600,
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
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Goal: ${challenge['target']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(Map<String, dynamic> community) {
    final communityId = community['id'] as String;
    final isJoined = joinedCommunities.contains(communityId);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  community['description'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '${community['members']} members',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Left ${community['name']}'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                } else {
                  joinedCommunities.add(communityId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Joined ${community['name']}!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isJoined ? Colors.grey.shade300 : Colors.green.shade900,
              foregroundColor: isJoined ? Colors.black87 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
    );
  }

  Widget _buildBookstoreCard(Map<String, dynamic> store) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              store['image'] as IconData,
              color: Colors.green.shade900,
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  store['address'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
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
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      store['distance'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening directions to ${store['name']}...'),
                ),
              );
            },
            icon: Icon(Icons.directions, color: Colors.green.shade900),
          ),
        ],
      ),
    );
  }
}