import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../models/event_item.dart';
import 'create_event_screen.dart';
import 'favorites_screen_tab.dart';
import 'home_screen_tab.dart';
import 'profile_screen_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final EventProvider _eventProvider = EventProvider();

  @override
  void initState() {
    super.initState();
    _eventProvider.load();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final strings = AppStrings.of(context);

    final navBarBg = isDark ? const Color(0xFF101127) : AppColors.primary;
    final unselectedIconColor = isDark ? Colors.white70 : Colors.white60;
    const selectedIconColor = Colors.white;

    return EventScope(
      provider: _eventProvider,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreenTab(),
            FavoritesScreenTab(),
            ProfileScreenTab(),
          ],
        ),
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EventScope(
                        provider: _eventProvider,
                        child: const CreateEventScreen(),
                      ),
                    ),
                  );
                },
                backgroundColor: AppColors.primary,
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 3),
                ),
                elevation: 4,
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              )
            : null,

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: navBarBg,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: navBarBg,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: navBarBg,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: selectedIconColor,
              unselectedItemColor: unselectedIconColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: const Icon(Icons.home),
                  label: strings.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_border),
                  activeIcon: const Icon(Icons.favorite),
                  label: strings.favorites,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  activeIcon: const Icon(Icons.person),
                  label: strings.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
