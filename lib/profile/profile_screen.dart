import 'package:flutter/material.dart';
import 'package:plano_a_dois/profile/widgets/profile_header.dart';
import 'package:plano_a_dois/profile/widgets/settings_list_item.dart';
import 'package:plano_a_dois/profile/manage_alerts_screen.dart';
import 'package:plano_a_dois/profile/manage_categories_screen.dart';
import 'package:plano_a_dois/profile/manage_recurrences_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil e Configurações'),
        backgroundColor: const Color(0xfff1f5f9), // slate-100
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            SettingsListItem(
              icon: Icons.notifications,
              title: 'Gerenciar Alertas',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageAlertsScreen()));
              },
            ),
            SettingsListItem(
              icon: Icons.category,
              title: 'Gerenciar Categorias',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageCategoriesScreen()));
              },
            ),
            SettingsListItem(
              icon: Icons.sync,
              title: 'Gerenciar Recorrências',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageRecurrencesScreen()));
              },
            ),
            const Divider(indent: 24, endIndent: 24, height: 32),
            SettingsListItem(
              icon: Icons.sync,
              title: 'Sincronização Manual',
              onTap: () {
                // Lógica de sincronização manual
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sincronizando dados...')),
                );
              },
            ),
            SettingsListItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Lógica de logout
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xfff1f5f9), // slate-100
    );
  }
}