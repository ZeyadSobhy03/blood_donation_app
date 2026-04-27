# Blood Donation Bloc - Import Reference

## Complete Import Guide

Use this file as a reference for importing all the components.

---

## 📦 State Imports

```dart
// Base state
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';

// Individual states
import 'package:blood_donation_app/core/cubits/states/states/blood_loading_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_success_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_error_state.dart';

// All states (if importing package)
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
```

---

## 🔌 Cubit & Service Imports

```dart
// Cubit
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';

// Service
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';

// API Response Model
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';
// Then use: BloodDonationResponse
```

---

## 🎨 Widget Imports

```dart
// Individual widgets
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';

// Using all three
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
```

---

## 🎬 Demo & Example Imports

```dart
// Complete Demo Screen
import 'package:blood_donation_app/presentation/blood_donation_demo/blood_donation_demo_screen.dart';

// Individual Example Screens
import 'package:blood_donation_app/presentation/blood_donation_examples/blood_donation_example_screens.dart';
// Then use:
// - HospitalBloodRequestScreen
// - DonorBloodDonationScreen
// - AdminAnalyticsScreen
```

---

## 📱 Flutter Bloc Imports

```dart
// BlocBuilder
import 'package:flutter_bloc/flutter_bloc.dart';

// For specific usage:
import 'package:flutter_bloc/flutter_bloc.dart';
// Then use: BlocBuilder<BloodDonationCubit, BloodState>

// For BlocConsumer
import 'package:flutter_bloc/flutter_bloc.dart';
// Then use: BlocConsumer<BloodDonationCubit, BloodState>

// For BlocProvider
import 'package:flutter_bloc/flutter_bloc.dart';
// Then use: BlocProvider<BloodDonationCubit>
```

---

## 🎨 Other Imports (Already Available)

```dart
// Colors
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';

// Fonts
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';

// Custom Text Widget
import 'package:blood_donation_app/core/widgets/custom_text.dart';

// Screen Util
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

---

## 📋 Complete Setup Example

### Import Everything You Need

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// States
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_loading_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_success_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_error_state.dart';

// Cubit & Service
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';

// Widgets
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';

// Colors & Fonts
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';

class MyBloodDonationScreen extends StatefulWidget {
  const MyBloodDonationScreen({super.key});

  @override
  State<MyBloodDonationScreen> createState() => _MyBloodDonationScreenState();
}

class _MyBloodDonationScreenState extends State<MyBloodDonationScreen> {
  late BloodDonationCubit bloodCubit;

  @override
  void initState() {
    super.initState();
    bloodCubit = BloodDonationCubit(
      apiService: BloodDonationApiService(),
    );
  }

  @override
  void dispose() {
    bloodCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BloodDonationCubit, BloodState>(
        bloc: bloodCubit,
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
              onRetry: () {},
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
```

---

## 🔍 Import Organization Best Practices

### 1. Organize Imports by Category

```dart
// 1. Dart imports
import 'dart:async';
import 'dart:ui';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 4. App imports - By feature
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
```

### 2. Use Relative Imports (Alternative)

```dart
// Instead of full path:
// import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';

// You can use relative imports in same project:
// (But absolute imports are cleaner for large projects)
```

---

## 📦 Common Import Patterns

### Pattern 1: Just Using the Demo

```dart
import 'package:blood_donation_app/presentation/blood_donation_demo/blood_donation_demo_screen.dart';

// In your navigation:
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const BloodDonationDemoScreen(),
));
```

### Pattern 2: Implementing Your Own Screen

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_loading_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_success_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_error_state.dart';
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';

import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
```

### Pattern 3: Using Custom Widgets Only

```dart
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';

// These widgets can be used independently without Cubit
```

### Pattern 4: Copy Existing Example

```dart
// Just copy the imports from blood_donation_example_screens.dart
// All imports are already there!
```

---

## ✅ Verification

### Quick Import Check

Run this in your IDE to verify all imports work:

```bash
# In terminal at project root:
flutter pub get
flutter analyze

# Should show no import errors
```

### Test Import

```dart
// Create a test file to verify imports work:
import 'package:blood_donation_app/presentation/blood_donation_demo/blood_donation_demo_screen.dart';

void main() {
  // If this builds without errors, all imports are working
  print('All imports successful!');
}
```

---

## 🎯 Import Quick Reference

| Need | Import |
|------|--------|
| Cubit | `blood_donation_cubit.dart` |
| States | All 4 state files |
| Widgets | All 3 widget files |
| API Service | `blood_donation_api_service.dart` |
| Demo | `blood_donation_demo_screen.dart` |
| Examples | `blood_donation_example_screens.dart` |
| Colors | `color_manger.dart` |
| Fonts | `font_manger.dart` |
| Custom Text | `custom_text.dart` |

---

## 📋 Copy-Paste Import Template

```dart
// ============================================================================
// BLOOD DONATION BLOC - COMPLETE IMPORTS
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// States
import 'package:blood_donation_app/core/cubits/states/states/blood_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_loading_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_success_state.dart';
import 'package:blood_donation_app/core/cubits/states/states/blood_error_state.dart';

// Cubit & Service
import 'package:blood_donation_app/core/cubits/states/blood_donation_cubit.dart';
import 'package:blood_donation_app/core/cubits/states/services/blood_donation_api_service.dart';

// Widgets
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';

// Resources
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';

// ============================================================================
// Now you're ready to use all components!
// ============================================================================
```

---

## 🚀 Ready to Use!

All imports are configured and ready to use.

**Just copy the import statements and start coding!**

For detailed usage examples, see:
- `BLOC_QUICK_START.md`
- `blood_donation_demo_screen.dart`
- `blood_donation_example_screens.dart`

