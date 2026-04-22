import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/request_provider.dart';
import 'screens/user_view.dart';
import 'screens/caretaker_view.dart';
import 'screens/admin_view.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize Hive and Provider data — capture provider before async gap
    final provider = Provider.of<RequestProvider>(context, listen: false);
    Future.microtask(() => provider.init());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestProvider>();

    if (!provider.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          _buildNavigationRail(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                UserView(),
                CaretakerView(),
                AdminView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.selected,
      leading: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Icon(Icons.assist_walker, color: Colors.blue, size: 32),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.person),
          selectedIcon: Icon(Icons.person, color: Colors.blue),
          label: Text('Patient'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.medical_services),
          selectedIcon: Icon(Icons.medical_services, color: Colors.blue),
          label: Text('Caretaker'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.admin_panel_settings),
          selectedIcon: Icon(Icons.admin_panel_settings, color: Colors.blue),
          label: Text('Admin'),
        ),
      ],
    );
  }
}
