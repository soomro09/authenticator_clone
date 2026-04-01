import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  const AddAccountDialog({super.key});

  @override
  State<AddAccountDialog> createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  final nameController = TextEditingController();
  final secretController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Account ➕"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: "Account Name"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: secretController,
            decoration: const InputDecoration(labelText: "Secret Key (Base32)"),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty && secretController.text.isNotEmpty) {
              Navigator.pop(context, {
                'name': nameController.text,
                'secret': secretController.text,
              });
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}