import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_settings.dart';
import '../core/app_strings.dart';
import 'login_screen.dart';

class ProfileScreenTab extends StatelessWidget {
  const ProfileScreenTab({super.key});

  void _showLanguageBottomSheet(BuildContext context, AppSettings settings, AppStrings strings) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    strings.english,
                    style: TextStyle(
                      color: !settings.isArabic ? AppColors.primary : (isDark ? AppColors.darkText : AppColors.lightText),
                      fontWeight: !settings.isArabic ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  trailing: !settings.isArabic
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    settings.setLanguage('en');
                    Navigator.pop(ctx);
                  },
                ),
                ListTile(
                  title: Text(
                    strings.arabic,
                    style: TextStyle(
                      color: settings.isArabic ? AppColors.primary : (isDark ? AppColors.darkText : AppColors.lightText),
                      fontWeight: settings.isArabic ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  trailing: settings.isArabic
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    settings.setLanguage('ar');
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);
    final settings = SettingsScope.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Column(
        children: [
          // Header Area with curved bottom
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(48),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: Row(
                  children: [
                    // Profile Avatar (ROUTE logo circle)
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF101127) : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'ROUTE',
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // User name and email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.userNamePlaceholder,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            strings.userEmailPlaceholder,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Menu Options
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // Dark Mode Item with Switch
                    _buildMenuItem(
                      context: context,
                      title: strings.darkMode,
                      trailing: Switch(
                        value: isDark,
                        activeThumbColor: Colors.white,
                        activeTrackColor: AppColors.primary,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColors.grey.withValues(alpha: 0.5),
                        onChanged: (val) {
                          settings.setDark(val);
                        },
                      ),

                    ),

                    const SizedBox(height: 16),

                    // Language Item with Chevron
                    _buildMenuItem(
                      context: context,
                      title: strings.language,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            settings.isArabic ? strings.arabic : strings.english,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      onTap: () => _showLanguageBottomSheet(context, settings, strings),
                    ),

                    const SizedBox(height: 16),

                    // Logout Item with red/accent icon
                    _buildMenuItem(
                      context: context,
                      title: strings.logout,
                      trailing: const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                        size: 22,
                      ),
                      onTap: () => _handleLogout(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101127) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.primary : AppColors.grey.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
