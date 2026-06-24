import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/configuration_note_card.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/admin_rewards/presentation/view/section/points_configuration_card.dart';
import 'package:flutter/material.dart';

class ConfigurationTab extends StatelessWidget {
  const ConfigurationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PointsConfigurationCard(),
          SizedBox(height: 12,),
          ConfigurationNoteCard()


        ],
      ),
    );
  }
}
