# Blood Donation Bloc Architecture

## Overview

This is a complete Flutter Bloc (Cubit) implementation using clean architecture principles for handling API states in the Blood Donation application. The architecture supports three user roles: Hospital, Donor, and Admin.

## Project Structure

```
lib/
├── core/
│   ├── cubits/
│   │   └── blood_donation/
│   │       ├── blood_donation_cubit.dart          # Main Cubit
│   │       ├── services/
│   │       │   └── blood_donation_api_service.dart # API Service
│   │       └── states/
│   │           ├── blood_state.dart                # Base abstract state
│   │           ├── blood_loading_state.dart        # Loading state
│   │           ├── blood_success_state.dart        # Success state
│   │           └── blood_error_state.dart          # Error state
│   └── widgets/
│       └── blood_donation/
│           ├── custom_loading_widget.dart          # Loading UI
│           ├── custom_success_widget.dart          # Success UI
│           └── custom_error_widget.dart            # Error UI
└── presentation/
    └── blood_donation_demo/
        └── blood_donation_demo_screen.dart         # Demo Screen
```

## Architecture Layers

### 1. **State Layer** (`states/`)

Each state is implemented in a separate file, following the single responsibility principle:

#### `blood_state.dart`
```dart
abstract class BloodState {
  const BloodState();
}
```
Base class for all states.

#### `blood_loading_state.dart`
```dart
class BloodLoadingState extends BloodState {
  const BloodLoadingState();
}
```
Emitted when an API request is in progress.

#### `blood_success_state.dart`
```dart
class BloodSuccessState<T> extends BloodState {
  final T data;
  final String message;

  const BloodSuccessState({
    required this.data,
    this.message = 'Operation successful',
  });
}
```
Emitted when API request succeeds, carries generic data.

#### `blood_error_state.dart`
```dart
class BloodErrorState extends BloodState {
  final String message;
  final String? errorCode;
  final dynamic exception;

  const BloodErrorState({
    required this.message,
    this.errorCode,
    this.exception,
  });
}
```
Emitted when API request fails, carries error details.

### 2. **Service Layer** (`services/`)

#### `blood_donation_api_service.dart`

Simulates API calls with realistic network delays and random success/failure scenarios:

```dart
- requestBloodDonation()      // Hospital: Request blood
- submitBloodDonation()       // Donor: Donate blood
- manageUser()                // Admin: Manage users
- getAnalytics()              // Admin: Fetch analytics
```

**Features:**
- Simulated 2-second network delay using `Future.delayed()`
- Random failure rates (15-30% based on operation)
- Type-safe response with `BloodDonationResponse` model
- Support for generic data responses

### 3. **Cubit Layer** (`blood_donation_cubit.dart`)

```dart
class BloodDonationCubit extends Cubit<BloodState> {
  // Emits loading before API call
  // Calls API method
  // Emits success or error based on result
}
```

**Key Methods:**
- `requestBloodDonation()` - Emit Loading → API call → Emit Success/Error
- `submitBloodDonation()` - Same pattern for donors
- `manageUser()` - Admin operations
- `fetchAnalytics()` - Analytics data
- `reset()` - Reset to loading state

**State Emission Flow:**
```
Initial: BloodLoadingState
         ↓
User Action (e.g., press button)
         ↓
Cubit: emit(BloodLoadingState)
         ↓
Cubit: Calls API
         ↓
API Response/Exception
         ↓
Cubit: emit(BloodSuccessState | BloodErrorState)
         ↓
UI: Updates automatically via BlocBuilder
```

### 4. **UI Layer** (`widgets/`)

#### `custom_loading_widget.dart`
- Circular progress indicator
- Loading message
- Customizable indicator size

#### `custom_success_widget.dart`
- Success icon with background
- Success message and details
- Optional action button
- Generic data display

#### `custom_error_widget.dart`
- Error icon with background
- Error message and code
- Retry button
- Optional dismiss button

### 5. **Presentation Layer** (`blood_donation_demo_screen.dart`)

Complete demo screen with:
- **Role Selection**: Hospital, Donor, Admin
- **Blood Type Selector**: 8 blood types
- **Quantity Selector**: 1-5 units
- **State Management**: BlocBuilder + BlocConsumer
- **UI Transitions**: AnimatedSwitcher for smooth state changes

## State Management Flow

### For Hospital (Request Blood):
```
User taps "Request Blood"
    ↓
Cubit.requestBloodDonation()
    ↓
emit(BloodLoadingState) → UI shows loading
    ↓
Future.delayed(2s)
    ↓
API call succeeds (70% chance)
    ↓
emit(BloodSuccessState) → UI shows success
    ↓
OR
    ↓
emit(BloodErrorState) → UI shows error with retry
```

### For Donor (Donate Blood):
```
User taps "Donate Blood"
    ↓
Cubit.submitBloodDonation()
    ↓
emit(BloodLoadingState) → UI shows loading
    ↓
Future.delayed(2s)
    ↓
API call succeeds (75% chance)
    ↓
emit(BloodSuccessState) → UI shows success
    ↓
OR
    ↓
emit(BloodErrorState) → UI shows error with retry
```

### For Admin (View Analytics):
```
User taps "View Analytics"
    ↓
Cubit.fetchAnalytics()
    ↓
emit(BloodLoadingState) → UI shows loading
    ↓
Future.delayed(2s)
    ↓
API call succeeds (85% chance)
    ↓
emit(BloodSuccessState<Map>) → UI shows analytics
    ↓
OR
    ↓
emit(BloodErrorState) → UI shows error with retry
```

## Usage Example

### 1. Provide the Cubit (in main.dart or at widget level):
```dart
BlocProvider(
  create: (context) => BloodDonationCubit(
    apiService: BloodDonationApiService(),
  ),
  child: const BloodDonationDemoScreen(),
)
```

### 2. Use BlocBuilder to listen to state changes:
```dart
BlocBuilder<BloodDonationCubit, BloodState>(
  builder: (context, state) {
    if (state is BloodLoadingState) {
      return const CustomLoadingWidget();
    } else if (state is BloodSuccessState) {
      return CustomSuccessWidget(
        data: state.data,
        message: state.message,
      );
    } else if (state is BloodErrorState) {
      return CustomErrorWidget(
        message: state.message,
        onRetry: () {
          context.read<BloodDonationCubit>().submitBloodDonation(...);
        },
      );
    }
    return const SizedBox();
  },
)
```

### 3. Emit actions:
```dart
context.read<BloodDonationCubit>().submitBloodDonation(
  bloodType: 'O+',
  quantity: 1,
);
```

## Key Features

✅ **Clean Architecture**: Separated concerns (State, Service, Cubit, UI)
✅ **SOLID Principles**: Single responsibility, Open/Closed
✅ **Type Safety**: Generic types for success state
✅ **Error Handling**: Comprehensive error states with codes
✅ **Scalability**: Easy to add new operations
✅ **Testing**: Each layer can be tested independently
✅ **Reusability**: Widgets are reusable across screens
✅ **Modern UI**: AnimatedSwitcher, smooth transitions
✅ **Role-Based**: Different logic for each user role
✅ **Realistic Simulation**: Fake API with delays and failures

## Extending the Architecture

### Add New Operation:

1. **Add to Service** (`blood_donation_api_service.dart`):
```dart
Future<BloodDonationResponse> newOperation() async {
  await Future.delayed(_delay);
  // Implementation
}
```

2. **Add Method to Cubit** (`blood_donation_cubit.dart`):
```dart
Future<void> newOperation() async {
  emit(const BloodLoadingState());
  try {
    final response = await apiService.newOperation();
    emit(BloodSuccessState<BloodDonationResponse>(data: response));
  } catch (e) {
    emit(BloodErrorState(message: e.toString()));
  }
}
```

3. **Use in UI** (`blood_donation_demo_screen.dart`):
```dart
context.read<BloodDonationCubit>().newOperation();
```

## Dependencies

- `flutter_bloc: ^9.1.1` - State management
- `flutter_screenutil: ^5.9.3` - Responsive design

## Testing

Each layer can be tested independently:

```dart
// Test Service
test('API service success', () async {
  final response = await apiService.submitBloodDonation(...);
  expect(response.id, isNotNull);
});

// Test Cubit
blocTest<BloodDonationCubit, BloodState>(
  'emit success state',
  build: () => BloodDonationCubit(apiService: mockApiService),
  act: (cubit) => cubit.submitBloodDonation(...),
  expect: () => [
    isA<BloodLoadingState>(),
    isA<BloodSuccessState>(),
  ],
);

// Test UI
testWidgets('show loading widget', (tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => BloodDonationCubit(...),
      child: const BloodDonationDemoScreen(),
    ),
  );
  expect(find.byType(CustomLoadingWidget), findsOneWidget);
});
```

## Best Practices Applied

1. **Separation of Concerns**: Each file has a single responsibility
2. **DRY Principle**: Reusable widgets and services
3. **Error Handling**: Comprehensive error states
4. **Type Safety**: Generic types where applicable
5. **Documentation**: Clear comments and structure
6. **Consistency**: Same patterns across all operations
7. **Performance**: No unnecessary rebuilds with BlocBuilder
8. **Accessibility**: Readable text and clear UI elements

---

**Created**: 2026-04-27
**Version**: 1.0
**Status**: Production-Ready

