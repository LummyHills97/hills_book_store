import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: theme.appBarTheme.titleTextStyle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Quick Actions
          Container(
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
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'How can we help you?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Find answers to common questions',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickAction(
                        icon: Icons.chat_bubble_outline,
                        label: 'Live Chat',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Live chat coming soon!'),
                              backgroundColor: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickAction(
                        icon: Icons.email_outlined,
                        label: 'Email Us',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('support@hillsbooks.com'),
                              backgroundColor: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // FAQs
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Frequently Asked Questions',
              style: theme.textTheme.titleLarge,
            ),
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
                _buildFAQTile(
                  theme,
                  question: 'How do I download books for offline reading?',
                  answer:
                      'Tap the download icon on any book detail page. Downloaded books will be available in your Library under the Downloads section.',
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildFAQTile(
                  theme,
                  question: 'How do I change my payment method?',
                  answer:
                      'Go to Settings > Privacy & Security > Payment Methods to add or update your payment information.',
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildFAQTile(
                  theme,
                  question: 'Can I share my books with friends?',
                  answer:
                      'Yes! Use the share button on any book to send recommendations via email, social media, or messaging apps.',
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildFAQTile(
                  theme,
                  question: 'How do I cancel my subscription?',
                  answer:
                      'Go to Settings > Privacy & Security > Subscriptions and select the subscription you want to cancel.',
                ),
                Divider(color: theme.dividerColor, height: 1),
                _buildFAQTile(
                  theme,
                  question: 'Why can\'t I access some books?',
                  answer:
                      'Some books may be region-restricted or require a premium subscription. Check the book details for availability.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Contact Support
          Container(
            padding: const EdgeInsets.all(24),
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
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.headset_mic,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Still need help?',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Contact our support team',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.support_agent),
                    label: const Text(
                      'Contact Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Opening support chat...'),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
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

  Widget _buildFAQTile(
    ThemeData theme, {
    required String question,
    required String answer,
  }) {
    return Theme(
      data: theme.copyWith(
        dividerColor: Colors.transparent,
        splashColor: theme.colorScheme.primary.withOpacity(0.05),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        title: Text(
          question,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        iconColor: theme.colorScheme.primary,
        collapsedIconColor: theme.iconTheme.color?.withOpacity(0.6),
        children: [
          Text(
            answer,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}