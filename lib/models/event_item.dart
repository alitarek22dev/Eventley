import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final String? description;
  final String? location;
  final String? time;

  const EventItem({
    required this.id,
    required this.title,
    required this.day,
    required this.month,
    required this.category,
    required this.lightImage,
    required this.darkImage,
    this.description,
    this.location,
    this.time,
  });

  String getLocalizedTitle(AppStrings strings) {
    if (id == '1') return strings.birthdayPartyTitle;
    if (id == '2') return strings.meetingTitle;
    if (id == '3') return strings.exhibitionTitle;
    if (id == '4') return strings.bookClubTitle;
    if (id == '5') return strings.sportEventTitle;
    return title;
  }

  String getImage(bool isDark) => isDark ? darkImage : lightImage;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'day': day,
      'month': month,
      'category': category.name,
      'lightImage': lightImage,
      'darkImage': darkImage,
      'description': description,
      'location': location,
      'time': time,
    };
  }

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'] as String,
      title: json['title'] as String,
      day: json['day'] as String,
      month: json['month'] as String,
      category: EventCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => EventCategory.sport,
      ),
      lightImage: json['lightImage'] as String,
      darkImage: json['darkImage'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      time: json['time'] as String?,
    );
  }
}

class EventProvider extends ChangeNotifier {
  static const String _eventsKey = 'custom_events';
  static const String _favoritesKey = 'favorite_events';

  final Set<String> _favoriteIds = {'1'};
  List<EventItem> _customEvents = [];

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String eventId) => _favoriteIds.contains(eventId);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final favsList = prefs.getStringList(_favoritesKey);
    if (favsList != null) {
      _favoriteIds.clear();
      _favoriteIds.addAll(favsList);
    }

    final eventsJson = prefs.getString(_eventsKey);
    if (eventsJson != null) {
      try {
        final decoded = jsonDecode(eventsJson) as List<dynamic>;
        _customEvents = decoded
            .map((e) => EventItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String eventId) async {
    if (_favoriteIds.contains(eventId)) {
      _favoriteIds.remove(eventId);
    } else {
      _favoriteIds.add(eventId);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favoriteIds.toList());
  }

  Future<void> addEvent(EventItem event) async {
    _customEvents.insert(0, event);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_customEvents.map((e) => e.toJson()).toList());
    await prefs.setString(_eventsKey, encoded);
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

  List<EventItem> get allEvents => [..._customEvents, ...sampleEvents];

  List<EventItem> get favoriteEvents =>
      allEvents.where((e) => _favoriteIds.contains(e.id)).toList();
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
