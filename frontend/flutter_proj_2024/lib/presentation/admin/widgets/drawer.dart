import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(),
            accountName:
                const Text('Full Name', style: TextStyle(color: Colors.black)),
            accountEmail: const Text('user@example.com',
                style: TextStyle(color: Colors.black)),
            currentAccountPicture:
                const CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/home_page');
            },
            leading: const Icon(Icons.home),
            title: const Text('HOME'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/booking_page');
            },
            leading: const Icon(Icons.book_online),
            title: const Text('BOOK'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/status_page');
            },
            leading: const Icon(Icons.label),
            title: const Text('Status'),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/login_page');
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
