import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/widgets/switch_tile.dart';
import 'package:flutter/material.dart';

class PermissionGroup extends StatefulWidget {
  final String title;
  final List<String> items;

  const PermissionGroup(this.title, this.items, {super.key});

  @override
  State<PermissionGroup> createState() => _PermissionGroupState();
}

class _PermissionGroupState extends State<PermissionGroup> {
  late Map<String, bool> permissionStates;

  @override
  void initState() {
    super.initState();
    permissionStates = {
      for (var item in widget.items) item: false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.grey100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ...widget.items.map((item) => CustomSwitchTile(
              title: item,
              subtitle: '',
              val: permissionStates[item] ?? false,
              onChanged: (value) {
                setState(() {
                  permissionStates[item] = value;
                });
              },
            )),
          ],
        ),
      ),
    );
  }
}
