import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import the go_router package

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(),
            accountName: const Text('Full Name', style: TextStyle(color: Colors.black)),
            accountEmail: const Text('user@example.com', style: TextStyle(color: Colors.black)),
            currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            onTap: () {
              context.go('/home_page'); // Use context.go for navigation
            },
            leading: const Icon(Icons.home),
            title: const Text('HOME'),
          ),
          ListTile(
            onTap: () {
              context.go('/booking_page'); // Use context.go for navigation
            },
            leading: const Icon(Icons.book_online),
            title: const Text('BOOK'),
          ),
          ListTile(
            onTap: () {
              context.go('/status_page'); 
            },
            leading: const Icon(Icons.label),
            title: const Text('Status'),
          ),
          
          ListTile(
            onTap: () {
              context.go('/settings_page'); 
            },
            leading: const Icon(Icons.settings),
            title: const Text('SETTINGS'),
          ),

          ListTile(
            onTap: () {
              context.go('/feedback_page'); 
            },
            leading: const Icon(Icons.feedback),
            title: const Text('FEEDBACK'),
          ),
          
          ListTile(
            onTap: () {
              context.go('/login_page');
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
