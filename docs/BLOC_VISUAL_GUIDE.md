# Blood Donation Bloc Architecture - Visual Guide

## 🏗️ Complete Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         UI LAYER                                │
│                   (Presentation)                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  Blood Donation Demo Screen                            │   │
│  │  ├─ Hospital Blood Request                            │   │
│  │  ├─ Donor Blood Donation                              │   │
│  │  ├─ Admin Analytics                                   │   │
│  │  └─ Role Selector                                     │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  Custom Widgets                                        │   │
│  │  ├─ CustomLoadingWidget                               │   │
│  │  ├─ CustomSuccessWidget<T>                            │   │
│  │  └─ CustomErrorWidget                                 │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  BlocBuilder / BlocConsumer                            │   │
│  │  └─ Listens to BloodState changes                      │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                    context.read()
                      └─ triggers
                           │
┌──────────────────────────┴──────────────────────────────────────┐
│                     CUBIT LAYER                                 │
│                  (Business Logic)                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  BloodDonationCubit                                    │   │
│  │  ├─ requestBloodDonation()                             │   │
│  │  ├─ submitBloodDonation()                              │   │
│  │  ├─ manageUser()                                       │   │
│  │  ├─ fetchAnalytics()                                   │   │
│  │  └─ reset()                                            │   │
│  │                                                         │   │
│  │  Flow:                                                 │   │
│  │  1. emit(BloodLoadingState)                            │   │
│  │  2. Call API                                           │   │
│  │  3. emit(BloodSuccessState | BloodErrorState)         │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                      emit(state)
                    └─ updates UI
                           │
┌──────────────────────────┴──────────────────────────────────────┐
│                     STATE LAYER                                 │
│               (State Management)                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────┐      │
│  │  abstract class BloodState {}                        │      │
│  └──────────────────────────────────────────────────────┘      │
│    ↓                     ↓                         ↓            │
│    │                     │                         │            │
│    │                     │                         │            │
│  ┌─┴───────────────┐ ┌─────┴─────┐ ┌──────┴──────────┐        │
│  │ BloodLoading    │ │ BloodSuccess<T>│ BloodError   │        │
│  │ State           │ │              │                │        │
│  │                 │ │ ├─ data: T   │ ├─ message    │        │
│  │                 │ │ └─ message   │ ├─ errorCode  │        │
│  │                 │ │              │ └─ exception  │        │
│  └─────────────────┘ └──────────────┘ └──────────────┘        │
│                                                                 │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                      callAPI()
                           │
┌──────────────────────────┴──────────────────────────────────────┐
│                     SERVICE LAYER                               │
│                  (API & Data)                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │  BloodDonationApiService                               │   │
│  │  ├─ requestBloodDonation()                             │   │
│  │  │  └─ Future.delayed(2s)                              │   │
│  │  │     ├─ 70% success                                  │   │
│  │  │     └─ 30% error                                    │   │
│  │  ├─ submitBloodDonation()                              │   │
│  │  │  └─ Future.delayed(2s)                              │   │
│  │  │     ├─ 75% success                                  │   │
│  │  │     └─ 25% error                                    │   │
│  │  ├─ manageUser()                                       │   │
│  │  │  └─ Future.delayed(2s)                              │   │
│  │  │     ├─ 80% success                                  │   │
│  │  │     └─ 20% error                                    │   │
│  │  └─ getAnalytics()                                     │   │
│  │     └─ Future.delayed(2s)                              │   │
│  │        ├─ 85% success                                  │   │
│  │        └─ 15% error                                    │   │
│  │                                                         │   │
│  │  Returns:                                              │   │
│  │  └─ BloodDonationResponse (or Map for analytics)       │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔄 State Transition Flow

```
┌────────────────┐
│  Initial State │  No state emitted, show form/initial content
└────────┬───────┘
         │
         │ User presses button
         ↓
┌────────────────────────────────┐
│  emit(BloodLoadingState)        │  Shows CustomLoadingWidget
│  - No data                      │  - Circular progress indicator
│  - No user interaction          │  - Loading message
└────────┬───────────────────────┘
         │
         │ API call: Future.delayed(2s)
         ↓
    ┌────┴───────────────────────┐
    │                             │
    │ (Success 70-85%)            │ (Error 15-30%)
    ↓                             ↓
┌──────────────────────┐  ┌──────────────────────┐
│ emit(BloodSuccess)   │  │ emit(BloodError)     │
│ - data: Response     │  │ - message: "..."     │
│ - message: "..."     │  │ - errorCode: "..."   │
└──────┬───────────────┘  └──────┬───────────────┘
       │                         │
       │ CustomSuccessWidget     │ CustomErrorWidget
       │ ├─ Success icon         │ ├─ Error icon
       │ ├─ Message              │ ├─ Message
       │ ├─ Details box          │ ├─ Error code
       │ └─ Action button        │ ├─ Retry button
       │    └─ onAction()        │ └─ Dismiss button
       │       └─ reset()        │    └─ onRetry()
       │          │              │       └─ Start over
       │          ↓              │
       └──────────┴──────────────┘
```

---

## 📊 Data Flow Diagram

```
User Input (Button Press)
           │
           ↓
┌─────────────────────────────────────────┐
│  context.read<BloodDonationCubit>()     │
│  .submitBloodDonation(...)              │
└────────────┬────────────────────────────┘
             │
             ↓
┌─────────────────────────────────────────┐
│  BloodDonationCubit.submitBloodDonation │
│  1. emit(BloodLoadingState)              │
└────────────┬────────────────────────────┘
             │
             ↓
┌─────────────────────────────────────────┐
│  apiService.submitBloodDonation(...)     │
│  await Future.delayed(2s)                │
└────────────┬────────────────────────────┘
             │
             ├─ Success (75%)
             │  └─ Return BloodDonationResponse
             │
             └─ Error (25%)
                └─ Throw Exception

        ↓ Back to Cubit

    Success Branch
         │
         ↓
    emit(BloodSuccessState(
      data: response,
      message: "Thank you..."
    ))
         │
         ↓
    BlocBuilder updates
         │
         ↓
    CustomSuccessWidget
    rendered
         │
         ↓
    Show message & data


    Error Branch
         │
         ↓
    emit(BloodErrorState(
      message: "Failed...",
      errorCode: "DONATION_ERROR"
    ))
         │
         ↓
    BlocBuilder updates
         │
         ↓
    CustomErrorWidget
    rendered
         │
         ↓
    Show message & retry
```

---

## 🎯 Role-Based Operation Flow

### Hospital Role: Request Blood

```
┌──────────────────────────┐
│ Select Blood Type (O+)   │
└────────────┬─────────────┘
             │
┌────────────┴─────────────┐
│ Select Quantity (2)      │
└────────────┬─────────────┘
             │
┌────────────┴─────────────────────────────────────┐
│ Press "Request Blood"                             │
│ → requestBloodDonation(                           │
│     bloodType: 'O+',                              │
│     quantity: 2,                                  │
│     location: 'Central Hospital'                  │
│   )                                               │
└────────────┬─────────────────────────────────────┘
             │
             ↓
    Processing... (2s)
         30% fail
         │
         ├─ Success (70%)
         │  └─ Show: "Blood request submitted!"
         │
         └─ Error (30%)
            └─ Show: "Failed to process. Retry?"
```

### Donor Role: Donate Blood

```
┌──────────────────────────┐
│ Select Blood Type (A-)   │
└────────────┬─────────────┘
             │
┌────────────┴──────────────────────┐
│ Press "Donate Blood"               │
│ → submitBloodDonation(             │
│     bloodType: 'A-',               │
│     quantity: 1                    │
│   )                                │
└────────────┬──────────────────────┘
             │
             ↓
    Processing... (2s)
         25% fail
         │
         ├─ Success (75%)
         │  └─ Show: "Thank you for your donation!"
         │
         └─ Error (25%)
            └─ Show: "Donation failed. Retry?"
```

### Admin Role: View Analytics

```
┌─────────────────────────────┐
│ Press "View Analytics"       │
│ → fetchAnalytics()           │
└────────────┬────────────────┘
             │
             ↓
    Processing... (2s)
         15% fail
         │
         ├─ Success (85%)
         │  └─ Show Analytics:
         │     ├─ Total Donors: 1245
         │     ├─ Total Donations: 3567
         │     ├─ Total Requests: 892
         │     └─ Blood Distribution
         │
         └─ Error (15%)
            └─ Show: "Failed to fetch. Retry?"
```

---

## 📱 Widget Hierarchy

```
BloodDonationDemoScreen
├─ Scaffold
│  ├─ AppBar
│  │  └─ CustomText("Blood Donation System")
│  │
│  └─ Body
│     ├─ Role Selector
│     │  ├─ HospitalRoleCard
│     │  ├─ DonorRoleCard
│     │  └─ AdminRoleCard
│     │
│     └─ BlocBuilder<BloodDonationCubit, BloodState>
│        ├─ BloodLoadingState
│        │  └─ CustomLoadingWidget()
│        │
│        ├─ BloodSuccessState
│        │  └─ CustomSuccessWidget<T>()
│        │
│        ├─ BloodErrorState
│        │  └─ CustomErrorWidget()
│        │
│        └─ Initial
│           ├─ RoleSpecificCard
│           ├─ BloodTypeSelector
│           ├─ QuantitySelector
│           └─ ActionButton
```

---

## 🔐 Type Safety

```
BloodState (Abstract Base)
    │
    ├─ BloodLoadingState
    │  └─ No data, no message
    │
    ├─ BloodSuccessState<T>
    │  ├─ data: T (Generic)
    │  │  ├─ BloodDonationResponse
    │  │  ├─ Map<String, dynamic>
    │  │  └─ Any Type
    │  └─ message: String
    │
    └─ BloodErrorState
       ├─ message: String
       ├─ errorCode: String?
       └─ exception: dynamic

Usage:
BloodSuccessState<BloodDonationResponse>(data: response)
BloodSuccessState<Map<String, dynamic>>(data: analytics)
BloodErrorState(message: "Error", errorCode: "ERR_001")
```

---

## 🔌 API Integration Points

```
Your Screen
    │
    ├─ context.read<BloodDonationCubit>()
    │  └─ .requestBloodDonation(...)
    │     .submitBloodDonation(...)
    │     .manageUser(...)
    │     .fetchAnalytics(...)
    │     .reset()
    │
    └─ BlocBuilder<BloodDonationCubit, BloodState>
       └─ Listens to state changes
          │
          ├─ BloodLoadingState
          │  └─ Show loading UI
          │
          ├─ BloodSuccessState
          │  └─ Show success UI with data
          │
          └─ BloodErrorState
             └─ Show error UI with retry
```

---

## 📦 Class Relationships

```
BloodState (abstract)
    ↑
    ├─ BloodLoadingState
    │  └─ extends BloodState
    │
    ├─ BloodSuccessState<T>
    │  └─ extends BloodState
    │     └─ generic type T
    │
    └─ BloodErrorState
       └─ extends BloodState

BloodDonationCubit
    ├─ extends Cubit<BloodState>
    ├─ uses BloodDonationApiService
    └─ emits: LoadingState, SuccessState, ErrorState

BloodDonationApiService
    ├─ returns BloodDonationResponse
    ├─ returns Map<String, dynamic>
    └─ throws Exception

BloodDonationResponse
    ├─ id: String
    ├─ message: String
    ├─ bloodType: String
    ├─ quantity: int
    ├─ location: String
    └─ timestamp: DateTime

Widgets
├─ CustomLoadingWidget
├─ CustomSuccessWidget<T>
└─ CustomErrorWidget
```

---

## 🎨 Color & Design System

```
CustomLoadingWidget
├─ Background: Transparent
├─ Indicator: ColorManger.brightRed
└─ Text: ColorManger.grey600

CustomSuccessWidget
├─ Background: ColorManger.lightGreen
├─ Icon: ColorManger.successColor
├─ Title: ColorManger.successColor
└─ Button: ColorManger.successColor

CustomErrorWidget
├─ Background: ColorManger.errorLightBackground
├─ Icon: ColorManger.brightRed
├─ Title: ColorManger.brightRed
├─ Text: ColorManger.grey600
└─ Button: ColorManger.brightRed

Role Cards
├─ Hospital: ColorManger.lightBlue
├─ Donor: ColorManger.softRed
└─ Admin: ColorManger.lightPurple
```

---

## 🔄 Complete State Lifecycle

```
Time 0s:  Initial State (no state emitted)
          ↓ Show form

Time 0s:  User presses button
          ↓ Call context.read<BloodDonationCubit>().submitBloodDonation()

Time 0s:  Cubit receives call
          ↓ emit(BloodLoadingState)

Time 0s+: UI rebuilds
          ↓ Shows CustomLoadingWidget (spinner)

Time 0s-2s: API call in progress
           ↓ Future.delayed(2000ms)

Time 2s:  API completes (success 75% / error 25%)

If Success:
  Time 2s:    emit(BloodSuccessState)
  Time 2s+:   UI rebuilds
  Time 2s+:   Shows CustomSuccessWidget
  Time 2s+:   Optional: Auto-dismiss after delay

If Error:
  Time 2s:    emit(BloodErrorState)
  Time 2s+:   UI rebuilds
  Time 2s+:   Shows CustomErrorWidget with retry
  Time 2s+:   User can retry → back to Time 0s
```

---

## 🧩 Component Interaction Matrix

```
                    Cubit       Service     States      Widgets
────────────────────────────────────────────────────────────────
User Action    →  triggers
Cubit          →  emits      →  none
Service        ←  called by   →  none
States         ←  emitted by         none
Widgets        ←  listen to                  ←  built with
BlocBuilder    →  listens to         →  renders
```

---

**This architecture ensures clean, testable, and maintainable code!**

