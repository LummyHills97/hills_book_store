import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  // ── Configure these to match your actual details 
  static const String _supportEmail = 'support@hillsbooks.com';
  static const String _whatsappNumber = '+2348000000000'; // replace with your number
  static const String _whatsappMessage = 'Hi! I need help with Hills Book Store.';


  Future<void> _openEmail(BuildContext context) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {
        'subject': 'Support Request - Hills Book Store',
      },
    );
    try {
      await launchUrl(uri);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open email app. Write to $_supportEmail'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    final String encoded = Uri.encodeComponent(_whatsappMessage);
    final String number = _whatsappNumber.replaceAll('+', '');
    final Uri uri = Uri.parse('https://wa.me/$number?text=$encoded');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open WhatsApp. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    }
  }

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
              gradient: const LinearGradient(
                colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
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
                    color: Colors.white.withValues(alpha: 0.2),
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
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickAction(
                        icon: Icons.message,
                        label: 'Live Chat',
                        onTap: () => _openWhatsApp(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickAction(
                        icon: Icons.email_outlined,
                        label: 'Email Us',
                        onTap: () => _openEmail(context),
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
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.04),
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
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.04),
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.headset_mic,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text('Still need help?', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'Our support team is ready to assist you',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.message, size: 20),
                        label: const Text('WhatsApp'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: theme.colorScheme.primary),
                        ),
                        onPressed: () => _openWhatsApp(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.email_outlined, size: 20),
                        label: const Text('Email'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => _openEmail(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Support email hint
          Center(
            child: Text(
              _supportEmail,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),
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
      color: Colors.white.withValues(alpha: 0.2),
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
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.05),
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
        collapsedIconColor: theme.iconTheme.color?.withValues(alpha: 0.6),
        children: [
          Text(
            answer,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}