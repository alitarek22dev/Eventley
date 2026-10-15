import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../models/event_item.dart';
import '../widgets/event_card.dart';

class FavoritesScreenTab extends StatefulWidget {
  const FavoritesScreenTab({super.key});

  @override
  State<FavoritesScreenTab> createState() => _FavoritesScreenTabState();
}

class _FavoritesScreenTabState extends State<FavoritesScreenTab> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);
    final eventProvider = EventScope.of(context);

    final favorites = eventProvider.favoriteEvents;
    final filteredFavorites = _searchQuery.trim().isEmpty
        ? favorites
        : favorites.where((event) {
            final title = event.getLocalizedTitle(strings).toLowerCase();
            return title.contains(_searchQuery.toLowerCase());
          }).toList();

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.5,
      ),
    );

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Search TextField
                  TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    style: TextStyle(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDark ? Colors.transparent : Colors.white,
                      hintText: strings.searchFavoriteEvents,
                      hintStyle: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.primary),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Favorites List / Empty State
                  Expanded(
                    child: favorites.isEmpty
                        ? _buildEmptyState(isDark, strings)
                        : filteredFavorites.isEmpty
                            ? Center(
                                child: Text(
                                  strings.noEventsFound,
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.darkText
                                        : AppColors.lightText,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 16),
                                itemCount: filteredFavorites.length,
                                itemBuilder: (context, index) {
                                  final event = filteredFavorites[index];
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, AppStrings strings) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              strings.noFavoritesYet,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              strings.noFavoritesSub,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
