import 'package:blood_donation_app/l10n/app_localizations.dart';

class AuditLogsLocalizer {

  static String localizeAction(String rawAction, AppLocalizations loc) {
    final action = rawAction.toLowerCase().trim();

    // Map Backend Keys OR Raw English Sentences to Localized Labels
    final Map<String, String> actionMap = {
      // Users & Admins
      'user.ban': loc.actionUserBanned,
      'user banned': loc.actionUserBanned,
      'user.unban': loc.actionUserUnbanned,
      'user unbanned': loc.actionUserUnbanned,
      'user.delete': loc.actionUserDeleted,
      'user deleted': loc.actionUserDeleted,

      // Creation
      'user.create_hospital': loc.actionHospitalCreated,
      'hospital.create': loc.actionHospitalCreated,
      'hospital added': loc.actionHospitalCreated,
      'hospital created': loc.actionHospitalCreated,
      'user.create_admin': loc.actionAdminAdded,
      'create_admin': loc.actionAdminAdded,
      'admin added': loc.actionAdminAdded,

      // Updates (From your screenshot)
      'user.update_donor': loc.actionDonorUpdated,
      'donor updated': loc.actionDonorUpdated,
      'user.update_hospital': loc.actionHospitalUpdated,
      'hospital updated': loc.actionHospitalUpdated,
      'user.update_admin': loc.actionAdminUpdated,
      'admin updated': loc.actionAdminUpdated,

      // Deletions & Keys (From your screenshot)
      'user.delete_admin': loc.actionAdminDeleted,
      'admin deleted': loc.actionAdminDeleted,
      'user.rotate_admin_key': loc.actionAdminKeyRotated,
      'admin key rotated': loc.actionAdminKeyRotated,

      // System
      'system.maintenance': loc.actionMaintenanceModeUpdated,
      'maintenance mode updated': loc.actionMaintenanceModeUpdated,

      // Admin Profile & Rewards
      'admin.update_profile': loc.actionProfileUpdated,
      'profile updated': loc.actionProfileUpdated,
      'admin.update_badge': loc.actionBadgeUpdated,
      'badge updated': loc.actionBadgeUpdated,
      'admin.update_rewards_config': loc.actionRewardsConfigUpdated,
      'rewards config updated': loc.actionRewardsConfigUpdated,

      // Permissions
      'permissions.create_role': loc.actionRoleCreated,
      'role created': loc.actionRoleCreated,
      'permissions.update_role': loc.actionRoleUpdated,
      'role updated': loc.actionRoleUpdated,
      'permissions.delete_role': loc.actionRoleDeleted,
      'role deleted': loc.actionRoleDeleted,

      // Requests
      'request.fulfill': loc.actionRequestFulfilled,
      'request fulfilled': loc.actionRequestFulfilled,
      'request.cancel': loc.actionRequestCancelled,
      'request cancelled': loc.actionRequestCancelled,
      'request.broadcast': loc.actionRequestBroadcasted,
      'request broadcasted': loc.actionRequestBroadcasted,
    };

    // 1. Direct Maps
    if (actionMap.containsKey(action)) {
      return actionMap[action]!;
    }

    // 2. Partial Contains Fallback
    for (var entry in actionMap.entries) {
      if (action.contains(entry.key)) return entry.value;
    }

    return rawAction;
  }

  static String localizeDetails(String rawDetails, AppLocalizations loc) {
    final details = rawDetails.trim();
    final lowerDetails = details.toLowerCase();

    // 1. Exact string matches (No dynamic IDs)
    if (lowerDetails.contains('request.fulfill') || lowerDetails == 'fulfilled request') return loc.actionRequestFulfilled;
    if (lowerDetails.contains('request.cancel') || lowerDetails == 'cancelled request') return loc.actionRequestCancelled;
    if (lowerDetails.contains('request.broadcast') || lowerDetails == 'broadcasted request') return loc.actionRequestBroadcasted;
    if (lowerDetails.contains('hospital.create') || lowerDetails == 'added hospital account') return loc.detailCreateHospital;
    if (lowerDetails.contains('system.maintenance') || lowerDetails == 'updated system maintenance mode') return loc.detailMaintenance;

    // 2. Regex for Dynamic IDs (Case-Insensitive)
    final patterns = {
      // From your screenshots
      RegExp(r'updated admin account \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailAdminUpdated(id),
      RegExp(r'rotated admin key \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailAdminKeyRotated(id),
      RegExp(r'updated hospital account \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailHospitalUpdated(id), // New!

      // Requests
      RegExp(r'fulfilled request \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailRequestAction(loc.actionRequestFulfilled, id),
      RegExp(r'cancelled request \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailRequestAction(loc.actionRequestCancelled, id),
      RegExp(r'broadcasted request \(id: (.+)\)', caseSensitive: false): (String id) => loc.detailRequestAction(loc.actionRequestBroadcasted, id),

      // Users / Admins
      RegExp(r'banned user account \(id: (.+)\)', caseSensitive: false): loc.detailBan,
      RegExp(r'unbanned user account \(id: (.+)\)', caseSensitive: false): loc.detailUnban,
      RegExp(r'suspended user account \(id: (.+)\)', caseSensitive: false): loc.detailSuspend,
      RegExp(r'unsuspended user account \(id: (.+)\)', caseSensitive: false): loc.detailUnsuspend,
      RegExp(r'soft-deleted user account \(id: (.+)\)', caseSensitive: false): loc.detailDelete,
      RegExp(r'created admin account \(id: (.+)\)', caseSensitive: false): loc.detailCreateAdmin,
    };

    for (var entry in patterns.entries) {
      final match = entry.key.firstMatch(details);
      if (match != null) return entry.value(match.group(1)!);
    }

    return rawDetails;
  }

  static String localizeTargetType(String rawType, AppLocalizations loc) {
    final type = rawType.toLowerCase().trim();
    final typeMap = {
      'user': loc.targetTypeUser,
      'request': loc.targetTypeRequest,
      'donation': loc.targetTypeDonation,
      'system': loc.targetTypeSystem,
    };
    return typeMap[type] ?? rawType;
  }

  static String localizeAdminName(String rawName, AppLocalizations loc) {
    return rawName.toLowerCase().trim() == 'system' ? loc.targetTypeSystem : rawName;
  }
}