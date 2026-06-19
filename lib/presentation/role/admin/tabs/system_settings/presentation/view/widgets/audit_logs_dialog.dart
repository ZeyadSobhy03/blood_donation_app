import 'package:flutter/material.dart';

import 'log_item.dart';

class AuditLogsDialog extends StatelessWidget {
  const AuditLogsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text('Audit Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Text('View system activity and user actions.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LogItem('User Login', 'admin@lifelink.com', '2024-04-07 10:23:45'),
                    LogItem('Database Backup', 'System', '2024-04-07 09:00:00'),
                    LogItem('Hospital Added', 'admin@lifelink.com', '2024-04-07 08:15:22'),
                    LogItem('Emergency Alert Sent', 'System', '2024-04-07 07:45:12'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Export Logs'))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA855F7)),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}