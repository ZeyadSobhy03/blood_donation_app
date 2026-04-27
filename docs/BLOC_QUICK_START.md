# Quick Start Guide - Blood Donation Bloc

## 🚀 Getting Started in 5 Minutes

### Step 1: Navigate to Demo Screen

To use the complete demo with all three roles, navigate to:

```dart
import 'package:blood_donation_app/presentation/blood_donation_demo/blood_donation_demo_screen.dart';

// In your navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const BloodDonationDemoScreen(),
  ),
);
```

### Step 2: Use in Your Screens

#### In main.dart or at widget level:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';

BlocProvider(
  create: (context) => BloodDonationCubit(
    apiService: BloodDonationApiService(),
  ),
  child: MyScreen(),
),
```

#### In your screen/widget:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_loading_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_success_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_error_state.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';

class MyDonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BloodDonationCubit, BloodState>(
        builder: (context, state) {
          if (state is BloodLoadingState) {
            return const CustomLoadingWidget();
          } else if (state is BloodSuccessState) {
            return CustomSuccessWidget(
              data: state.data,
              message: state.message,
              onAction: () {
                // Handle action
              },
            );
          } else if (state is BloodErrorState) {
            return CustomErrorWidget(
              message: state.message,
              errorCode: state.errorCode,
              onRetry: () {
                // Retry operation
              },
              onDismiss: () {
                // Dismiss error
              },
            );
          }
          
          // Initial state - show form
          return Center(
            child: ElevatedButton(
              onPressed: () {
                // Trigger API call
                context.read<BloodDonationCubit>().submitBloodDonation(
                  bloodType: 'O+',
                  quantity: 1,
                );
              },
              child: const Text('Donate Blood'),
            ),
          );
        },
      ),
    );
  }
}
```

## 📱 Available Widgets

### 1. CustomLoadingWidget
```dart
CustomLoadingWidget(
  message: 'Processing your request...',
  indicatorSize: 50,
)
```

### 2. CustomSuccessWidget
```dart
CustomSuccessWidget<BloodDonationResponse>(
  data: response,
  message: 'Thank you for your donation!',
  actionButtonText: 'Continue',
  onAction: () {
    // Handle success action
  },
)
```

### 3. CustomErrorWidget
```dart
CustomErrorWidget(
  message: 'Failed to process donation',
  errorCode: 'DONATION_ERROR',
  onRetry: () {
    // Retry logic
  },
  onDismiss: () {
    // Dismiss error
  },
)
```

## 🔧 Available Cubit Methods

### For Hospital (Request Blood)
```dart
context.read<BloodDonationCubit>().requestBloodDonation(
  bloodType: 'O+',
  quantity: 2,
  location: 'City Hospital',
);
```

### For Donor (Donate Blood)
```dart
context.read<BloodDonationCubit>().submitBloodDonation(
  bloodType: 'A-',
  quantity: 1,
);
```

### For Admin (Manage Users)
```dart
context.read<BloodDonationCubit>().manageUser(
  userId: 'user_123',
  action: 'activate',
  reason: 'Verified documents',
);
```

### For Admin (Fetch Analytics)
```dart
context.read<BloodDonationCubit>().fetchAnalytics();
```

### Reset State
```dart
context.read<BloodDonationCubit>().reset();
```

## 📊 File Structure Quick Reference

| File | Purpose |
|------|---------|
| `blood_state.dart` | Base abstract state |
| `blood_loading_state.dart` | Loading state |
| `blood_success_state.dart` | Success with data |
| `blood_error_state.dart` | Error with details |
| `blood_donation_cubit.dart` | Main business logic |
| `blood_donation_api_service.dart` | API simulation |
| `custom_loading_widget.dart` | Loading UI |
| `custom_success_widget.dart` | Success UI |
| `custom_error_widget.dart` | Error UI |
| `blood_donation_demo_screen.dart` | Complete demo |

## 🎯 Common Patterns

### Pattern 1: Simple Button with API Call
```dart
ElevatedButton(
  onPressed: () {
    context.read<BloodDonationCubit>().submitBloodDonation(
      bloodType: selectedBloodType,
      quantity: selectedQuantity,
    );
  },
  child: const Text('Submit'),
)
```

### Pattern 2: Form with Validation
```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      context.read<BloodDonationCubit>().submitBloodDonation(
        bloodType: _bloodTypeController.text,
        quantity: int.parse(_quantityController.text),
      );
    }
  },
  child: const Text('Submit'),
)
```

### Pattern 3: Auto-dismiss Success
```dart
if (state is BloodSuccessState) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(seconds: 2), () {
      context.read<BloodDonationCubit>().reset();
    });
  });
  return CustomSuccessWidget(data: state.data, message: state.message);
}
```

### Pattern 4: Show Snackbar on Error
```dart
if (state is BloodErrorState) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message)),
    );
  });
  return CustomErrorWidget(
    message: state.message,
    onRetry: () {},
  );
}
```

## 🧪 Testing

### Unit Test for Cubit
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('BloodDonationCubit', () {
    late BloodDonationCubit bloodDonationCubit;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      bloodDonationCubit = BloodDonationCubit(
        apiService: mockApiService,
      );
    });

    tearDown(() {
      bloodDonationCubit.close();
    });

    blocTest<BloodDonationCubit, BloodState>(
      'emit [Loading, Success] when donation succeeds',
      build: () => bloodDonationCubit,
      act: (cubit) => cubit.submitBloodDonation(
        bloodType: 'O+',
        quantity: 1,
      ),
      expect: () => [
        isA<BloodLoadingState>(),
        isA<BloodSuccessState>(),
      ],
    );
  });
}
```

### Widget Test
```dart
testWidgets('show loading when donation in progress', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider(
        create: (_) => BloodDonationCubit(apiService: MockApiService()),
        child: const MyDonationScreen(),
      ),
    ),
  );

  expect(find.byType(CustomLoadingWidget), findsOneWidget);
});
```

## 💡 Tips & Tricks

1. **Always close the Cubit**: Use `BlocProvider` which handles this automatically
2. **Use BlocBuilder for UI**: Don't use `BlocListener` for navigation from states
3. **Generic Types**: Use generic types in `BloodSuccessState<T>` for type safety
4. **Error Codes**: Always provide error codes for debugging
5. **Reset State**: Call `reset()` after successful operation to go back to initial state
6. **AnimatedSwitcher**: Use it for smooth state transitions
7. **Context Safety**: Always check context availability in callbacks

## 🚨 Troubleshooting

### Issue: Widget not rebuilding
**Solution**: Ensure you're using `BlocBuilder` or `BlocConsumer`, not just `context.read()`

### Issue: Cubit already closed
**Solution**: Don't call cubit methods after `dispose()`. Use `BlocProvider` to manage lifecycle

### Issue: Multiple listeners firing
**Solution**: Use single `BlocBuilder` or `BlocConsumer` instead of multiple

### Issue: State not changing
**Solution**: Verify you're emitting a new state instance, not modifying existing one

---

For more details, see [BLOC_ARCHITECTURE_GUIDE.md](./BLOC_ARCHITECTURE_GUIDE.md)

