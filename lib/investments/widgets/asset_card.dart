import 'package:flutter/material.dart';

class AssetCard extends StatelessWidget {
  final String assetType;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const AssetCard({
    super.key,
    required this.assetType,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xff4f46e5), size: 32),
              const SizedBox(height: 16),
              Text(
                assetType,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0f172a),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff64748b),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}