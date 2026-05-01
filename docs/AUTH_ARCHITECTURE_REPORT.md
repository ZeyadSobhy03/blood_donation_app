# 🔐 AUTH MODULE - ARCHITECTURE REPORT

**Report Date:** April 30, 2026  
**Status:** Architecture Design Phase  
**Scope:** Authentication & Authorization System Design  
**Target:** Flutter Frontend - Auth Module Structure

---

## 📋 EXECUTIVE SUMMARY

The AUTH module is the foundation of the entire application. It handles:
- User login (role-based: donor, hospital, admin)
- User registration (with role selection)
- Phone verification via OTP
- Two-Factor Authentication (2FA)
- Token management (access + refresh tokens)
- Session management (get current user)
- Logout functionality

**Total AUTH Endpoints:** 8  
**Total AUTH Screens Needed:** 6-7  
**Architecture Pattern:** BLoC/Cubit + Repository + API Service

---

---

## 🔐 ENDPOINT-BY-ENDPOINT ARCHITECTURE

---

### ENDPOINT 1: POST /auth/login

**Purpose:** Authenticate user with email/password

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Public (all users) |
| **Feature** | Authentication |
| **Screen Name** | LoginScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ❌ No |
| **Request Body** | JSON (email, password) |
| **Response** | access_token, refresh_token, user_role, user_id |

**Usage Scenario:**
```
1. User opens app → LoginScreen displayed
2. User enters email & password
3. User taps "Login" button
4. LoginScreen calls AuthCubit.login(email, password)
5. AuthCubit calls AuthRepository.login(email, password)
6. Repository calls AuthApiService.login(email, password)
7. API Service makes HTTP POST to /auth/login
8. On success:
   - Save tokens to local storage (HiveBox/SharedPreferences)
   - Save user role (donor/hospital/admin)
   - Emit AuthenticatedState
   - Navigator routes to RoleBasedHomeScreen
9. On failure:
   - Emit AuthErrorState with error message
   - Show snackbar with error
```

**Request Format:**
```
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "user@example.com",
      "full_name": "Ahmed Ali",
      "role": "donor",
      "phone_verified": true,
      "is_2fa_enabled": false
    },
    "expires_in": 900
  },
  "timestamp": "2026-04-30T10:00:00Z"
}
```

**State Management Flow:**
```
AuthInitialState
    ↓
User enters credentials & taps login
    ↓
AuthLoadingState
    ↓
API call to /auth/login
    ↓
Success: AuthenticatedState (stores tokens & user data)
Failure: AuthErrorState (shows error message)
```

**Decision Points:**
- Check if user's email is verified before allowing login
- Check if 2FA is enabled → redirect to 2FA verification
- Store tokens securely in local storage
- Navigate based on role (donor → DonorHome, hospital → HospitalHome, admin → AdminHome)

---

### ENDPOINT 2: POST /auth/register

**Purpose:** Create new user account with role selection

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Public (new users) |
| **Feature** | Authentication |
| **Screen Name** | SignupScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ❌ No |
| **Request Body** | JSON (email, password, full_name, phone, role) |
| **Response** | user_id, email, role, verification_required |

**Usage Scenario:**
```
1. User on LoginScreen taps "Sign Up" button
2. Navigator pushes SignupScreen
3. SignupScreen shows multi-step form:
   - Step 1: Select role (donor/hospital/admin)
   - Step 2: Enter email, full name, phone
   - Step 3: Enter password & confirm password
   - Step 4: Accept terms & conditions
4. User taps "Create Account" button
5. SignupScreen calls AuthCubit.register(...)
6. AuthCubit calls AuthRepository.register(...)
7. Repository calls AuthApiService.register(...)
8. API Service makes HTTP POST to /auth/register
9. On success:
   - Show "Account created successfully"
   - Emit RegistrationSuccessState
   - Auto-redirect to OTP verification screen (SendOtpScreen)
   - Should verify phone number next
10. On failure:
    - Show validation errors (email exists, weak password, etc.)
    - Emit RegistrationErrorState
```

**Request Format:**
```
Content-Type: application/json

{
  "email": "newuser@example.com",
  "password": "securePassword123",
  "confirm_password": "securePassword123",
  "full_name": "Ahmed Ali",
  "phone": "+92-300-1234567",
  "role": "donor",
  "terms_accepted": true
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440001",
    "email": "newuser@example.com",
    "role": "donor",
    "full_name": "Ahmed Ali",
    "phone": "+92-300-1234567",
    "email_verified": false,
    "phone_verified": false,
    "message": "Account created. Please verify your phone number."
  },
  "timestamp": "2026-04-30T10:05:00Z"
}
```

**State Management Flow:**
```
AuthInitialState
    ↓
User fills signup form
    ↓
AuthLoadingState
    ↓
API call to /auth/register
    ↓
Success: RegistrationSuccessState
         (auto-dispatch SendOtpEvent to send OTP to phone)
Failure: AuthErrorState (validation errors)
```

**Decision Points:**
- Validate email format and uniqueness
- Validate password strength (min 8 chars, special chars, etc.)
- Validate phone number format
- Check if role is valid (donor/hospital/admin)
- After signup, immediately send OTP to phone for verification

---

### ENDPOINT 3: POST /auth/send-otp

**Purpose:** Send OTP code to user's phone for verification

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Public (unverified users) |
| **Feature** | PhoneVerification |
| **Screen Name** | SendOtpScreen / OtpVerificationScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) or `otp_cubit.dart` (OtpCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ❌ No (but may need temp token for unverified users) |
| **Request Body** | JSON (identifier: email/phone) |
| **Response** | otp_sent_successfully, expires_in, resend_after |

**Usage Scenario:**
```
1. User comes from SignupScreen (just created account)
   OR User is already logged in but phone unverified
   OR User forgot password (password reset flow)
2. Lands on SendOtpScreen
3. Shows message: "We've sent a 6-digit code to +92-300-1234567"
4. Shows form field to enter OTP
5. Shows "Resend Code" button (disabled for 30 seconds)
6. If resend needed, calls AuthCubit.sendOtp(phone) again
7. User enters OTP
8. Taps "Verify" button
9. Calls AuthCubit.verifyOtp(otp_code)
10. (See verifyOtp endpoint below)

Alternative flow:
- Phone verification after login:
  1. User logged in but phone_verified = false
  2. App shows banner: "Please verify your phone"
  3. User taps "Verify Now"
  4. SendOtpScreen opens
  5. Backend sends OTP to verified phone on file
  6. After verification, app resumes normal flow
```

**Request Format:**
```
Content-Type: application/json

{
  "phone": "+92-300-1234567"
}
OR
{
  "email": "user@example.com"
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "otp_id": "550e8400-e29b-41d4-a716-446655440002",
    "phone": "+92-300-1234567",
    "masked_phone": "+92-300-****567",
    "otp_sent": true,
    "expires_in": 300,
    "message": "OTP sent successfully",
    "resend_after_seconds": 30,
    "attempt_limit": 5
  },
  "timestamp": "2026-04-30T10:10:00Z"
}
```

**State Management Flow:**
```
SendOtpInitialState
    ↓
User taps "Send OTP" / Auto-send after signup
    ↓
SendOtpLoadingState (shows loading spinner)
    ↓
API call to /auth/send-otp
    ↓
Success: SendOtpSuccessState
         (show OTP input field, start 300s timer, disable resend for 30s)
Failure: SendOtpErrorState (show error, allow retry)
```

**Decision Points:**
- Rate limit: max 5 attempts per 10 minutes
- OTP validity: 5 minutes (300 seconds)
- Resend cooldown: 30 seconds
- Different channels: SMS vs Email vs WhatsApp
- Masked phone display for security

---

### ENDPOINT 4: POST /auth/verify-otp

**Purpose:** Verify OTP code sent to user's phone

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Public (unverified users) |
| **Feature** | PhoneVerification |
| **Screen Name** | OtpVerificationScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) or `otp_cubit.dart` (OtpCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ❌ No |
| **Request Body** | JSON (otp_id, otp_code) |
| **Response** | success, access_token (if signup flow), phone_verified |

**Usage Scenario:**
```
Context 1: During Signup
1. User created account → Lands on OtpVerificationScreen
2. Shows: "Enter 6-digit code sent to +92-300-****567"
3. Shows 6 input fields (auto-focus, auto-submit on 6 digits)
4. User enters code: 123456
5. Calls AuthCubit.verifyOtp(otp_id, "123456")
6. Calls AuthRepository.verifyOtp(otp_id, "123456")
7. API makes POST to /auth/verify-otp
8. On success:
   - User's phone_verified = true
   - Return tokens (access_token, refresh_token)
   - Save tokens to local storage
   - Emit AuthenticatedState
   - Navigate to role-based home (DonorHome, HospitalHome, AdminHome)
9. On failure (wrong OTP):
   - Show error: "Incorrect OTP. Try again."
   - Decrement attempt counter
   - If attempts exhausted: show "Resend Code" button

Context 2: Verification After Login
1. User logged in but phone_verified = false
2. App shows toast: "Please verify phone"
3. Redirects to OtpVerificationScreen
4. User enters OTP
5. On success:
   - Update user object's phone_verified flag
   - Show success toast
   - Return to previous screen (DonorHome, etc.)
```

**Request Format:**
```
Content-Type: application/json

{
  "otp_id": "550e8400-e29b-41d4-a716-446655440002",
  "otp_code": "123456"
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "user_id": "550e8400-e29b-41d4-a716-446655440001",
    "phone_verified": true,
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "message": "Phone verified successfully",
    "expires_in": 900
  },
  "timestamp": "2026-04-30T10:12:00Z"
}
```

**State Management Flow:**
```
OtpVerificationInitialState
    ↓
User enters OTP code
    ↓
OtpVerifyingState (show loading)
    ↓
API call to /auth/verify-otp
    ↓
Success: OtpVerifiedState
         (If signup: emit AuthenticatedState + navigate)
         (If just verification: emit PhoneVerifiedState + pop)
Failure: OtpVerificationErrorState (show error, allow retry)
```

**Decision Points:**
- OTP attempt limit: 5 attempts max
- Case insensitive OTP (accept both uppercase and numeric)
- Auto-focus next field as user types
- Show countdown timer (300s → 0)
- Disable verify button until 6 digits entered
- Show "Resend Code" button only if attempts remain and timer expired

---

### ENDPOINT 5: POST /auth/send-otp (Password Reset variant)

**Purpose:** Send OTP to user's registered email for password reset

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Public (forgot password) |
| **Feature** | PasswordRecovery |
| **Screen Name** | ForgotPasswordScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `password_reset_cubit.dart` (PasswordResetCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ❌ No |
| **Request Body** | JSON (email) with context: "password_reset" |
| **Response** | otp_sent_successfully, otp_id |

**Usage Scenario:**
```
1. User on LoginScreen taps "Forgot Password?" link
2. Navigator pushes ForgotPasswordScreen
3. User enters email: user@example.com
4. Taps "Send Reset Code" button
5. Calls PasswordResetCubit.sendPasswordResetOtp(email)
6. API makes POST to /auth/send-otp with context="password_reset"
7. Backend sends OTP to email (not SMS)
8. On success:
   - Show: "We've sent a code to user@example.com"
   - Show form to enter OTP
   - Start 5-minute countdown timer
9. User enters OTP
10. Calls PasswordResetCubit.verifyPasswordResetOtp(otp_code)
11. On verification success:
    - Emit PasswordResetOtpVerifiedState
    - Navigate to NewPasswordScreen
12. User enters new password
13. Calls PasswordResetCubit.resetPassword(new_password)
14. (See password-reset endpoint)
```

**Request Format:**
```
Content-Type: application/json

{
  "email": "user@example.com",
  "context": "password_reset"
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "otp_id": "550e8400-e29b-41d4-a716-446655440003",
    "email": "user@example.com",
    "masked_email": "us**@example.com",
    "otp_sent": true,
    "expires_in": 300,
    "message": "Password reset code sent to your email",
    "resend_after_seconds": 30
  },
  "timestamp": "2026-04-30T10:15:00Z"
}
```

**State Management Flow:**
```
PasswordResetInitialState
    ↓
User enters email
    ↓
SendingPasswordResetOtpState
    ↓
API call to /auth/send-otp (with context="password_reset")
    ↓
Success: PasswordResetOtpSentState (show OTP input)
Failure: PasswordResetErrorState (show error)
```

**Decision Points:**
- Send OTP to email (not SMS for security)
- Rate limit: 3 password resets per email per day
- Different OTP from phone verification OTP
- Extend timeout to 10-15 minutes for email (more generous than SMS)

---

### ENDPOINT 6: POST /auth/2fa/setup

**Purpose:** Enable Two-Factor Authentication for user account

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Authenticated (donor, hospital, admin) |
| **Feature** | SecuritySettings / TwoFactorAuth |
| **Screen Name** | TwoFactorSetupScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `settings_cubit.dart` or `2fa_cubit.dart` (TwoFactorCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ✅ Yes (Bearer token) |
| **Request Body** | JSON (method: "sms" or "email") |
| **Response** | qr_code, backup_codes, secret_key |

**Usage Scenario:**
```
Version 1: TOTP (Google Authenticator)
1. User in ProfileScreen → Settings → Security Settings
2. Taps "Enable Two-Factor Authentication"
3. Navigator pushes TwoFactorSetupScreen
4. Shows 3 setup methods:
   - Option 1: Google Authenticator / Authy
   - Option 2: SMS Code
   - Option 3: Email Code
5. User selects "Google Authenticator"
6. Calls TwoFactorCubit.setupTwoFactor(method="authenticator")
7. API makes POST to /auth/2fa/setup
8. Backend generates secret and QR code
9. Returns QR code image
10. TwoFactorSetupScreen displays:
    - QR code image
    - Manual entry code (for backup)
    - "Scan with Authenticator app" instructions
    - Backup codes (10 one-time use codes)
    - "I've saved my backup codes" checkbox
11. User scans QR with Google Authenticator app
12. Authenticator app shows 6-digit code
13. User enters code in app to verify
14. Calls TwoFactorCubit.verifyTwoFactor(code)
15. (See 2fa/verify endpoint)
16. On success, show "2FA enabled" confirmation

Version 2: SMS OTP
1. Same flow as above
2. User selects "SMS Code"
3. API sends OTP to registered phone
4. User enters OTP received via SMS
5. Verify OTP to confirm 2FA setup
```

**Request Format:**
```
Content-Type: application/json
Authorization: Bearer {access_token}

{
  "method": "authenticator|sms|email"
}
```

**Response Format (TOTP):**
```
{
  "success": true,
  "data": {
    "2fa_id": "550e8400-e29b-41d4-a716-446655440004",
    "method": "authenticator",
    "qr_code_url": "data:image/png;base64,iVBORw0KGgoAAAANS...",
    "secret_key": "JBSWY3DPEBLW64TMMQ======",
    "manual_entry_key": "JBSWY3DPEBLW64TMMQ======",
    "backup_codes": [
      "65AZ-4QXE",
      "34NM-7WKJ",
      "92PQ-8RLM",
      "...8 more codes"
    ],
    "expires_in": 600,
    "message": "Scan QR code with Authenticator app"
  },
  "timestamp": "2026-04-30T10:20:00Z"
}
```

**Response Format (SMS):**
```
{
  "success": true,
  "data": {
    "2fa_id": "550e8400-e29b-41d4-a716-446655440004",
    "method": "sms",
    "phone": "+92-300-1234567",
    "masked_phone": "+92-300-****567",
    "otp_sent": true,
    "expires_in": 300,
    "message": "OTP sent to your phone"
  },
  "timestamp": "2026-04-30T10:20:00Z"
}
```

**State Management Flow:**
```
TwoFactorInitialState
    ↓
User selects 2FA method
    ↓
TwoFactorSetupLoadingState
    ↓
API call to /auth/2fa/setup
    ↓
Success: TwoFactorSetupState (show QR code or OTP input)
Failure: TwoFactorSetupErrorState (show error)
         
User confirms (scans QR or enters OTP)
    ↓
Calls TwoFactorCubit.verifyTwoFactor(code)
    ↓
(See 2fa/verify endpoint below)
```

**Decision Points:**
- Allow user to choose method (TOTP, SMS, Email)
- Show backup codes with warning "Save these codes safely"
- Allow downloading backup codes as PDF
- Set expiry: 10 minutes to complete setup
- Don't enable 2FA until verified

---

### ENDPOINT 7: POST /auth/2fa/verify

**Purpose:** Verify 2FA code to confirm setup OR verify 2FA on login

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Authenticated (any role) or during login |
| **Feature** | TwoFactorAuth |
| **Screen Name** | TwoFactorVerificationScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` or `2fa_cubit.dart` (TwoFactorCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | Partially (temp token if during login) |
| **Request Body** | JSON (2fa_id, code) |
| **Response** | success, access_token (if login), 2fa_enabled=true |

**Usage Scenario:**

Context 1: During 2FA Setup
```
1. User on TwoFactorSetupScreen
2. Has scanned QR code with Authenticator app
3. Authenticator shows: 123456 (6-digit code)
4. User enters 123456 in TwoFactorSetupScreen
5. Taps "Verify" button
6. Calls TwoFactorCubit.verifyTwoFactor(2fa_id, "123456")
7. API makes POST to /auth/2fa/verify
8. Backend validates code against TOTP secret
9. On success:
   - Enable 2FA on user account
   - Show "2FA successfully enabled"
   - Save backup codes locally
   - Navigate back to Security Settings
   - Show "2FA: ENABLED" with disable option
10. On failure:
    - Show "Invalid code. Please try again."
    - Allow 5 attempts
    - Offer rescan option
```

Context 2: During Login (if 2FA enabled)
```
1. User enters email/password on LoginScreen
2. AuthCubit.login() succeeds but user.2fa_enabled = true
3. Backend returns temporary token (short expiry, limited scope)
4. App recognizes 2FA required
5. Navigate to TwoFactorVerificationScreen
6. Shows: "Enter 6-digit code from Authenticator app"
7. User opens Google Authenticator app
8. Sees code: 234567
9. User enters 234567 in app
10. Taps "Verify" button
11. Calls AuthCubit.verify2FA(code, temp_token)
12. API makes POST to /auth/2fa/verify with temp token
13. On success:
    - Return permanent access_token & refresh_token
    - Save tokens
    - Emit AuthenticatedState
    - Navigator.pushReplacementNamed('home_based_on_role')
14. On failure:
    - Show error
    - Allow retry or fallback option
    - Show "Use backup code?" option
```

Context 3: Using Backup Code
```
1. User lost phone / can't access authenticator
2. On TwoFactorVerificationScreen, taps "Use Backup Code"
3. Shows text field to enter backup code
4. User enters backup code: 65AZ-4QXE
5. Calls AuthCubit.verify2FAwithBackupCode(backup_code)
6. Same API endpoint but code = backup_code
7. On success:
   - Log in user
   - Show warning: "Backup code used. 9 codes remaining."
   - Recommend regenerating backup codes later
```

**Request Format:**
```
Content-Type: application/json
Authorization: Bearer {access_token or temp_token}

{
  "2fa_id": "550e8400-e29b-41d4-a716-446655440004",
  "code": "123456"
}
OR (for backup code)
{
  "2fa_id": "550e8400-e29b-41d4-a716-446655440004",
  "backup_code": "65AZ-4QXE"
}
```

**Response Format (Setup Verification):**
```
{
  "success": true,
  "data": {
    "2fa_verified": true,
    "2fa_enabled": true,
    "method": "authenticator",
    "message": "Two-Factor Authentication enabled successfully",
    "backup_codes_remaining": 10
  },
  "timestamp": "2026-04-30T10:22:00Z"
}
```

**Response Format (Login Verification):**
```
{
  "success": true,
  "data": {
    "2fa_verified": true,
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "user@example.com",
      "role": "donor"
    },
    "expires_in": 900
  },
  "timestamp": "2026-04-30T10:22:00Z"
}
```

**State Management Flow:**
```
TwoFactorVerificationInitialState
    ↓
User enters 2FA code
    ↓
TwoFactorVerifyingState (show loading)
    ↓
API call to /auth/2fa/verify
    ↓
Success (during setup): TwoFactorVerifiedState (show success, pop)
Success (during login): AuthenticatedState (navigate to home)
Failure: TwoFactorVerificationErrorState (show error, allow retry)
```

**Decision Points:**
- Rate limiting: 5 failed attempts = temporary lockout (15 minutes)
- Code must be 6 digits (TOTP) or backup code format (XXXX-XXXX)
- Accept codes with or without hyphens
- Backup code is single-use, decrements counter
- Clear expired TOTP codes after validation
- If backup codes running low (< 3), recommend regeneration

---

### ENDPOINT 8: GET /auth/me (or POST /auth/validate-token)

**Purpose:** Get current authenticated user's details OR validate existing token

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Authenticated (any role) |
| **Feature** | Authentication / Session |
| **Screen Name** | SplashScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) |
| **HTTP Method** | GET or POST |
| **Requires Auth** | ✅ Yes (Bearer token) |
| **Request Body** | None (GET) or empty JSON (POST) |
| **Response** | user_id, email, role, verification status, 2fa_enabled |

**Usage Scenario:**

Context 1: App Startup (SplashScreen)
```
1. App launches → SplashScreen shown
2. SplashScreen checks if access_token exists in local storage
3. If token found:
   - Call AuthCubit.validateToken() OR AuthCubit.getCurrentUser()
   - API makes GET to /auth/me OR POST to /auth/validate-token
   - Show loading spinner on SplashScreen
4. If token valid:
   - Update user object in AuthCubit state
   - Check user.phone_verified:
     - If false: Show phone verification warning
     - If true: Continue
   - Check user.role:
     - If "donor": Navigator.pushReplacementNamed('donor_home')
     - If "hospital": Navigator.pushReplacementNamed('hospital_home')
     - If "admin": Navigator.pushReplacementNamed('admin_home')
5. If token expired:
   - Automatic refresh using refresh_token
   - (See refresh-token endpoint below)
6. If token invalid/revoked:
   - Clear local storage
   - Navigator.pushReplacementNamed('login')
   - Show message: "Session expired. Please login again."
7. If no token found:
   - Navigator.pushReplacementNamed('login')
```

Context 2: User Taps Profile / Settings
```
1. User navigates to ProfileScreen
2. Current user data may be stale
3. Can optionally call AuthCubit.refreshCurrentUser()
4. API makes GET to /auth/me
5. Update user object with latest data
6. Refresh all user-related UI (name, email, phone, etc.)
```

Context 3: Check if Phone Verified
```
1. App received notification that user should verify phone
2. Need to check current status
3. Call AuthCubit.getCurrentUser()
4. Check if user.phone_verified has changed
5. If true, dismiss verification banner
6. If false, show verification reminder
```

**Request Format:**
```
GET /api/v1/auth/me
Authorization: Bearer {access_token}
Content-Type: application/json

No request body (GET)
```

OR

```
POST /api/v1/auth/validate-token
Authorization: Bearer {access_token}
Content-Type: application/json

{}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "user@example.com",
      "full_name": "Ahmed Ali",
      "phone": "+92-300-1234567",
      "role": "donor",
      "status": "active",
      "phone_verified": true,
      "email_verified": true,
      "is_2fa_enabled": false,
      "2fa_method": null,
      "blood_type": "O+",
      "profile_picture_url": "https://api.example.com/profiles/user_123.jpg",
      "created_at": "2025-01-15T10:00:00Z",
      "last_login": "2026-04-30T10:00:00Z"
    },
    "token_valid": true,
    "expires_in": 850
  },
  "timestamp": "2026-04-30T10:25:00Z"
}
```

**State Management Flow:**
```
App Startup
    ↓
Call AuthCubit.appStarted()
    ↓
Check for cached token
    ↓
Token found:
    ↓
    AuthLoadingState
    ↓
    API call to /auth/me
    ↓
    Token valid: AuthenticatedState (user object updated)
             → Navigate to role-based home
    Token expired: Call refresh-token endpoint
    Token invalid: AuthUnauthenticatedState → Navigate to login

No token found:
    ↓
    AuthUnauthenticatedState
    ↓
    Navigate to LoginScreen
```

**Decision Points:**
- This is the MOST IMPORTANT endpoint for app startup
- Must be called on every app launch
- Must handle token expiration gracefully
- Must cache user object to avoid multiple calls
- Should call this before navigating to home screen
- Include verification status for UI decisions

---

### ENDPOINT 9: POST /auth/refresh-token

**Purpose:** Exchange expired access token for new one using refresh token

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Authenticated (any role) |
| **Feature** | TokenManagement |
| **Screen Name** | (Background/Automatic) |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) or HTTP interceptor |
| **HTTP Method** | POST |
| **Requires Auth** | Partially (refresh_token in body, not header) |
| **Request Body** | JSON (refresh_token) |
| **Response** | new access_token, new refresh_token |

**Usage Scenario:**

Context 1: Automatic During API Call (HTTP Interceptor)
```
1. User is logged in, browsing app
2. Makes API call to /donor/dashboard (for example)
3. HTTP client adds Authorization header with access_token
4. Server receives request, validates token
5. Token is EXPIRED (based on expiry time)
6. Server returns 401 Unauthorized
7. HTTP Interceptor catches 401 response
8. Checks if refresh_token exists in local storage
9. If yes:
   - Calls AuthCubit.refreshToken() OR TokenManager.refresh()
   - API makes POST to /auth/refresh-token
   - Sends refresh_token in request body
10. On success:
    - Save new access_token to local storage
    - Retry original API call with new token
    - User doesn't notice any interruption
11. On failure (refresh_token also expired):
    - Clear all tokens
    - Emit AuthUnauthenticatedState
    - Show login screen
    - Show message: "Session expired. Please login again."
```

Context 2: Explicit Token Refresh (Before Expiry)
```
1. App can proactively refresh token before expiry
2. Call AuthCubit.refreshToken() manually
3. API makes POST to /auth/refresh-token
4. On success: update cached token
5. On failure: proceed normally (don't interrupt user)
```

Context 3: Token Nearing Expiration
```
1. Timer checks token expiry time
2. If < 5 minutes remaining:
   - Call AuthCubit.refreshToken() proactively
   - No user interruption
   - New token ready before old one expires
```

**Request Format:**
```
Content-Type: application/json

{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1NTBlODQwMC1l..."
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expires_in": 900,
    "message": "Token refreshed successfully"
  },
  "timestamp": "2026-04-30T10:30:00Z"
}
```

**State Management Flow:**
```
Normal State (any state)
    ↓
Token nearing expiry OR 401 received
    ↓
RefreshingTokenState (silent, no UI change)
    ↓
API call to /auth/refresh-token
    ↓
Success: Update tokens in local storage, continue
Failure: AuthUnauthenticatedState + navigate to login
```

**Decision Points:**
- This call should be SILENT (no loading dialogs/spinners)
- Refresh tokens have longer expiry (7 days)
- If refresh_token also expired, user must re-login
- Should be handled by HTTP Interceptor automatically
- Should cache tokens securely (encrypted)
- Should have retry logic in case of network failure

---

### ENDPOINT 10: POST /auth/logout

**Purpose:** Revoke tokens and end user session

**Details:**

| Property | Value |
|----------|-------|
| **Role** | Authenticated (any role) |
| **Feature** | Authentication |
| **Screen Name** | ProfileScreen / SettingsScreen |
| **API Service File** | `lib/data/api/services/auth_api_service.dart` |
| **Repository File** | `lib/data/repositories/auth_repository.dart` |
| **State Management** | `auth_cubit.dart` (AuthCubit) |
| **HTTP Method** | POST |
| **Requires Auth** | ✅ Yes (Bearer token) |
| **Request Body** | JSON (optional: device_id, all_devices flag) |
| **Response** | success message, logout confirmation |

**Usage Scenario:**

Context 1: Logout from Current Device
```
1. User on ProfileScreen
2. Taps "Logout" or "Sign Out" button
3. Shows confirmation dialog: "Are you sure you want to logout?"
4. User taps "Yes"
5. Calls AuthCubit.logout()
6. Call AuthRepository.logout()
7. API makes POST to /auth/logout
8. Show loading spinner while processing
9. On success:
   - Server revokes tokens
   - Clear all local storage (tokens, user data, cached data)
   - Clear SharedPreferences / Hive boxes
   - Clear image cache
   - Emit AuthUnauthenticatedState
   - Navigator.pushReplacementNamed('login')
   - Show message: "Logged out successfully"
10. On failure:
    - Show error dialog
    - Offer retry option
    - OR silently clear local tokens and navigate (fallback)
```

Context 2: Logout from All Devices
```
1. User in Security Settings
2. Taps "Logout from all devices"
3. Shows confirmation: "This will log you out from all devices"
4. User confirms
5. Calls AuthCubit.logoutAllDevices()
6. API makes POST to /auth/logout with all_devices=true
7. Server revokes ALL refresh_tokens for user
8. User logged out from all devices
9. Same as Context 1, but affects all devices
```

Context 3: Automatic Logout (Inactivity Timeout)
```
1. App running in foreground
2. User hasn't interacted with app for 60 minutes
3. AppLifecycleListener detects user inactivity
4. Automatically calls AuthCubit.logout()
5. No user interaction needed
6. User sees "Session timed out" when app opened
7. Show login screen
```

**Request Format:**
```
Content-Type: application/json
Authorization: Bearer {access_token}

{
  "all_devices": false,
  "device_id": "device_123" (optional)
}
```

OR for logout all:
```
{
  "all_devices": true
}
```

**Response Format:**
```
{
  "success": true,
  "data": {
    "message": "Logged out successfully",
    "logout_timestamp": "2026-04-30T10:35:00Z",
    "devices_affected": 1
  },
  "timestamp": "2026-04-30T10:35:00Z"
}
```

**State Management Flow:**
```
User taps "Logout"
    ↓
Show confirmation dialog
    ↓
User confirms
    ↓
AuthLoadingState (show loading spinner)
    ↓
API call to /auth/logout
    ↓
Success: 
  - Clear all local data
  - Emit AuthUnauthenticatedState
  - Navigate to LoginScreen
Failure:
  - Show error dialog
  - Option to retry or force logout (clear locally)
```

**Decision Points:**
- Ask for confirmation before logout
- Should also support "Logout from all devices" option
- Clear all cached data (not just tokens)
- Handle network errors gracefully
- Can proceed with local logout even if API call fails
- Show success message briefly before navigating

---

---

## 🌐 AUTH FLOW DIAGRAMS

---

### Flow 1: LOGIN FLOW

```
START: App Startup
  ↓
  ├─ SplashScreen
  │  ├─ Check local storage for access_token
  │  │
  │  ├─ Token found:
  │  │  ├─ Call /auth/me to validate
  │  │  ├─ Success: Get user object
  │  │  │  └─ Navigate based on role
  │  │  └─ Fail: Try refresh token
  │  │     └─ If refresh fails: Go to LoginScreen
  │  │
  │  └─ No token found:
  │     └─ Navigate to LoginScreen
  ↓
  LoginScreen
  ├─ User enters email & password
  ├─ Taps "Login" button
  │
  ├─ API Call: POST /auth/login
  ├─ Response:
  │  ├─ access_token
  │  ├─ refresh_token
  │  └─ user role (donor/hospital/admin)
  │
  ├─ Check if phone_verified:
  │  ├─ If false:
  │  │  ├─ Save tokens
  │  │  └─ Navigate to SendOtpScreen
  │  │     └─ User verifies phone
  │  │        └─ Navigate to role-based home
  │  │
  │  └─ If true:
  │     ├─ Check if 2fa_enabled:
  │     │  ├─ If true:
  │     │  │  └─ Navigate to TwoFactorVerificationScreen
  │     │  │     ├─ User enters 2FA code
  │     │  │     ├─ API Call: POST /auth/2fa/verify
  │     │  │     └─ Success: Navigate to role-based home
  │     │  │
  │     │  └─ If false:
  │     │     ├─ Save tokens to local storage
  │     │     ├─ Save user object
  │     │     └─ Navigate to role-based home
  │     │        ├─ If role="donor": DonorHomeScreen
  │     │        ├─ If role="hospital": HospitalHomeScreen
  │     │        └─ If role="admin": AdminHomeScreen
  ↓
END
```

---

### Flow 2: SIGNUP + PHONE VERIFICATION FLOW

```
START: LoginScreen
  ↓
  User taps "Sign Up" link
  ↓
  SignupScreen (Multi-step form)
  │
  Step 1: Select Role
  ├─ Options: Donor, Hospital, Admin
  └─ User selects role
  
  Step 2: Basic Info
  ├─ Email field
  ├─ Full Name field
  ├─ Phone field
  └─ Validation
  
  Step 3: Create Password
  ├─ Password field
  ├─ Confirm password field
  ├─ Strength indicator
  └─ Requirements shown
  
  Step 4: Terms & Conditions
  ├─ Show T&C
  ├─ Show privacy policy
  └─ Checkbox to accept
  
  Step 5: Create Account
  └─ User taps "Create Account"
  ↓
  API Call: POST /auth/register
  ├─ Request body:
  │  ├─ email
  │  ├─ password
  │  ├─ full_name
  │  ├─ phone
  │  ├─ role
  │  └─ terms_accepted=true
  │
  └─ Response:
     ├─ user_id
     ├─ email
     ├─ phone_verified=false
     └─ message: "Account created"
  ↓
  Handle Response
  ├─ If error:
  │  ├─ Show error message (email exists, weak password, etc.)
  │  └─ Allow user to retry
  │
  └─ If success:
     ├─ Show "Account created successfully"
     ├─ Auto-dispatch SendOtpEvent
     └─ Navigate to SendOtpScreen
  ↓
  SendOtpScreen
  ├─ Message: "We've sent a code to +92-300-****567"
  ├─ Show OTP input field
  ├─ Show "Resend Code" button (initially disabled)
  └─ Show countdown timer (30s before resend available)
  ↓
  User receives SMS with OTP code
  ├─ Example: 123456
  └─ Or user taps "Resend Code"
     └─ API Call: POST /auth/send-otp
        └─ (Same endpoint, resend flag)
  ↓
  User enters OTP
  ├─ Shows 6 input fields
  ├─ Auto-focus next field
  └─ Auto-submit when all 6 digits entered
  ↓
  API Call: POST /auth/verify-otp
  ├─ Request:
  │  ├─ otp_id
  │  └─ otp_code
  │
  └─ Response:
     ├─ access_token
     ├─ refresh_token
     ├─ phone_verified=true
     └─ user role
  ↓
  Handle Response
  ├─ If error:
  │  ├─ Show "Invalid OTP"
  │  ├─ Show remaining attempts
  │  └─ Allow retry or resend
  │
  └─ If success:
     ├─ Save tokens to local storage
     ├─ Show "Phone verified successfully"
     ├─ Emit AuthenticatedState
     └─ Navigate to role-based home
        ├─ If role="donor": DonorHomeScreen
        ├─ If role="hospital": HospitalHomeScreen
        └─ If role="admin": AdminHomeScreen
  ↓
END
```

---

### Flow 3: PASSWORD RESET FLOW

```
START: LoginScreen
  ↓
  User taps "Forgot Password?" link
  ↓
  ForgotPasswordScreen
  ├─ Enter email field
  └─ Taps "Send Reset Code"
  ↓
  API Call: POST /auth/send-otp
  ├─ Request:
  │  ├─ email: user@example.com
  │  └─ context: "password_reset"
  │
  └─ Response:
     ├─ otp_id
     ├─ masked_email: us**@example.com
     └─ message: "Code sent to email"
  ↓
  Show OTP Input Screen
  ├─ Message: "Enter code sent to us**@example.com"
  ├─ 6 input fields for OTP
  ├─ "Resend Code" button (30s cooldown)
  └─ Countdown timer
  ↓
  User checks email, gets OTP code
  ├─ Example: 654321
  └─ Or taps "Resend Code"
  ↓
  User enters OTP code
  ↓
  API Call: POST /auth/verify-otp
  ├─ Request:
  │  ├─ otp_id
  │  └─ otp_code
  │
  └─ Response:
     └─ verification_token (temp token)
  ↓
  On Success:
  ├─ Emit PasswordResetOtpVerifiedState
  └─ Navigate to NewPasswordScreen
  ↓
  NewPasswordScreen
  ├─ New Password field
  ├─ Confirm Password field
  ├─ Password strength indicator
  └─ Taps "Reset Password" button
  ↓
  API Call: POST /auth/reset-password
  ├─ Request:
  │  ├─ verification_token
  │  ├─ new_password
  │  └─ confirm_password
  │
  └─ Response:
     ├─ email
     ├─ message: "Password reset successfully"
     └─ suggestion: "Please login with new password"
  ↓
  On Success:
  ├─ Show "Password reset successfully"
  ├─ Navigate back to LoginScreen
  └─ User can now login with new password
  ↓
  On Failure:
  ├─ Show error message
  └─ Allow retry
  ↓
END
```

---

### Flow 4: 2FA SETUP FLOW

```
START: ProfileScreen / SecuritySettings
  ↓
  User taps "Enable Two-Factor Authentication"
  ↓
  TwoFactorSetupScreen
  ├─ Show 3 methods:
  │  ├─ Google Authenticator
  │  ├─ SMS Code
  │  └─ Email Code
  │
  └─ User selects "Google Authenticator"
  ↓
  API Call: POST /auth/2fa/setup
  ├─ Request:
  │  └─ method: "authenticator"
  │
  └─ Response:
     ├─ qr_code_url (base64 image)
     ├─ secret_key (for manual entry)
     └─ backup_codes (10 one-time codes)
  ↓
  Show QR Code Screen
  ├─ Display QR code image
  ├─ Show manual entry key below
  ├─ Instructions: "Scan with Authenticator app"
  ├─ Backup codes displayed
  │  ├─ "Save these codes in safe place"
  │  ├─ Copy button
  │  ├─ Download as PDF button
  │  └─ Checkbox: "I've saved my backup codes"
  │
  └─ "Next: Verify Code" button (disabled until checkbox checked)
  ↓
  User opens Google Authenticator app
  ├─ Scans QR code with camera
  ├─ App shows: "Add account?"
  └─ User confirms → app shows 6-digit code (refreshes every 30s)
  ↓
  User sees code in Authenticator (e.g., 345678)
  ↓
  User enters code in app
  ├─ 6 input fields
  └─ Returns to TwoFactorSetupScreen with code entered
  ↓
  User taps "Verify & Enable" button
  ↓
  API Call: POST /auth/2fa/verify
  ├─ Request:
  │  ├─ 2fa_id
  │  └─ code: "345678"
  │
  └─ Response:
     ├─ 2fa_verified: true
     ├─ 2fa_enabled: true
     └─ message: "2FA enabled successfully"
  ↓
  On Success:
  ├─ Show success toast: "2FA enabled!"
  ├─ Show backup codes one more time with save reminder
  └─ Navigate back to Security Settings
     └─ Show "2FA: ENABLED" with disable option
  ↓
  On Failure:
  ├─ Show error: "Invalid code"
  ├─ Show attempts remaining
  └─ Allow retry or go back to rescan QR
  ↓
END
```

---

### Flow 5: 2FA LOGIN FLOW

```
START: LoginScreen with 2FA enabled user
  ↓
  User enters email & password
  ↓
  API Call: POST /auth/login
  ├─ Response:
  │  ├─ success: true
  │  ├─ 2fa_enabled: true
  │  ├─ temporary_token (short expiry, limited scope)
  │  └─ No access_token yet
  ↓
  App checks 2fa_enabled flag
  ├─ If true:
  │  ├─ Save temporary_token
  │  └─ Navigate to TwoFactorVerificationScreen
  │
  └─ If false:
     ├─ Save access_token & refresh_token
     └─ Navigate to home
  ↓
  TwoFactorVerificationScreen
  ├─ Message: "Enter 6-digit code from Authenticator"
  ├─ 6 input fields
  ├─ "Use Backup Code?" link
  └─ Resend option (if SMS-based 2FA)
  ↓
  User opens Authenticator app
  ├─ Finds account
  └─ Sees 6-digit code (e.g., 456789)
  ↓
  User enters 456789 in app
  ↓
  API Call: POST /auth/2fa/verify
  ├─ Request:
  │  ├─ 2fa_id (from setup)
  │  ├─ code: "456789"
  │  └─ Authorization: Bearer {temporary_token}
  │
  └─ Response:
     ├─ access_token (permanent)
     ├─ refresh_token
     └─ user role
  ↓
  On Success:
  ├─ Save access_token & refresh_token
  ├─ Show "2FA verified successfully"
  ├─ Emit AuthenticatedState
  └─ Navigate to role-based home
  ↓
  On Failure (invalid code):
  ├─ Show "Invalid code"
  ├─ Show attempts remaining
  └─ Allow retry or "Use Backup Code?"
  ↓
  User taps "Use Backup Code?"
  ├─ Show text field to enter backup code
  ├─ Format: XXXX-XXXX
  └─ User enters saved backup code (e.g., 65AZ-4QXE)
  ↓
  API Call: POST /auth/2fa/verify
  ├─ Request:
  │  ├─ 2fa_id
  │  ├─ backup_code: "65AZ-4QXE"
  │  └─ Authorization: Bearer {temporary_token}
  │
  └─ Response:
     ├─ access_token
     ├─ refresh_token
     └─ warning: "9 backup codes remaining, regenerate soon"
  ↓
  On Success:
  ├─ Save tokens
  ├─ Show warning about remaining codes
  └─ Navigate to role-based home
  └─ Remind user to regenerate backup codes in settings
  ↓
END
```

---

---

## 📱 REQUIRED SCREENS

---

### Screen 1: LoginScreen
**Purpose:** User login with email/password

**Components:**
- Email input field
- Password input field (with show/hide toggle)
- "Login" button (enable only when email & password filled)
- "Forgot Password?" link
- "Sign Up" link
- Social login buttons (optional)
- Loading indicator (on API call)
- Error message display
- Terms of service link (optional)

**State Management:** AuthCubit

**Navigation:**
- Success → OtpVerificationScreen (if phone unverified)
  OR TwoFactorVerificationScreen (if 2FA enabled)
  OR role-based home (normal case)
- "Forgot Password?" → ForgotPasswordScreen
- "Sign Up" → SignupScreen

---

### Screen 2: SignupScreen
**Purpose:** Create new user account with role selection

**Components:**
- Multi-step form (Step indicator: 1/5, 2/5, etc.)

**Step 1: Select Role**
- Radio buttons: Donor / Hospital / Admin
- Description for each role
- "Next" button

**Step 2: Basic Information**
- Full Name input field
- Email input field
- Phone input field
- "Next" button
- "Back" button

**Step 3: Create Password**
- Password input field (with requirements shown)
- Confirm Password input field
- Password strength meter
- Show/hide toggle
- "Next" button
- "Back" button

**Step 4: Terms & Conditions**
- ScrollView with T&C text
- Checkbox: "I agree to terms & conditions"
- Checkbox: "I agree to privacy policy"
- "Create Account" button (enable only if both checked)
- "Back" button

**Step 5: Account Created (Success state)**
- Success icon/animation
- Message: "Account created successfully!"
- Message: "Verify your phone to continue"
- Loading indicator (auto-navigating to OTP screen)

**State Management:** AuthCubit (for signup) + SignupFormCubit (for step management)

**Navigation:**
- Success → SendOtpScreen (auto-navigate with animation)
- "Back" buttons navigate between steps
- Cancel → LoginScreen

---

### Screen 3: SendOtpScreen
**Purpose:** Display phone number and prompt for OTP (used in signup and password reset)

**Components:**
- Message: "We've sent a code to +92-300-****567"
- Resend Information: "Resend code in 30s"
- Countdown timer (30s → "Resend Code" button enabled)
- "Resend Code" button (initially disabled)
- OTP Input fields (6 separate boxes, auto-focus next)
- "Verify" button
- Loading indicator
- Error message display
- "Change number?" link (optional)

**State Management:** OtpCubit or AuthCubit

**Navigation:**
- OTP entered correctly → OtpVerificationScreen (same screen or next)
- "Resend Code" → resend OTP API call
- Show countdown timer
- After 5 minutes, show "OTP expired, request new code"

---

### Screen 4: OtpVerificationScreen
**Purpose:** Verify OTP code entered by user

**Components:**
- 6 input fields for OTP digits
- Auto-focus between fields
- Keyboard type: numeric only
- Paste functionality (if user pastes full OTP)
- "Verify" button (enable only when 6 digits entered)
- "Resend Code" link (shows countdown timer)
- Remaining attempts counter (e.g., "4 attempts remaining")
- Error message display
- Loading indicator

**State Management:** OtpCubit or AuthCubit

**Navigation:**
- On success (signup flow) → role-based home with tokens saved
- On success (password reset flow) → NewPasswordScreen
- On success (phone verification after login) → previous screen
- On failure → show error, allow retry

---

### Screen 5: ForgotPasswordScreen
**Purpose:** Initiate password reset flow

**Components:**
- Title: "Reset Password"
- Subtitle: "Enter email to receive reset code"
- Email input field
- "Send Reset Code" button
- "Back to Login" link
- Loading indicator
- Error message display

**State Management:** PasswordResetCubit

**Navigation:**
- "Send Reset Code" → SendOtpScreen (email context)
- User receives OTP email
- "Back to Login" → LoginScreen

---

### Screen 6: NewPasswordScreen
**Purpose:** Set new password after OTP verification

**Components:**
- Title: "Create New Password"
- New Password field (with requirements shown)
- Confirm Password field
- Password strength indicator
- Show/hide toggle
- "Reset Password" button
- Error message display
- Loading indicator

**State Management:** PasswordResetCubit

**Navigation:**
- Success → show "Password reset successfully"
- Show countdown (3s)
- Auto-navigate → LoginScreen
- Error → show message, allow retry

---

### Screen 7: TwoFactorSetupScreen
**Purpose:** Enable 2FA on user account

**Components:**
- Title: "Enable Two-Factor Authentication"
- 3 method options:
  - Option 1: Google Authenticator
  - Option 2: SMS Code
  - Option 3: Email Code
- Selection UI (radio buttons or cards)
- "Set Up" button
- "Skip for Now" button (optional)

**After Selection:**
- QR code image (for authenticator method)
- Manual entry key (for backup if camera fails)
- "Open Authenticator App" button (intent to open app)
- Instructions text
- Backup codes display (10 one-time codes)
- Buttons: Copy, Download as PDF
- Checkbox: "I've saved my backup codes"
- "Verify Code" button (enabled when checkbox checked)
- Countdown timer (10 minutes to complete setup)

**State Management:** TwoFactorCubit

**Navigation:**
- "Set Up" → TwoFactorSetupScreen (show QR code)
- "Verify Code" → TwoFactorVerificationScreen (verify 2FA code)
- Success → Security Settings with "2FA: ENABLED" indicator
- Skip → ProfileScreen

---

### Screen 8: TwoFactorVerificationScreen
**Purpose:** Verify 2FA code during setup or login

**Components (During Setup):**
- Title: "Verify Code from Authenticator"
- Message: "Enter the 6-digit code shown in app"
- 6 input fields for OTP
- Auto-focus between fields
- Keyboard type: numeric
- "Verify" button
- "Use Backup Code?" link
- Remaining attempts counter
- Error message display
- "Rescan QR Code" link

**Components (During Login):**
- Title: "Two-Factor Verification"
- Message: "Enter 6-digit code from Authenticator"
- 6 input fields for OTP
- "Use Backup Code?" link
- "Resend Code?" link (if SMS-based)
- Error message display
- Loading indicator

**Components (Using Backup Code):**
- TextField for backup code entry (format: XXXX-XXXX)
- "Use this code" button
- Warning: "Each backup code can only be used once"
- "Use Authenticator instead?" link

**State Management:** TwoFactorCubit or AuthCubit

**Navigation:**
- On success (setup) → Security Settings with success message
- On success (login) → role-based home with tokens saved
- "Use Backup Code?" → show backup code input field
- Error → show message, allow retry
- Exceeded attempts → show "Too many attempts, try again later"

---

### Screen 9: SplashScreen
**Purpose:** App startup, validate session, navigate to appropriate screen

**Components:**
- App logo
- Loading spinner
- No user interaction

**Logic:**
```
1. Check local storage for access_token
2. If found:
   - Call /auth/me (or /auth/validate-token)
   - If valid: Navigate to role-based home
   - If expired: Try refresh-token
   - If invalid: Navigate to LoginScreen
3. If not found:
   - Navigate to LoginScreen
```

**State Management:** AuthCubit

**Navigation:**
- Token valid → DonorHomeScreen / HospitalHomeScreen / AdminHomeScreen
- Token invalid/expired → LoginScreen
- Duration: 2-3 seconds (minimum to appear polished)

---

---

## 📂 FILE STRUCTURE FOR AUTH MODULE

---

### Recommended Directory Structure

```
lib/
├── data/
│   ├── api/
│   │   ├── services/
│   │   │   └── auth_api_service.dart          # Auth API calls
│   │   │
│   │   └── models/
│   │       ├── auth_request_model.dart
│   │       └── auth_response_model.dart
│   │
│   ├── repositories/
│   │   └── auth_repository.dart               # Auth data layer
│   │
│   ├── local/
│   │   ├── auth_local_storage.dart            # Token storage
│   │   └── preferences/
│   │       └── auth_preferences.dart
│   │
│   └── models/
│       ├── user_model.dart
│       ├── login_request.dart
│       ├── signup_request.dart
│       ├── otp_request.dart
│       └── token_response.dart
│
├── domain/
│   ├── entities/
│   │   ├── user.dart
│   │   ├── auth_token.dart
│   │   └── otp_session.dart
│   │
│   └── usecases/
│       ├── login_usecase.dart
│       ├── signup_usecase.dart
│       ├── verify_otp_usecase.dart
│       ├── refresh_token_usecase.dart
│       └── logout_usecase.dart
│
├── presentation/
│   ├── cubits/
│   │   ├── auth_cubit.dart                    # Main auth logic
│   │   ├── auth_state.dart
│   │   ├── otp_cubit.dart                     # OTP logic
│   │   ├── otp_state.dart
│   │   ├── password_reset_cubit.dart
│   │   ├── password_reset_state.dart
│   │   ├── two_factor_cubit.dart
│   │   └── two_factor_state.dart
│   │
│   ├── screens/
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── login/
│   │   │   ├── login_screen.dart
│   │   │   └── widgets/
│   │   │       ├── login_form.dart
│   │   │       ├── email_input.dart
│   │   │       └── password_input.dart
│   │   ├── signup/
│   │   │   ├── signup_screen.dart
│   │   │   └── widgets/
│   │   │       ├── role_selection.dart
│   │   │       ├── basic_info_form.dart
│   │   │       ├── password_form.dart
│   │   │       └── terms_agreement.dart
│   │   ├── otp/
│   │   │   ├── send_otp_screen.dart
│   │   │   ├── otp_verification_screen.dart
│   │   │   └── widgets/
│   │   │       ├── otp_input.dart
│   │   │       └── otp_timer.dart
│   │   ├── forgot_password/
│   │   │   ├── forgot_password_screen.dart
│   │   │   ├── new_password_screen.dart
│   │   │   └── widgets/
│   │   │       └── password_form.dart
│   │   ├── two_factor/
│   │   │   ├── two_factor_setup_screen.dart
│   │   │   ├── two_factor_verification_screen.dart
│   │   │   └── widgets/
│   │   │       ├── qr_code_display.dart
│   │   │       ├── backup_codes_display.dart
│   │   │       ├── otp_input.dart
│   │   │       └── backup_code_input.dart
│   │   └── common/
│   │       └── auth_error_dialog.dart
│   │
│   └── widgets/
│       ├── auth_app_bar.dart
│       ├── auth_button.dart
│       ├── auth_input_field.dart
│       ├── loading_overlay.dart
│       └── success_message.dart
│
└── core/
    ├── constants/
    │   ├── auth_constants.dart
    │   └── api_endpoints.dart
    │
    ├── interceptors/
    │   ├── http_interceptor.dart            # Handle 401 + refresh token
    │   ├── logging_interceptor.dart
    │   └── error_interceptor.dart
    │
    └── utils/
        ├── secure_storage.dart              # Encrypted token storage
        ├── token_manager.dart               # Token refresh logic
        └── app_lifecycle_listener.dart      # Inactivity timeout

```

---

## 🏗️ KEY ARCHITECTURAL COMPONENTS

---

### Component 1: AuthApiService
**Responsibility:** Make HTTP calls to auth endpoints

**Methods:**
```
- login(email, password)
- register(email, password, fullName, phone, role)
- sendOtp(phone/email, context)
- verifyOtp(otpId, otpCode)
- setup2FA(method)
- verify2FA(2faId, code)
- refreshToken(refreshToken)
- logout(allDevices)
- getCurrentUser()
- validateToken()
```

**Pattern:** Singleton or injected via service locator

---

### Component 2: AuthRepository
**Responsibility:** Data layer combining API + local storage

**Methods:**
```
- login()
- register()
- sendOtp()
- verifyOtp()
- setup2FA()
- verify2FA()
- refreshToken()
- logout()
- getCurrentUser()
- isLoggedIn()
- getAccessToken()
- getRefreshToken()
- saveTokens()
- clearTokens()
```

---

### Component 3: AuthCubit
**Responsibility:** State management for authentication

**States:**
```
- AuthInitialState
- AuthLoadingState
- AuthenticatedState(user, tokens)
- AuthUnauthenticatedState
- AuthErrorState(errorMessage)
- RegistrationSuccessState
- RegistrationErrorState
```

**Events:**
```
- AppStartedEvent (check token on startup)
- LoginEvent(email, password)
- SignupEvent(...)
- LogoutEvent
- UpdateUserEvent
- RefreshTokenEvent
- ClearAuthEvent
```

---

### Component 4: OtpCubit
**Responsibility:** State management for OTP verification

**States:**
```
- OtpInitialState
- SendingOtpState
- OtpSentState
- VerifyingOtpState
- OtpVerifiedState
- OtpErrorState
- OtpExpiredState
```

---

### Component 5: TwoFactorCubit
**Responsibility:** State management for 2FA

**States:**
```
- TwoFactorInitialState
- TwoFactorSetupState
- TwoFactorSetupSuccessState
- VerifyingTwoFactorState
- TwoFactorVerifiedState
- TwoFactorErrorState
```

---

### Component 6: SecureStorage
**Responsibility:** Encrypted storage for tokens

**Uses:** flutter_secure_storage or similar

**Stores:**
```
- access_token (encrypted)
- refresh_token (encrypted)
- user role (encrypted)
- user_id (encrypted)
- device_id
```

---

### Component 7: HttpInterceptor
**Responsibility:** Automatic token refresh on 401

**Logic:**
```
If response code = 401:
  → Check if endpoint is refresh-token or login
  → If not, call refreshToken()
  → If success: retry original request with new token
  → If failure: clear tokens, navigate to login
```

---

### Component 8: TokenManager
**Responsibility:** Handle token expiry and refresh logic

**Methods:**
```
- isTokenExpired()
- shouldRefreshToken()
- refreshToken()
- getTokenExpiryTime()
- startExpiryTimer()
- proactiveRefresh()
```

---

---

## 🔑 KEY DECISIONS & PATTERNS

---

### Decision 1: Token Storage
**Option A:** Shared Preferences (❌ NOT SECURE)
**Option B:** Flutter Secure Storage (✅ RECOMMENDED)
**Option C:** Hive Encrypted Box (✅ ALSO GOOD)

**Recommendation:** Use Flutter Secure Storage for tokens, Hive for other user data

---

### Decision 2: Automatic Token Refresh
**Pattern:** HTTP Interceptor

**Flow:**
```
API Call
  ↓
Check response code
  ↓
401 Unauthorized?
  ↓
Is endpoint /auth/refresh-token or /auth/login?
  ├─ Yes: Return error to user
  └─ No: Refresh token
      ↓
      Success? Retry original request
      Failure? Clear tokens, navigate to login
```

---

### Decision 3: Phone Verification After Signup
**Pattern:** Immediate OTP send + verification

**Flow:**
```
Signup Success
  ↓
Auto-emit SendOtpEvent
  ↓
Show SendOtpScreen
  ↓
User enters OTP
  ↓
Success: Save tokens, navigate to home
Failure: Show error, allow retry
```

---

### Decision 4: 2FA During Login
**Pattern:** Temporary token + 2FA verification

**Flow:**
```
Login Success (2FA enabled)
  ↓
Return temporary_token (short expiry)
  ↓
Navigate to TwoFactorVerificationScreen
  ↓
User enters 2FA code or backup code
  ↓
Verify 2FA with temporary_token
  ↓
Success: Return permanent tokens
Failure: Show error, allow retry
```

---

### Decision 5: Session Timeout
**Pattern:** App lifecycle listener + inactivity timer

**Logic:**
```
App enters background
  ↓
Start 60-minute inactivity timer
  
App enters foreground
  ↓
If > 60 minutes elapsed:
  ├─ Clear tokens
  ├─ Navigate to login
  └─ Show "Session expired"
  
If < 60 minutes:
  └─ Continue normally
```

---

### Decision 6: Role-Based Navigation
**Pattern:** Conditional navigation after login

**Logic:**
```
Login Success
  ↓
Get user.role from response
  ↓
If role="donor":
  → Navigator.pushReplacementNamed('donor_home')
If role="hospital":
  → Navigator.pushReplacementNamed('hospital_home')
If role="admin":
  → Navigator.pushReplacementNamed('admin_home')
```

---

### Decision 7: Error Handling
**Pattern:** Custom exception classes

**Classes:**
```
- AuthException (base)
  ├─ InvalidCredentialsException
  ├─ UserAlreadyExistsException
  ├─ OtpExpiredException
  ├─ InvalidOtpException
  ├─ TokenExpiredException
  ├─ UnauthorizedException
  └─ NetworkException
```

---

---

## 📊 STATE MANAGEMENT FLOW SUMMARY

---

### AuthCubit States (Complete)

```
START: AuthInitialState
  ├─ App launched
  └─ No authentication action yet

User taps "Login" button
  ├─ Emit: AuthLoadingState
  └─ API Call /auth/login

API Response:
  ├─ Success:
  │  ├─ Save tokens + user data
  │  └─ Emit: AuthenticatedState
  │
  └─ Failure:
     └─ Emit: AuthErrorState

From AuthenticatedState:
  ├─ User taps logout
  │  ├─ API call /auth/logout
  │  └─ Emit: AuthUnauthenticatedState
  │
  └─ App startup with valid token
     └─ Stay in AuthenticatedState

From AuthUnauthenticatedState:
  └─ Navigate to LoginScreen
```

---

## 🎯 Integration Checklist

---

```
[ ] Set up HTTP client with interceptors
[ ] Create SecureStorage wrapper
[ ] Create TokenManager for token refresh
[ ] Create AuthApiService with all 8 endpoints
[ ] Create AuthRepository wrapping API + storage
[ ] Create AuthCubit with login/signup/logout logic
[ ] Create OtpCubit for OTP handling
[ ] Create PasswordResetCubit for password recovery
[ ] Create TwoFactorCubit for 2FA logic
[ ] Create SplashScreen with token validation
[ ] Create LoginScreen with form validation
[ ] Create SignupScreen with multi-step form
[ ] Create OtpVerificationScreen with countdown
[ ] Create ForgotPasswordScreen with flow
[ ] Create TwoFactorSetupScreen with QR code
[ ] Create TwoFactorVerificationScreen
[ ] Set up HTTP interceptor for 401 handling
[ ] Set up app lifecycle listener for inactivity
[ ] Configure secure storage encryption
[ ] Set up service locator (GetIt, Riverpod, etc.)
[ ] Create custom exception classes
[ ] Create auth guard/middleware for protected routes
[ ] Test all 8 endpoints
[ ] Test token refresh flow
[ ] Test 2FA setup and verification
[ ] Test logout from all devices
[ ] Test session timeout
[ ] Test error scenarios
[ ] Test slow network scenarios
[ ] Document all failures and error codes
```

---

## 📈 Performance Considerations

---

### API Call Optimization
- **Login:** < 500ms
- **OTP Send:** < 1s (SMS/Email depends on provider)
- **OTP Verify:** < 500ms
- **Token Refresh:** < 300ms
- **Logout:** < 500ms

### Local Storage
- **Token retrieval:** < 10ms
- **Token encryption/decryption:** < 50ms
- **User object save:** < 50ms

### UI Responsiveness
- **Loading states:** Always show within 200ms
- **Error display:** Immediate
- **Navigation:** < 300ms

---

## 🔒 Security Best Practices

---

```
✅ Use HTTPS only
✅ Store tokens in secure storage (encrypted)
✅ Don't log tokens or sensitive data
✅ Implement certificate pinning (optional)
✅ Validate token signature on client
✅ Implement rate limiting on login attempts
✅ Don't hardcode API keys
✅ Use refresh tokens for long sessions
✅ Implement CSRF protection
✅ Clear all data on logout
✅ Handle token expiration gracefully
✅ Don't send tokens in URL params
✅ Use SameSite cookie attribute
✅ Implement 2FA for additional security
✅ Validate all user inputs before sending to API
```

---

## ✅ SUMMARY

---

| Aspect | Count |
|--------|-------|
| **Endpoints** | 10 (login, register, send-otp, verify-otp, 2fa/setup, 2fa/verify, refresh-token, logout, validate-token, password-reset) |
| **Screens** | 9 (splash, login, signup, send-otp, otp-verify, forgot-password, new-password, 2fa-setup, 2fa-verify) |
| **Cubits** | 4 (auth_cubit, otp_cubit, password_reset_cubit, two_factor_cubit) |
| **API Services** | 1 (auth_api_service handling all 10 endpoints) |
| **Repositories** | 1 (auth_repository) |
| **Key Components** | SecureStorage, TokenManager, HttpInterceptor, AppLifecycleListener |
| **Estimated Implementation Time** | 4-5 days (experienced developer) |
| **Complexity** | HIGH (due to 2FA, OTP, token management) |

---

**Report Status:** ✅ COMPLETE  
**Date:** April 30, 2026  
**Intended For:** Senior Flutter Architects & Tech Leads


