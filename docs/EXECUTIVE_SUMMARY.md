Executive Summary — blood_donation_app

Project Overview
- Name: blood_donation_app
- Purpose: Mobile application (Flutter) to facilitate blood donation workflows among donors, hospitals, and admins. Provides role selection, authentication, map-based discovery of donors/centers, push notifications, and sharing features.

Key Highlights
- Architecture: Layered Flutter app with a clear separation between presentation (feature UI under `lib/presentation`) and shared utilities/resources under `lib/core`.
- State management: Cubit/Bloc-style (presence of `lib/core/cubits/map_cubit.dart` and related cubit files), which keeps state logic outside of widgets.
- Integrations: Firebase (core + messaging), Google Maps, Geolocator, flutter_local_notifications, share_plus, url_launcher.
- Localization: Arabic and English support under `lib/l10n` (ARB files and generated localizations).

Strengths
- Organized folder structure by concern (core vs presentation) and by feature/role in presentation.
- Reusable UI components available in `lib/core/widgets` (CustomText, CustomTextField, custom dialogs, and loading/error state widgets).
- Localization prepared and wired (app_en.arb, app_ar.arb, localization delegates).

Primary Risks & Gaps
- Test coverage: No unit/widget tests were found in the repository; add tests for cubits, validators, and crucial screens.
- Service layer: No explicit data/service layer for API or Firebase access — move integration logic into `lib/data` or `lib/services` for better testability.
- Secrets: Firebase config files exist (e.g., `firebase.json`) — verify no secret keys are committed and redact if necessary.

Top Recommendations (priority)
1. Add automated tests (cubit + validators + widget tests for auth & maps).
2. Introduce a service/data layer and dependency injection for cubits to make code testable and maintainable.
3. Add CI (GitHub Actions) to run `flutter analyze` and `flutter test` on PRs.
4. Audit repository for secrets and remove/redact sensitive values.

Representative file references
- lib/core/widgets/custom_text.dart
- lib/core/cubits/map_cubit.dart
- lib/core/resources/routes/route_manger.dart
- lib/presentation/maps/map_view.dart
- lib/presentation/authentication/donor_authentication/donor_login.dart
- lib/l10n/app_en.arb

Next steps
- I can generate a README with setup steps, add a basic CI workflow, or scaffold a `lib/services` layer and a unit test for a cubit — tell me which you'd like me to do next.
