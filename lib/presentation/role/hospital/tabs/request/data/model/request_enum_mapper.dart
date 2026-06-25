import '../../../../../../../l10n/app_localizations.dart';

class RequestEnumMapper {
  RequestEnumMapper._();

  static const List<String> patientDetailsKeys = [
    'surgery',
    'cardiac_surgery',
    'accident',
    'burns',
    'cancer',
    'leukemia',
    'maternity',
    'chronic_illness',
    'hemophilia',
    'thalassemia',
    'dialysis',
    'gastrointestinal_bleeding',
    'organ_transplant',
    'pediatric',
    'emergency',
    'general',
  ];

  static List<String> patientDetailsDisplayOptions(AppLocalizations loc) => [
    loc.patientDetailsSurgery,
    loc.patientDetailsCardiacSurgery,
    loc.patientDetailsAccident,
    loc.patientDetailsBurns,
    loc.patientDetailsCancer,
    loc.patientDetailsLeukemia,
    loc.patientDetailsMaternity,
    loc.patientDetailsChronicIllness,
    loc.patientDetailsHemophilia,
    loc.patientDetailsThalassemia,
    loc.patientDetailsDialysis,
    loc.patientDetailsGastrointestinalBleeding,
    loc.patientDetailsOrganTransplant,
    loc.patientDetailsPediatric,
    loc.patientDetailsEmergency,
    loc.patientDetailsGeneral,
  ];

  static String patientDetailsKeyToDisplay(String? key, AppLocalizations loc) {
    switch (key) {
      case 'surgery':                     return loc.patientDetailsSurgery;
      case 'cardiac_surgery':             return loc.patientDetailsCardiacSurgery;
      case 'accident':                    return loc.patientDetailsAccident;
      case 'burns':                       return loc.patientDetailsBurns;
      case 'cancer':                      return loc.patientDetailsCancer;
      case 'leukemia':                    return loc.patientDetailsLeukemia;
      case 'maternity':                   return loc.patientDetailsMaternity;
      case 'chronic_illness':             return loc.patientDetailsChronicIllness;
      case 'hemophilia':                  return loc.patientDetailsHemophilia;
      case 'thalassemia':                 return loc.patientDetailsThalassemia;
      case 'dialysis':                    return loc.patientDetailsDialysis;
      case 'gastrointestinal_bleeding':   return loc.patientDetailsGastrointestinalBleeding;
      case 'organ_transplant':            return loc.patientDetailsOrganTransplant;
      case 'pediatric':                   return loc.patientDetailsPediatric;
      case 'emergency':                   return loc.patientDetailsEmergency;
      case 'general':                     return loc.patientDetailsGeneral;
      default:                            return loc.patientDetailsGeneral;
    }
  }

  static String patientDetailsDisplayToKey(String? display, AppLocalizations loc) {
    if (display == null) return 'general';
    if (display == loc.patientDetailsSurgery)                 return 'surgery';
    if (display == loc.patientDetailsCardiacSurgery)           return 'cardiac_surgery';
    if (display == loc.patientDetailsAccident)                 return 'accident';
    if (display == loc.patientDetailsBurns)                    return 'burns';
    if (display == loc.patientDetailsCancer)                   return 'cancer';
    if (display == loc.patientDetailsLeukemia)                 return 'leukemia';
    if (display == loc.patientDetailsMaternity)                return 'maternity';
    if (display == loc.patientDetailsChronicIllness)           return 'chronic_illness';
    if (display == loc.patientDetailsHemophilia)               return 'hemophilia';
    if (display == loc.patientDetailsThalassemia)              return 'thalassemia';
    if (display == loc.patientDetailsDialysis)                 return 'dialysis';
    if (display == loc.patientDetailsGastrointestinalBleeding) return 'gastrointestinal_bleeding';
    if (display == loc.patientDetailsOrganTransplant)          return 'organ_transplant';
    if (display == loc.patientDetailsPediatric)                return 'pediatric';
    if (display == loc.patientDetailsEmergency)                return 'emergency';
    if (display == loc.patientDetailsGeneral)                  return 'general';
    return 'general';
  }

  static const List<String> patientTypeKeys = ['adult', 'child', 'infant'];

  static List<String> patientTypeDisplayOptions(AppLocalizations loc) => [
    loc.patientTypeAdult,
    loc.patientTypeChild,
    loc.patientTypeInfant,
  ];

  static String patientTypeKeyToDisplay(String? key, AppLocalizations loc) {
    switch (key) {
      case 'adult':  return loc.patientTypeAdult;
      case 'child':  return loc.patientTypeChild;
      case 'infant': return loc.patientTypeInfant;
      default:       return loc.patientTypeAdult;
    }
  }

  static String patientTypeDisplayToKey(String? display, AppLocalizations loc) {
    if (display == loc.patientTypeAdult)  return 'adult';
    if (display == loc.patientTypeChild)  return 'child';
    if (display == loc.patientTypeInfant) return 'infant';
    return 'adult';
  }

  static const List<String> urgencyKeys = ['low', 'medium', 'high', 'critical'];

  static String urgencyKeyToDisplay(String? key, AppLocalizations loc) {
    switch (key) {
      case 'low':      return loc.urgency_low;
      case 'medium':   return loc.urgency_medium;
      case 'high':     return loc.urgency_high;
      case 'critical': return loc.critical;
      default:         return loc.urgency_low;
    }
  }

  static const List<String> statusKeys = [
    'pending',
    'accepted',
    'in-progress',
    'completed',
    'cancelled',
    'expired',
  ];

  static const List<String> editableStatusKeys = [
    'accepted',
    'in-progress',
    'completed',
    'cancelled',
  ];

  static String statusKeyToDisplay(String? key, AppLocalizations loc) {
    switch (key) {
      case 'pending':     return loc.pending;
      case 'accepted':    return loc.statusAccepted;
      case 'in-progress': return loc.statusInProgress;
      case 'completed':   return loc.completed;
      case 'cancelled':   return loc.cancelled;
      case 'expired':     return loc.statusExpired;
      default:            return loc.pending;
    }
  }

  static List<String> editableStatusDisplayOptions(AppLocalizations loc) => [
    loc.statusAccepted,
    loc.statusInProgress,
    loc.completed,
    loc.cancelled,
  ];

  static String editableStatusDisplayToKey(String? display, AppLocalizations loc) {
    if (display == loc.statusAccepted)   return 'accepted';
    if (display == loc.statusInProgress) return 'in-progress';
    if (display == loc.completed)        return 'completed';
    if (display == loc.cancelled)        return 'cancelled';
    return 'accepted';
  }
}
