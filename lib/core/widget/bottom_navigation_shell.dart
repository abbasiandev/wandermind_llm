import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_color.dart';

class BottomNavigationShell extends StatefulWidget {
  final Widget child;

  const BottomNavigationShell({
    super.key,
    required this.child,
  });

  @override
  State<BottomNavigationShell> createState() => _BottomNavigationShellState();
}

class _BottomNavigationShellState extends State<BottomNavigationShell> {
  int _currentIndex = 0;

  final List<NavigationItem> _items = [
    NavigationItem(
      path: '/',
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavigationItem(
      path: '/chat',
      label: 'Chat',
      icon: Icons.chat_bubble_outline,
      selectedIcon: Icons.chat_bubble,
    ),
    NavigationItem(
      path: '/plans',
      label: 'Plans',
      icon: Icons.map_outlined,
      selectedIcon: Icons.map,
    ),
    NavigationItem(
      path: '/route',
      label: 'Route',
      icon: Icons.directions_outlined,
      selectedIcon: Icons.directions,
    ),
    NavigationItem(
      path: '/settings',
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final location = GoRouterState.of(context).uri.path;
    for (int i = 0; i < _items.length; i++) {
      if (location == _items[i].path ||
          (location.startsWith(_items[i].path) && _items[i].path != '/')) {
        setState(() {
          _currentIndex = i;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          if (index != _currentIndex) {
            context.go(_items[index].path);
          }
        },
        destinations: _items.map((item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  NavigationItem({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}