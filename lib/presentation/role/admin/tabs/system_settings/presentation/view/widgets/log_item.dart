import 'package:flutter/material.dart';

class LogItem extends StatelessWidget {
  final String action;
  final String user;
  final String time;
  const LogItem(this.action, this.user, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(action, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('User: $user', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.green.shade500, borderRadius: BorderRadius.circular(6)),
            child: const Text('Success', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
