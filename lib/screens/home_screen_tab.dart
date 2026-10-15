import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_settings.dart';
import '../core/app_strings.dart';

import '../models/event_item.dart';
import '../widgets/event_card.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key});

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  EventCategory? _selectedCategory; // null means 'All'

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);
    final eventProvider = EventScope.of(context);

    final allEvents = eventProvider.allEvents;
    final filteredEvents = _selectedCategory == null
        ? allEvents
        : allEvents.where((e) => e.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Column(
        children: [
          // Header Area
          _buildHeader(context, isDark, strings),

          // Events List
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: filteredEvents.isEmpty
                    ? Center(
                        child: Text(
                          strings.noEventsFound,
                          style: TextStyle(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];
                          return EventCard(
                            event: event,
                            isFavorite: eventProvider.isFavorite(event.id),
                            onFavoriteToggle: () {
                              eventProvider.toggleFavorite(event.id);
                            },
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, AppStrings strings) {
    final headerBg = AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: headerBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row: Welcome Back + User Name & Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.welcomeBack,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        strings.userNamePlaceholder,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            strings.cairoEgypt,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final settings = SettingsScope.of(context);
                          settings.setDark(!settings.isDark);
                        },
                        icon: Icon(
                          isDark ? Icons.nightlight_round : Icons.wb_sunny_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final settings = SettingsScope.of(context);
                          settings.setLanguage(settings.isArabic ? 'en' : 'ar');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            strings.isArabic ? 'AR' : 'EN',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              const SizedBox(height: 16),

              // Category Pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryTab(
                      label: strings.all,
                      icon: Icons.explore_outlined,
                      isSelected: _selectedCategory == null,
                      onTap: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildCategoryTab(
                      label: strings.sport,
                      icon: Icons.sports_volleyball_outlined,
                      isSelected: _selectedCategory == EventCategory.sport,
                      onTap: () {
                        setState(() {
                          _selectedCategory = EventCategory.sport;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildCategoryTab(
                      label: strings.birthday,
                      icon: Icons.cake_outlined,
                      isSelected: _selectedCategory == EventCategory.birthday,
                      onTap: () {
                        setState(() {
                          _selectedCategory = EventCategory.birthday;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildCategoryTab(
                      label: strings.bookClub,
                      icon: Icons.menu_book_outlined,
                      isSelected: _selectedCategory == EventCategory.bookClub,
                      onTap: () {
                        setState(() {
                          _selectedCategory = EventCategory.bookClub;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildCategoryTab(
                      label: strings.meeting,
                      icon: Icons.business_outlined,
                      isSelected: _selectedCategory == EventCategory.meeting,
                      onTap: () {
                        setState(() {
                          _selectedCategory = EventCategory.meeting;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildCategoryTab(
                      label: strings.exhibition,
                      icon: Icons.palette_outlined,
                      isSelected: _selectedCategory == EventCategory.exhibition,
                      onTap: () {
                        setState(() {
                          _selectedCategory = EventCategory.exhibition;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTab({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.primary : Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
