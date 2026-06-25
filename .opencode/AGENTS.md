# LifeLink Flutter — Project Rules for AI Agents

> **Purpose.** This document is the operating contract between human
> maintainers and any AI agent (or human contributor) writing code in
> this Flutter repository. It enforces the established Clean Architecture,
> Cubit state management, and manual data serialization patterns.
>
> **How to use this file.** Read it end-to-end once. Before every change,
> re-read the section that covers the area you're touching. The rules
> are ordered: orientation → planning → implementation → verification →
> delivery.

---

## 0. Phase 0 — Orientation (before writing any code)

You cannot safely edit a file you have not read. Before producing any
diff, do all of the following:

1. **Read the target file in full.** Not a skim. Read it.
2. **Read at least one neighbor in the same layer.** If editing a Cubit,
   read another Cubit. If editing a DataSource, read another DataSource.
   Match its style, error handling, and formatting exactly.
3. **Trace the dependency chain.** `View → Cubit → UseCase → Repository (abstract) → RepositoryImp → DataSource`. Read every file in this chain for the feature you are editing.
4. **Read `main.dart`.** This is where all manual Dependency Injection
   happens. Understand how the feature you are editing receives its
   dependencies.
5. **Read `RouteManger` and `ApiManger`.** Understand the navigation
   and HTTP setup before adding new routes or API calls.
6. **Read `pubspec.yaml`** to confirm available packages.

If any of these are missing or unclear, **stop and ask the maintainer**
before guessing. Hallucinated packages and broken architectural boundaries
are the single most common AI failure mode in this codebase.

---

## 1. Phase 1 — Planning (before any diff)

Write down, in the PR description or commit body:

1. **Intent.** What behavior changes, in one sentence.
2. **Touch list.** Every file you will edit, grouped by layer
   (View / Cubit / UseCase / Repository / DataSource / Model / Core).
3. **Cross-file impact.** Will `main.dart` need a new dependency wired?
   Will `RouteManger` need a new route? Will `ApiManger` need a new endpoint?
4. **State delta.** Will the Cubit's `sealed class` states change? If so,
   are all UI consumers updated for exhaustiveness?
5. **Definition of done.** A bullet list of concrete criteria.

---

## 2. Project Structure & Naming

### 2.1 Feature-First Clean Architecture
The project uses Clean Architecture organized feature-first.

| Path | Purpose | Hard Rules |
|------|---------|------------|
| `lib/presentation/role/<feature>/presentation/` | UI Widgets, Screens & Cubits | No HTTP calls. No direct Dio usage. No business logic. |
| `lib/presentation/role/<feature>/domain/` | UseCases | Domain logic only. No Dio, no UI. |
| `lib/presentation/role/<feature>/data/` | Abstract Repositories, Repository Imps, DataSources, Models | Abstract interfaces live here too. DataSources call Dio. |

**Layering is strictly one-directional:**
`View → Cubit → UseCase → Repository (abstract, in data/) → RepositoryImp (in data/) → DataSource`.

**Note on Auth Screens:** Some auth screens (e.g., `donor_login.dart`, `donor_register.dart`) sit directly inside `presentation/authentication/donor_authentication/` rather than in a `presentation/view/` subfolder. Be aware of this inconsistency when navigating.

### 2.2 Naming Conventions

- **Files:** `snake_case.dart` always.
- **Suffixes:** Use `_view_model.dart` for Cubits, `_use_case.dart` for
  UseCases, `_repositories_imp.dart` for Repository implementations,
  `_api_data_source.dart` for DataSources, `_model.dart` for data models.
- **The `_manger` Typo:** The codebase uses the spelling `_manger`
  (e.g., `ApiManger`, `RouteManger`, `ColorManger`) instead of
  `_manager`. **Do not "fix" this typo.** Preserve it for consistency
  with existing files.

---

## 3. State Management (Cubit Only)

### 3.1 No BLoC Events
This project uses **`Cubit` exclusively**. Do not introduce `Bloc`
classes or `Event` classes. State changes happen via cubit methods
calling `emit()`.

### 3.2 Sealed Classes & Colocation
States are defined as a `sealed class` hierarchy **in the exact same
file as the Cubit** (e.g., `auth_view_model.dart`). The Cubit class must
come first, followed by the sealed state classes.

```dart
// Correct: auth_view_model.dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(...) : super(AuthInitial());
  Future<void> login() async { emit(AuthLoading()); ... }
}

sealed class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState { final User user; ... }
```

### 3.3 Exhaustive Pattern Matching
When consuming state in the UI via `BlocBuilder` or `BlocConsumer`,
use exhaustive `switch` statements over the sealed class to handle every
state for rendering. However, `if (state is X)` is acceptable and common
inside `BlocConsumer` listener callbacks or for specific one-off checks.

---

## 4. API & Networking (Manual & Dio)

### 4.1 The Dio Singleton
There is **one shared `Dio` instance** created in `main.dart`. It is
passed down the dependency chain.
- **Never** instantiate `Dio()` inside a DataSource, Repository, or View.
- **Never** create a local `Dio()` instance.

### 4.2 Abstract DataSources
Every DataSource has an abstract interface (e.g., `AuthRemoteDataSource`)
that the concrete class implements. When adding a new DataSource, you must
create both the abstract interface AND the implementation class.

### 4.3 DataSources
DataSources are the *only* place Dio is called.
- They must catch `DioException` and pass it to `handleDioError(e)`.
- Do not put business logic or UseCase logic in a DataSource. It only
  makes the HTTP call, parses the JSON, and returns the Model or throws.

### 4.4 Manual Models (No Code Generation)
This project **does not use `freezed`, `json_serializable`, or `build_runner`**.
- Models are handwritten `class`es with manual constructors.
- `fromJson` and `toJson` are implemented by hand.
- Do not add `@freezed` or `@JsonSerializable` annotations.
- Do not run `build_runner`.

### 4.5 Environment Configuration
The base URL is hardcoded as a constant in `ApiManger`
(`api_constants.dart`). There is no `.env` or `--dart-define`.
- Do not introduce `flutter_dotenv` or `envied`.
- If you need a new endpoint path, add it to `ApiManger` as a static constant.

### 4.6 Auth Interceptor
The `AuthInterceptor` automatically attaches the `Bearer` token and
handles silent 401 refreshes. Do not manually add `Authorization` headers
in new DataSources.
*Note: Some legacy methods in `auth_api_data_source.dart` (`getMe()` and
`validateToken()`) manually add headers because they pre-date the
interceptor. Do not replicate this pattern in new code.*

---

## 5. Routing & Navigation

### 5.1 Navigator 1.0 Only
This project uses Flutter's built-in Navigator 1.0 with a custom
`RouteManger` class.
- **Never** introduce `go_router` or `auto_route`.
- All route paths are `static const String` fields in `RouteManger`.
- The `RouteManger.router(RouteSettings)` switch-case handles routing.

### 5.2 Arguments
Arguments are passed via `settings.arguments` and cast manually in
`RouteManger`. If you add a screen requiring arguments, create a simple
arguments class (e.g., `PinVerificationArgs`) and cast it safely.

### 5.3 Auth Guards
There is no declarative route guard. The `SplashScreen` calls
`AuthCubit.validateToken()` to determine the initial route. Do not
add route guards to `RouteManger`.

---

## 6. Dependency Injection (Manual)

### 6.1 No Service Locators
This project **does not use `get_it` or `injectable`**.
- All dependencies are wired manually in `main.dart` inside a
  `MultiBlocProvider` tree.
- If you create a new Cubit, you must wire its full dependency chain
  (DataSource → Repository → UseCase → Cubit) in `main.dart`.

### 6.2 Singletons
The shared `Dio` instance and `HiveDataSource` instances are created
once in `main()` and passed down. They are effectively singletons.
Do not wrap them in a singleton class; just pass the instance.

---

## 7. UI, Styling & Assets

### 7.1 Colors & Fonts
- **Never** hardcode colors (e.g., `Color(0xFF...)`) in widgets.
- Always use `ColorManger.*` for colors.
- Font sizes and weights are centralized in `core/resources/fonts/` via
  the `FontSize` and `FontWeightManager` classes. Use these constants directly.

### 7.2 Responsive Sizing
The project uses **`flutter_screenutil`**.
- Always use `.h`, `.w`, and `.r` for layout sizing (padding, margins, border radii).
- **Exception:** Do not use `.sp` for fonts. Font sizes use the centralized
  `FontSize.*` constants directly (e.g., `FontSize.s16`), which are plain `double` values.

### 7.3 Assets
- Asset paths are hardcoded strings matching `pubspec.yaml` (e.g.,
  `'assets/images/svg/logo.svg'`).
- **Never** introduce `flutter_gen` for type-safe assets. Use the string paths.

### 7.4 Localization
- The app is bilingual (Arabic + English) using `flutter_localizations`
  and `.arb` files (`app_en.arb`, `app_ar.arb`).
- Do not hardcode user-facing strings in widgets. Add them to the `.arb`
  files and access via `AppLocalizations.of(context)!.someKey`.
- Run `flutter gen-l10n` after updating `.arb` files.

---

## 8. Logging & Error Handling

### 8.1 Logging
- Use `dart:developer`'s `log()` function for debugging. Do not use
  `print()`.
- Do not introduce a new logging package (like `logger`).

### 8.2 Error Handling in UI
Errors should be surfaced as state in the Cubit (e.g., `AuthError(message)`).
The UI should pattern-match this state and display a SnackBar or error
text. Do not throw exceptions to the UI layer.

---

## 9. Testing

### 9.1 Current State
The project currently uses the built-in `flutter_test` package. There
are no mocking frameworks (`mocktail`/`mockito`) set up yet.

### 9.2 Rules for AI
- If asked to write a test, use standard `flutter_test` and `bloc_test`.
- Since there are no mocks set up, do not invent mock classes. If testing
  a Cubit requires a mocked repository, **stop and ask the maintainer**
  if you should add `mocktail` to `pubspec.yaml` first.

---

## 10. Forbidden Patterns (Blockers)

- ❌ Using `Bloc` and `Event` classes. Use `Cubit` only.
- ❌ Defining state classes outside the Cubit's `*_view_model.dart` file.
- ❌ Using `freezed`, `json_serializable`, or `build_runner`.
- ❌ Writing `@JsonSerializable` or `@freezed` annotations.
- ❌ Instantiating `Dio()` anywhere except `main.dart`.
- ❌ Calling `Dio` directly from a View, Cubit, or UseCase.
- ❌ Creating a concrete DataSource without an abstract interface class.
- ❌ Introducing `go_router`, `auto_route`, or Navigator 2.0 patterns.
- ❌ Using `get_it` or `injectable` for Dependency Injection.
- ❌ Hardcoding colors (`Color(0xFF...)`) in widgets. Use `ColorManger`.
- ❌ Using raw `.sp` for fonts. Use the `FontSize.*` constants.
- ❌ Introducing `flutter_dotenv` or `--dart-define` for environment config.
- ❌ Putting business logic inside a DataSource. DataSources only do HTTP + JSON parsing.
- ❌ Swallowing `DioException` without calling `handleDioError(e)`.
- ❌ Renaming files from `_manger` to `_manager`. Preserve the typo.
- ❌ Hardcoding user-facing strings in widgets instead of using `.arb` files.
- ❌ Adding new dependencies to `pubspec.yaml` without explicit maintainer approval.

---

## 11. LLM-Specific Failure Modes (Read Twice)

1. **Hallucinating Packages.** Suggesting `get_it`, `go_router`,
   `freezed`, or `dartz` because "they are industry standard." This
   project has made deliberate choices to avoid them. Respect that.
2. **Breaking Clean Architecture.** Putting a `Dio` call inside a
   `BlocBuilder` because it was "faster." The View → Cubit → UseCase →
   Repository → DataSource chain is strict.
3. **Over-engineering Models.** Adding `copyWith`, `equatable`, and
   `freezed` to a model when a simple manual `class` with `fromJson`
   is all that is needed.
4. **Ignoring `flutter_screenutil`.** Writing `EdgeInsets.all(16)`
   instead of `EdgeInsets.all(16.h)`. This breaks the app's responsive
   layout. (Remember: fonts use `FontSize.*`, not `.sp`).
5. **Fixing the `_manger` Typo.** AI loves to fix typos. Do not fix
   this one. It is an established convention in this codebase.
6. **Silently Breaking `main.dart`.** Adding a new Cubit but forgetting
   to wire it into the `MultiBlocProvider` tree.
7. **Non-Exhaustive Switches.** Adding a new state to a sealed class
   but forgetting to handle it in the UI's `switch` statement.
8. **Skipping `handleDioError`.** Catching a `DioException` and just
   returning `null` or printing it, bypassing the central error mapper.
9. **Hardcoding Strings.** Writing `Text('Login')` instead of
   `Text(AppLocalizations.of(context)!.login)`.
10. **Missing Abstract DataSources.** Implementing a DataSource class
    directly without defining an abstract interface for it to implement.

---

## 12. Definition of Done

A change is done when **all** of the following are true:

- [ ] Phase 0 orientation complete.
- [ ] Planning section in the PR description.
- [ ] Architecture boundaries respected (No HTTP in UI/Cubit).
- [ ] State management uses `Cubit` + `sealed class` in the same file.
- [ ] No forbidden patterns (Section 10).
- [ ] Colors use `ColorManger`; layout dimensions use `flutter_screenutil` (`.h`, `.w`); fonts use `FontSize.*`.
- [ ] Strings are localized in `.arb` files; `flutter gen-l10n` ran.
- [ ] `main.dart` updated if new Cubits/Dependencies were added.
- [ ] `RouteManger` updated if new screens were added.
- [ ] No new dependencies added without approval.
- [ ] `flutter analyze` passes with no new warnings.
- [ ] The `_manger` typo is preserved.

If you cannot tick every box, the work is not done. Say so in the PR
and ask the maintainer.

---

**End of rules. Read Section 0 and Section 11 before every change. Tick Section 12 before every PR.**
