import 'package:flutter/material.dart';
import '../services/totp_service.dart';

class AccountTile extends StatelessWidget {
  final String name;
  final String secret;
  final VoidCallback onDelete;

  const AccountTile({
    super.key,
    required this.name,
    required this.secret,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
        subtitle: Text(
          TotpService.generateCode(secret),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 4,
            fontFamily: 'monospace',
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}