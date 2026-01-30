import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hills_book_store/features/onboarding/providers/profile_provider.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_avatar.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/about_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/edit_profile_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/help_center_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/language_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/privacy_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/storage_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profile = profileProvider.profile;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Profile',
                    style: theme.textTheme.displayMedium?.copyWith(fontSize: 28),
                  ),
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Profile Header Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                const Color(0xFF1B4332),
                                const Color(0xFF2D6A4F),
                              ]
                            : [
                                const Color(0xFF1B4332),
                                const Color(0xFF2D6A4F),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const ProfileAvatar(radius: 55),
                        const SizedBox(height: 16),
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white70,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              profile.location,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _buildMenuCard(
                        theme,
                        isDark,
                        [
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.person_outline,
                            title: 'Edit Profile',
                            subtitle: 'Update your personal information',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfilePage(),
                                ),
                              );
                            },
                          ),
                          Divider(color: theme.dividerColor, height: 1),
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.lock_outline,
                            title: 'Privacy & Security',
                            subtitle: 'Manage your privacy settings',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Preferences',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _buildMenuCard(
                        theme,
                        isDark,
                        [
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.language_outlined,
                            title: 'Language',
                            subtitle: 'English',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LanguagePage(),
                                ),
                              );
                            },
                          ),
                          Divider(color: theme.dividerColor, height: 1),
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.dark_mode_outlined,
                            title: 'Theme',
                            subtitle: 'System default',
                            trailing: Icon(
                              isDark ? Icons.dark_mode : Icons.light_mode,
                              color: theme.colorScheme.primary,
                            ),
                            onTap: () {
                              // Theme switching logic here
                            },
                          ),
                          Divider(color: theme.dividerColor, height: 1),
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.storage_outlined,
                            title: 'Storage',
                            subtitle: 'Manage app storage',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StoragePage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Support',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _buildMenuCard(
                        theme,
                        isDark,
                        [
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.help_outline,
                            title: 'Help Center',
                            subtitle: 'FAQs and support',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HelpCenterPage(),
                                ),
                              );
                            },
                          ),
                          Divider(color: theme.dividerColor, height: 1),
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.info_outline,
                            title: 'About',
                            subtitle: 'Version 1.0.0',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutPage(),
                                ),
                              );
                            },
                          ),
                          Divider(color: theme.dividerColor, height: 1),
                          _buildMenuItem(
                            context: context,
                            theme: theme,
                            icon: Icons.logout,
                            title: 'Log Out',
                            textColor: Colors.red.shade600,
                            onTap: () {
                              _showLogoutDialog(context, theme);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuCard(ThemeData theme, bool isDark, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required ThemeData theme,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    final itemColor = textColor ?? theme.colorScheme.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: itemColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: itemColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall,
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
                  color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red.shade600),
              const SizedBox(width: 12),
              const Text('Log Out'),
            ],
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 12),
                        Text('Logged out successfully'),
                      ],
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}