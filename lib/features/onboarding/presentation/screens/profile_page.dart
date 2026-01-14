import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/edit_profile_page.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: [
          // Collapsing header with profile info
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF5E5CE6), Color(0xFF8E8DFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 60),
                    ProfileAvatar(radius: 55),
                    SizedBox(height: 16),
                    Text(
                      'Akinnuli Olumide',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Book Enthusiast',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Profile content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account section
                  const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuCard([
                    _buildMenuItem(
                      context: context,
                      icon: Icons.person,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.notifications,
                      title: 'Notifications',
                      trailing: Switch(
                        value: true,
                        onChanged: (val) {},
                        activeColor: const Color(0xFF5E5CE6),
                      ),
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.lock,
                      title: 'Privacy',
                      onTap: () {
                        // TODO: Navigate to Privacy page
                      },
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Preferences section
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuCard([
                    _buildMenuItem(
                      context: context,
                      icon: Icons.dark_mode,
                      title: 'Dark Mode',
                      trailing: Switch(
                        value: false,
                        onChanged: (val) {},
                        activeColor: const Color(0xFF5E5CE6),
                      ),
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'English',
                      onTap: () {
                        // TODO: Navigate to Language selection page
                      },
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.storage,
                      title: 'Storage',
                      subtitle: '2.4 GB used',
                      onTap: () {
                        // TODO: Navigate to Storage management page
                      },
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Support section
                  const Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuCard([
                    _buildMenuItem(
                      context: context,
                      icon: Icons.help,
                      title: 'Help Center',
                      onTap: () {
                        // TODO: Navigate to Help Center page
                      },
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.info,
                      title: 'About',
                      onTap: () {
                        // TODO: Navigate to About page
                      },
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: Icons.logout,
                      title: 'Log Out',
                      textColor: const Color(0xFFFF6B6B),
                      onTap: () {
                        // TODO: Implement logout functionality
                        _showLogoutDialog(context);
                      },
                    ),
                  ]),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (textColor ?? const Color(0xFF5E5CE6)).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: textColor ?? const Color(0xFF5E5CE6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? Colors.black,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement actual logout logic
              },
              child: const Text(
                'Log Out',
                style: TextStyle(color: Color(0xFFFF6B6B)),
              ),
            ),
          ],
        );
      },
    );
  }
}