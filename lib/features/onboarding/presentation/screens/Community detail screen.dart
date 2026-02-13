import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatefulWidget {
  final String communityId;
  final String communityName;
  final String description;
  final IconData icon;
  final Color color;
  final String members;

  const CommunityDetailScreen({
    super.key,
    required this.communityId,
    required this.communityName,
    required this.description,
    required this.icon,
    required this.color,
    required this.members,
  });

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isJoined = false;

  // Mock data - replace with API calls later
  final List<Map<String, dynamic>> mockPosts = [
    {
      'id': '1',
      'author': 'Sarah Johnson',
      'authorAvatar': '👩🏽‍💼',
      'time': '2 hours ago',
      'content': 'Just finished "Half of a Yellow Sun" by Chimamanda Ngozi Adichie. What an incredible journey through Nigerian history! The characters felt so real. Has anyone else read this?',
      'likes': 24,
      'comments': 8,
      'book': 'Half of a Yellow Sun',
    },
    {
      'id': '2',
      'author': 'Michael Chen',
      'authorAvatar': '👨🏻‍💻',
      'time': '5 hours ago',
      'content': 'Looking for recommendations on contemporary African authors. I loved Americanah and want to explore more!',
      'likes': 15,
      'comments': 12,
      'book': null,
    },
    {
      'id': '3',
      'author': 'Amina Abdullah',
      'authorAvatar': '👩🏾‍🎓',
      'time': '1 day ago',
      'content': 'Book club meeting this Friday at 7 PM! We\'ll be discussing "Things Fall Apart". Don\'t forget to finish reading! 📚',
      'likes': 42,
      'comments': 18,
      'book': 'Things Fall Apart',
    },
    {
      'id': '4',
      'author': 'David Okafor',
      'authorAvatar': '👨🏿‍🏫',
      'time': '2 days ago',
      'content': 'I created a reading list of must-read Nigerian novels. Check it out in the files section!',
      'likes': 56,
      'comments': 22,
      'book': null,
    },
  ];

  final List<Map<String, dynamic>> mockDiscussions = [
    {
      'id': '1',
      'title': 'What makes Nigerian literature unique?',
      'author': 'Grace Eze',
      'replies': 34,
      'lastActive': '30 min ago',
      'isPinned': true,
    },
    {
      'id': '2',
      'title': 'Best translations of Yoruba folklore',
      'author': 'Tunde Bakare',
      'replies': 18,
      'lastActive': '2 hours ago',
      'isPinned': false,
    },
    {
      'id': '3',
      'title': 'Modern vs classic Nigerian authors',
      'author': 'Lisa Park',
      'replies': 45,
      'lastActive': '5 hours ago',
      'isPinned': false,
    },
    {
      'id': '4',
      'title': 'Recommend books for beginners',
      'author': 'James Smith',
      'replies': 67,
      'lastActive': '1 day ago',
      'isPinned': false,
    },
  ];

  final List<Map<String, dynamic>> mockMembers = [
    {
      'name': 'Sarah Johnson',
      'avatar': '👩🏽‍💼',
      'role': 'Admin',
      'booksRead': 127,
    },
    {
      'name': 'Michael Chen',
      'avatar': '👨🏻‍💻',
      'role': 'Moderator',
      'booksRead': 89,
    },
    {
      'name': 'Amina Abdullah',
      'avatar': '👩🏾‍🎓',
      'role': 'Member',
      'booksRead': 156,
    },
    {
      'name': 'David Okafor',
      'avatar': '👨🏿‍🏫',
      'role': 'Member',
      'booksRead': 203,
    },
    {
      'name': 'Grace Eze',
      'avatar': '👩🏿‍💼',
      'role': 'Member',
      'booksRead': 78,
    },
    {
      'name': 'Tunde Bakare',
      'avatar': '👨🏿‍🎨',
      'role': 'Member',
      'booksRead': 92,
    },
  ];

  final List<Map<String, dynamic>> mockRecommendedBooks = [
    {
      'title': 'Things Fall Apart',
      'author': 'Chinua Achebe',
      'rating': 4.8,
      'readers': 342,
    },
    {
      'title': 'Half of a Yellow Sun',
      'author': 'Chimamanda Ngozi Adichie',
      'rating': 4.7,
      'readers': 298,
    },
    {
      'title': 'The Famished Road',
      'author': 'Ben Okri',
      'rating': 4.5,
      'readers': 187,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
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
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: widget.color,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
                title: Text(
                  widget.communityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.color,
                        widget.color.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.description,
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.people,
                                      size: 16,
                                      color: theme.textTheme.bodyMedium?.color),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${widget.members} members',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(Icons.auto_stories,
                                      size: 16,
                                      color: theme.textTheme.bodyMedium?.color),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${mockPosts.length} posts today',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isJoined = !isJoined;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isJoined
                                      ? 'Joined ${widget.communityName}!'
                                      : 'Left ${widget.communityName}',
                                ),
                                backgroundColor: theme.colorScheme.primary,
                              ),
                            );
                          },
                          icon: Icon(
                            isJoined ? Icons.check : Icons.add,
                            size: 18,
                          ),
                          label: Text(isJoined ? 'Joined' : 'Join'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isJoined
                                ? theme.colorScheme.surface
                                : theme.colorScheme.primary,
                            foregroundColor: isJoined
                                ? theme.textTheme.bodyLarge?.color
                                : theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: isJoined
                                  ? BorderSide(color: theme.dividerColor)
                                  : BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                  indicatorColor: theme.colorScheme.primary,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: const [
                    Tab(text: 'Posts'),
                    Tab(text: 'Discussions'),
                    Tab(text: 'Members'),
                    Tab(text: 'Books'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildPostsTab(theme, isDark),
            _buildDiscussionsTab(theme, isDark),
            _buildMembersTab(theme, isDark),
            _buildBooksTab(theme, isDark),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreatePostDialog(context, theme);
        },
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
      ),
    );
  }

  Widget _buildPostsTab(ThemeData theme, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockPosts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final post = mockPosts[index];
        return _buildPostCard(post, theme, isDark);
      },
    );
  }

  Widget _buildDiscussionsTab(ThemeData theme, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockDiscussions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final discussion = mockDiscussions[index];
        return _buildDiscussionCard(discussion, theme, isDark);
      },
    );
  }

  Widget _buildMembersTab(ThemeData theme, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockMembers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final member = mockMembers[index];
        return _buildMemberCard(member, theme, isDark);
      },
    );
  }

  Widget _buildBooksTab(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community Recommendations',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Books loved by this community',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ...mockRecommendedBooks.map(
            (book) => _buildBookRecommendationCard(book, theme, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    post['authorAvatar'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['author'],
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      post['time'],
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: theme.textTheme.bodyMedium,
          ),
          if (post['book'] != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 16,
                    color: widget.color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    post['book'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: widget.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildPostAction(
                Icons.favorite_border,
                '${post['likes']}',
                theme,
              ),
              const SizedBox(width: 24),
              _buildPostAction(
                Icons.comment_outlined,
                '${post['comments']}',
                theme,
              ),
              const Spacer(),
              _buildPostAction(
                Icons.share_outlined,
                'Share',
                theme,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String label, ThemeData theme) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: theme.textTheme.bodyMedium?.color),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscussionCard(
      Map<String, dynamic> discussion, ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening "${discussion['title']}"'),
              backgroundColor: theme.colorScheme.primary,
            ),
          );
        },
        child: Row(
          children: [
            if (discussion['isPinned'])
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.push_pin,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 18,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discussion['title'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        'by ${discussion['author']}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.reply, size: 14, color: theme.textTheme.bodySmall?.color),
                      const SizedBox(width: 4),
                      Text(
                        '${discussion['replies']} replies',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(
                  Icons.chevron_right,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                const SizedBox(height: 4),
                Text(
                  discussion['lastActive'],
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member, ThemeData theme, bool isDark) {
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withValues(alpha: 0.7)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                member['avatar'],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      member['name'],
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (member['role'] != 'Member') ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          member['role'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: widget.color,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${member['booksRead']} books read',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Viewing ${member['name']}\'s profile'),
                  backgroundColor: theme.colorScheme.primary,
                ),
              );
            },
            child: Text(
              'View',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookRecommendationCard(
      Map<String, dynamic> book, ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.color, widget.color.withValues(alpha: 0.6)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.menu_book, color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'],
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  book['author'],
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text(
                      '${book['rating']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.people,
                        size: 14, color: theme.textTheme.bodyMedium?.color),
                    const SizedBox(width: 4),
                    Text(
                      '${book['readers']} read',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context, ThemeData theme) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Post'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Share your thoughts with the community...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Post created! (Mock - connect to backend)'),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                );
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}