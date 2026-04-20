import 'package:flutter/material.dart';

class PermissionGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const PermissionGroup(this.title, this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((item) => SwitchListTile(
          value: true,
          onChanged: (v){},
          title: Text(item, style: const TextStyle(fontSize: 14)),
          dense: true,
          activeThumbColor: Colors.black,
        )),
        const Divider(),
      ],
    );
  }
}
