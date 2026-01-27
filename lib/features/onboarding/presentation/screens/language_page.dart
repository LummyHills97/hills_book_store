import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {'name': 'English', 'nativeName': 'English', 'code': 'en'},
    {'name': 'Spanish', 'nativeName': 'Español', 'code': 'es'},
    {'name': 'French', 'nativeName': 'Français', 'code': 'fr'},
    {'name': 'German', 'nativeName': 'Deutsch', 'code': 'de'},
    {'name': 'Portuguese', 'nativeName': 'Português', 'code': 'pt'},
    {'name': 'Italian', 'nativeName': 'Italiano', 'code': 'it'},
    {'name': 'Chinese', 'nativeName': '中文', 'code': 'zh'},
    {'name': 'Japanese', 'nativeName': '日本語', 'code': 'ja'},
    {'name': 'Korean', 'nativeName': '한국어', 'code': 'ko'},
    {'name': 'Arabic', 'nativeName': 'العربية', 'code': 'ar'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Language'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF5E5CE6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFF5E5CE6),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'App will restart to apply language changes',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: languages.map((lang) {
                final isSelected = selectedLanguage == lang['name'];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() => selectedLanguage = lang['name']!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language changed to ${lang['name']}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF5E5CE6).withValues(alpha: 0.1)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                lang['code']!.toUpperCase(),
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF5E5CE6)
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang['name']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  lang['nativeName']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF5E5CE6),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}