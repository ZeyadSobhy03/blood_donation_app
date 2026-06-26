import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

class LocalizedReward {
  final String title;
  final String description;
  final String status;
  final String category;

  LocalizedReward({
    required this.title,
    required this.description,
    required this.status,
    required this.category,
  });
}

LocalizedReward localizeReward(
    BuildContext context, {
      required String rawTitle,
      String? rawDescription,
      String? rawStatus,
      String? rawCategory,
    }) {
  final loc = AppLocalizations.of(context);

  // Fallback to raw data if localization is unavailable
  if (loc == null) {
    return LocalizedReward(
      title: rawTitle,
      description: rawDescription ?? '',
      status: rawStatus ?? '',
      category: rawCategory ?? '',
    );
  }

  return LocalizedReward(
    title: _localizeTitle(rawTitle, loc),
    description: _localizeDescription(rawDescription ?? rawTitle, loc),
    status: _localizeStatus(rawStatus ?? '', loc),
    category: _localizeCategory(rawCategory ?? '', loc),
  );
}

String _localizeTitle(String rawTitle, AppLocalizations loc) {
  final title = rawTitle.toLowerCase();

  if (title.contains('coffee voucher')) return loc.rewardCoffeeVoucher;
  if (title.contains('gym membership')) return loc.rewardGymMembership;
  if (title.contains('premium badge')) return loc.rewardPremiumBadge;
  if (title.contains('health check-up') || title.contains('health check')) return loc.rewardHealthCheckup;
  if (title.contains('restaurant gift card')) return loc.rewardRestaurantGiftCard;
  if (title.contains('movie tickets')) return loc.rewardMovieTickets;

  return rawTitle;
}

String _localizeDescription(String rawDesc, AppLocalizations loc) {
  final desc = rawDesc.toLowerCase();

  if (desc.contains('free coffee at partner cafes') || desc.contains('coffee voucher')) {
    return loc.rewardCoffeeVoucherDesc;
  }

  return rawDesc;
}

String _localizeStatus(String rawStatus, AppLocalizations loc) {
  final status = rawStatus.toLowerCase().trim();

  if (status == 'active') return loc.rewardStatusActive;
  if (status == 'inactive') return loc.rewardStatusInactive;

  return rawStatus;
}

String _localizeCategory(String rawCategory, AppLocalizations loc) {
  final category = rawCategory.toLowerCase().trim();

  if (category == 'health') return loc.rewardCategoryHealth;
  if (category == 'status') return loc.rewardCategoryStatus;
  if (category == 'food') return loc.rewardCategoryFood;
  if (category == 'entertainment') return loc.rewardCategoryEntertainment;

  return rawCategory;
}