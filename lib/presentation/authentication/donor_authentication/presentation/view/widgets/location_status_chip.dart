import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/cubits/map_cubit.dart';
import '../../../../../../core/resources/colors/color_manger.dart';

class LocationStatusChip extends StatelessWidget {
  const LocationStatusChip({
    super.key,
    required this.state,
    this.onTap,
  });

  final MapState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final (IconData icon, Color color, String label) = switch (state) {
      MapInitial() => (
          Icons.location_disabled,
          Colors.grey,
          loc.waitingForLocation,
        ),
      MapLoading() => (
          Icons.location_searching,
          Colors.orange,
          loc.acquiringLocation,
        ),
      MapLoaded(:final governorate, :final city) => (
          Icons.location_on,
          ColorManger.successColor,
          '$city, $governorate',
        ),
      MapPermissionPermanentlyDenied() => (
          Icons.location_off,
          ColorManger.brightRed,
          loc.locationPermanentlyDenied,
        ),
      MapError(:final error) => (
          Icons.location_off,
          ColorManger.brightRed,
          error,
        ),
    };
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.open_in_new, size: 12, color: color),
            ],
          ],
        ),
      ),
    );
  }
}
