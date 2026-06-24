import 'package:blood_donation_app/l10n/app_localizations.dart';

String localizeAiPrediction(String raw, AppLocalizations loc) {

  final demandIncrease = RegExp(
    r'Blood demand expected to increase ([\d.]+)% next month',
  ).firstMatch(raw);
  if (demandIncrease != null) {
    return loc.aiPredictionDemandIncrease(demandIncrease.group(1)!);
  }

  final demandSteady = RegExp(
    r'Blood demand showing a steady ([\d.]+)% weekly increase',
  ).firstMatch(raw);
  if (demandSteady != null) {
    return loc.aiPredictionDemandSteady(demandSteady.group(1)!);
  }

  final demandDecline = RegExp(
    r'Blood demand has declined ([\d.]+)% in the past week',
  ).firstMatch(raw);
  if (demandDecline != null) {
    return loc.aiPredictionDemandDecline(demandDecline.group(1)!);
  }


  final shortageCritical = RegExp(
    r'^(.+?) critically low — only (\d+) donors available against (\d+) units needed',
  ).firstMatch(raw);
  if (shortageCritical != null) {
    return loc.aiPredictionShortageCritical(
      shortageCritical.group(1)!.trim(),
      shortageCritical.group(2)!,
      shortageCritical.group(3)!,
    );
  }


  final shortageRisk = RegExp(
    r'^(.+?) supply at risk with a ([\d.]+):1 demand-to-supply ratio',
  ).firstMatch(raw);
  if (shortageRisk != null) {
    return loc.aiPredictionShortageRisk(
      shortageRisk.group(1)!.trim(),
      shortageRisk.group(2)!,
    );
  }

  final retentionDrop = RegExp(
    r'Donor return rate has dropped to ([\d.]+)%',
  ).firstMatch(raw);
  if (retentionDrop != null) {
    return loc.aiPredictionRetentionDrop(retentionDrop.group(1)!);
  }

  final retentionImprove = RegExp(
    r'Donor retention has improved to ([\d.]+)%',
  ).firstMatch(raw);
  if (retentionImprove != null) {
    return loc.aiPredictionRetentionImprove(retentionImprove.group(1)!);
  }

  final peakDay = RegExp(
    r'^(\w+) shows ([\d.]+)% higher donation activity',
  ).firstMatch(raw);
  if (peakDay != null) {
    return loc.aiPredictionPeakDay(
      peakDay.group(1)!,
      peakDay.group(2)!,
    );
  }


  final weekend = RegExp(
    r'Weekend donation drives show ([\d.]+)% higher success rates',
  ).firstMatch(raw);
  if (weekend != null) {
    return loc.aiPredictionWeekend(weekend.group(1)!);
  }

  return raw;
}

List<String> localizeAiPredictions(List<String> raw, AppLocalizations loc) {
  return raw.map((p) => localizeAiPrediction(p, loc)).toList();
}