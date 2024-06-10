import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(),
                  accountName: Text(state.user.name, style: const TextStyle(color: Colors.black)),
                  accountEmail: Text(state.user.email, style: const TextStyle(color: Colors.black)),
                  currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('HOME'),
                ),
                if (state.user.role == 'admin') ...[
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/admin_page');
                    },
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Manage Rooms'),
                  ),
                ] else if (state.user.role == 'customer') ...[
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
                ],
                ListTile(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                    Navigator.pushNamedAndRemoveUntil(context, '/login_page', (Route<dynamic> route) => false);
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('LOGOUT'),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
