import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool accountPrivate = false;
  bool showReadingActivity = true;
  bool allowRecommendations = true;
  bool dataSharing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security', style: theme.appBarTheme.titleTextStyle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            theme,
            isDark,
            title: 'Privacy',
            items: [
              _buildSwitchTile(
                theme,
                icon: Icons.lock_outline,
                title: 'Private Account',
                subtitle: 'Only followers can see your activity',
                value: accountPrivate,
                onChanged: (val) => setState(() => accountPrivate = val),
              ),
              Divider(color: theme.dividerColor, height: 1),
              _buildSwitchTile(
                theme,
                icon: Icons.visibility_outlined,
                title: 'Show Reading Activity',
                subtitle: 'Let others see what you\'re reading',
                value: showReadingActivity,
                onChanged: (val) => setState(() => showReadingActivity = val),
              ),
              Divider(color: theme.dividerColor, height: 1),
              _buildSwitchTile(
                theme,
                icon: Icons.recommend_outlined,
                title: 'Personalized Recommendations',
                subtitle: 'Get book suggestions based on your activity',
                value: allowRecommendations,
                onChanged: (val) => setState(() => allowRecommendations = val),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            theme,
            isDark,
            title: 'Security',
            items: [
              _buildTile(
                theme,
                icon: Icons.password_outlined,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Password change coming soon'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              Divider(color: theme.dividerColor, height: 1),
              _buildTile(
                theme,
                icon: Icons.security_outlined,
                title: 'Two-Factor Authentication',
                subtitle: 'Add extra security to your account',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('2FA coming soon'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            theme,
            isDark,
            title: 'Data',
            items: [
              _buildSwitchTile(
                theme,
                icon: Icons.share_outlined,
                title: 'Data Sharing',
                subtitle: 'Share usage data for improvements',
                value: dataSharing,
                onChanged: (val) => setState(() => dataSharing = val),
              ),
              Divider(color: theme.dividerColor, height: 1),
              _buildTile(
                theme,
                icon: Icons.download_outlined,
                title: 'Download Your Data',
                subtitle: 'Get a copy of your information',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Data download initiated'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              Divider(color: theme.dividerColor, height: 1),
              _buildTile(
                theme,
                icon: Icons.delete_forever_outlined,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                textColor: Colors.red.shade600,
                onTap: () => _showDeleteAccountDialog(theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    ThemeData theme,
    bool isDark, {
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(title, style: theme.textTheme.titleLarge),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.dividerColor),
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
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? textColor,
    required VoidCallback onTap,
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
                child: Icon(icon, color: itemColor, size: 22),
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
                    const SizedBox(height: 2),
                    Text(subtitle, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
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

  void _showDeleteAccountDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade600),
            const SizedBox(width: 12),
            const Text('Delete Account?'),
          ],
        ),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion cancelled'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}