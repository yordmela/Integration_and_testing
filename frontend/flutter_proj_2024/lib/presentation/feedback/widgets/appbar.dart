import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Oasis Hotel',
        style: TextStyle(color: Color.fromARGB(255, 95, 65, 65),fontWeight: FontWeight.bold,),
      ),
       backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.go('/login_page');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
