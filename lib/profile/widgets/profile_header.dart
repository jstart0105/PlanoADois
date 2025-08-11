import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildProfileAvatar('Você', 'https://picsum.photos/seed/user1/200'),
          const Icon(Icons.favorite, color: Color(0xffef4444), size: 32), // red-500
          _buildProfileAvatar('Parceiro(a)', 'https://picsum.photos/seed/user2/200'),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(String name, String imageUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: const Color(0xffe2e8f0), // slate-200
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff1e293b), // slate-800
          ),
        ),
      ],
    );
  }
}