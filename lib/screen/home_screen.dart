import 'dart:async';
import 'package:flutter/material.dart';
import '../services/totp_service.dart';
import '../widgets/account_tile.dart';
import '../widgets/add_ccount_dialog.dart';

class TotpAccount {
  String name;
  String secret;
  TotpAccount({required this.name, required this.secret});
}

class SwiftPassHome extends StatefulWidget {
  const SwiftPassHome({super.key});

  @override
  State<SwiftPassHome> createState() => _SwiftPassHomeState();
}

class _SwiftPassHomeState extends State<SwiftPassHome> {
  final List<TotpAccount> _accounts = [];
  double _progress = 1.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) setState(() => _progress = TotpService.getProgress());
    });
  }

  void _showAddAccountDialog() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddAccountDialog(),
    );

    if (result != null && mounted) {
      setState(() {
        _accounts.add(TotpAccount(name: result['name']!, secret: result['secret']!));
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SWIFTPASS ⚡", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 6),
          child: LinearProgressIndicator(value: _progress),
        ),
      ),
      body: _accounts.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        itemCount: _accounts.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return AccountTile(
            name: _accounts[index].name,
            secret: _accounts[index].secret,
            onDelete: () => setState(() => _accounts.removeAt(index)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAccountDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shield_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text("No accounts yet.", style: TextStyle(fontSize: 18)),
          const Text("Tap the + button to add one!"),
        ],
      ),
    );
  }
}