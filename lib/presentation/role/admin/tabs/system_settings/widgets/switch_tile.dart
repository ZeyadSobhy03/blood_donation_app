import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool val;
  const SwitchTile(this.title, this.subtitle, this.val,{super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: val,
      onChanged: (v) {},
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      activeThumbColor: Colors.black,
      contentPadding: EdgeInsets.zero,
    );
  }
}
