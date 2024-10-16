import 'package:flutter/material.dart';
import 'package:project_zeta/components/my_list_tile.dart';
import 'package:project_zeta/pages/settings_page.dart';
import 'package:project_zeta/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 50),
              ),
              //home list tile
              MyListTile(
                icon: Icons.home,
                text: "H O M E",
                onTap: () => Navigator.pop(context),
              ),
              //settings list tile
              MyListTile(
                icon: Icons.settings,
                text: "S E T T I N G S",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          //logout
          MyListTile(
            icon: Icons.logout,
            text: "L O G O U T",
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
