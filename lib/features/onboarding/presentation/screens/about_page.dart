import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: theme.appBarTheme.titleTextStyle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // App Info Card
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
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
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_stories,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Hills Book Store',
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Version 1.0.0',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Your gateway to endless stories. Discover, read, and share your favorite books with a community of readers.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Links
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text('Legal & Info', style: theme.textTheme.titleLarge),
          ),

          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildLinkTile(
                  theme,
                  icon: Icons.article_outlined,
                  title: 'Terms of Service',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Opening Terms of Service...'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildLinkTile(
                  theme,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Opening Privacy Policy...'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildLinkTile(
                  theme,
                  icon: Icons.gavel_outlined,
                  title: 'Licenses',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Opening Licenses...'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildLinkTile(
                  theme,
                  icon: Icons.web_outlined,
                  title: 'Visit Website',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Opening www.hillsbooks.com...'),
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Social Links
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text('Follow Us', style: theme.textTheme.titleLarge),
          ),

          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  theme,
                  icon: Icons.facebook,
                  label: 'Facebook',
                  color: const Color(0xFF1877F2),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  theme,
                  icon: Icons.alternate_email,
                  label: 'Twitter',
                  color: const Color(0xFF1DA1F2),
                  onTap: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildSocialButton(
                  theme,
                  icon: Icons.camera_alt,
                  label: 'Instagram',
                  color: const Color(0xFFE4405F),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton(
                  theme,
                  icon: Icons.play_arrow,
                  label: 'YouTube',
                  color: const Color(0xFFFF0000),
                  onTap: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Copyright
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(height: 12),
                Text(
                  '© 2024 Hills Book Store',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'All rights reserved',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Text(
                  'Made with ❤️ in Nigeria',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
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
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}