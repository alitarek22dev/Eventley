import 'package:flutter/material.dart';

import '../core/app_assets.dart';
import '../core/app_strings.dart';

enum EventCategory {
  sport,
  bookClub,
  birthday,
  meeting,
  exhibition,
}

class EventItem {
  final String id;
  final String title;
  final String day;
  final String month;
  final EventCategory category;
  final String lightImage;
  final String darkImage;

  const EventItem({
    required this.id,
    required this.title,
    required this.day,
    required this.month,
    required this.category,
    required this.lightImage,
    required this.darkImage,
  });

  String getLocalizedTitle(AppStrings strings) {
    switch (category) {
      case EventCategory.birthday:
        return strings.birthdayPartyTitle;
      case EventCategory.meeting:
        return strings.meetingTitle;
      case EventCategory.exhibition:
        return strings.exhibitionTitle;
      case EventCategory.bookClub:
        return strings.bookClubTitle;
      case EventCategory.sport:
        return strings.sportEventTitle;
    }
  }

  String getImage(bool isDark) => isDark ? darkImage : lightImage;
}

class EventProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {'1'}; // Default first event favorited

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String eventId) => _favoriteIds.contains(eventId);

  void toggleFavorite(String eventId) {
    if (_favoriteIds.contains(eventId)) {
      _favoriteIds.remove(eventId);
    } else {
      _favoriteIds.add(eventId);
    }
    notifyListeners();
  }

  static final List<EventItem> sampleEvents = [
    const EventItem(
      id: '1',
      title: 'This is a Birthday Party',
      day: '21',
      month: 'Nov',
      category: EventCategory.birthday,
      lightImage: AppAssets.birthdayLight,
      darkImage: AppAssets.birthdayDark,
    ),
    const EventItem(
      id: '2',
      title: 'Meeting for updating the development method',
      day: '22',
      month: 'Nov',
      category: EventCategory.meeting,
      lightImage: AppAssets.meetingLight,
      darkImage: AppAssets.meetingDark,
    ),
    const EventItem(
      id: '3',
      title: 'Exhibition unique art for everyone',
      day: '27',
      month: 'Nov',
      category: EventCategory.exhibition,
      lightImage: AppAssets.exhibitionLight,
      darkImage: AppAssets.exhibitionDark,
    ),
    const EventItem(
      id: '4',
      title: 'Book club meeting for reading enthusiasts',
      day: '28',
      month: 'Nov',
      category: EventCategory.bookClub,
      lightImage: AppAssets.bookClubLight,
      darkImage: AppAssets.bookClubDark,
    ),
    const EventItem(
      id: '5',
      title: 'Sports day and football tournament',
      day: '30',
      month: 'Nov',
      category: EventCategory.sport,
      lightImage: AppAssets.sportLight,
      darkImage: AppAssets.sportDark,
    ),
  ];

  List<EventItem> get allEvents => sampleEvents;

  List<EventItem> get favoriteEvents =>
      sampleEvents.where((e) => _favoriteIds.contains(e.id)).toList();
}

class EventScope extends InheritedNotifier<EventProvider> {
  const EventScope({
    super.key,
    required EventProvider provider,
    required super.child,
  }) : super(notifier: provider);

  static EventProvider of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<EventScope>();
    assert(scope != null, 'EventScope not found in context');
    return scope!.notifier!;
  }
}
