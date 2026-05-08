# 🔔 DONOR NOTIFICATION SCENARIOS - COMPLETE GUIDE

**Document Version:** 1.0  
**Last Updated:** May 2, 2026  
**Status:** Architecture & Specifications Only

---

## 📋 TABLE OF CONTENTS

1. [Notification Types](#notification-types)
2. [Complete Notification Scenarios](#complete-notification-scenarios)
3. [Notification Flow Diagram](#notification-flow-diagram)
4. [Priority & Urgency Levels](#priority--urgency-levels)
5. [Trigger Events](#trigger-events)
6. [Backend Requirements](#backend-requirements)
7. [Data Model](#data-model)
8. [Integration Points](#integration-points)

---

## 🔔 NOTIFICATION TYPES

### 1. **EMERGENCY** - Red Priority
**Purpose:** Time-sensitive blood requests requiring immediate action

**Visual:**
- Red badge / Red notification UI
- Urgent sound/vibration
- Top of notification list
- Auto-expand on notification view

**Characteristics:**
- Requires quick response
- Expires within hours
- Affects patient safety
- Geolocation-based

---

### 2. **APPOINTMENT** - Blue Priority
**Purpose:** Donation appointment reminders and confirmations

**Visual:**
- Blue badge / Calendar icon
- Normal notification sound
- Expandable with appointment details

**Characteristics:**
- Time-based trigger
- User-initiated flow
- Requires confirmation
- Can be rescheduled

---

### 3. **REWARD** - Gold Priority
**Purpose:** Points earned, badges unlocked, rewards available

**Visual:**
- Gold/Yellow badge / Trophy icon
- Positive sound
- Shows point amount

**Characteristics:**
- Motivational
- Non-urgent
- Drives engagement
- Clickable to rewards screen

---

### 4. **ACHIEVEMENT** - Purple Priority
**Purpose:** Milestones, badges, donor status updates

**Visual:**
- Purple badge / Star icon
- Celebration sound
- Shows achievement name

**Characteristics:**
- Motivational
- Milestone-based
- Non-urgent
- Social recognition

---

### 5. **SYSTEM** - Gray Priority
**Purpose:** Account updates, profile changes, general information

**Visual:**
- Gray badge / Info icon
- Quiet notification
- Grouped with other system notifications

**Characteristics:**
- Informational
- Non-urgent
- No action required
- Auto-archived after read

---

### 6. **HOSPITAL** - Green Priority
**Purpose:** Messages from hospitals, donation requests specific to donor

**Visual:**
- Green badge / Hospital icon
- Normal notification sound
- Shows hospital name

**Characteristics:**
- Hospital-initiated
- Personalized
- May require response
- Shows hospital context

---

---

## 📍 COMPLETE NOTIFICATION SCENARIOS

---

## **CATEGORY 1: EMERGENCY BLOOD REQUEST SCENARIOS**

### Scenario 1.1: Emergency Request Matches Donor's Blood Type
**Trigger Event:** Hospital creates emergency request → Blood type matches donor's → Donor is eligible

**Notification Details:**
```
Type:        EMERGENCY
Title:       "🚨 Emergency O+ Blood Request!"
Subtitle:    "City Hospital needs O+ urgently, 2.3 km away"
Time:        Current timestamp
Priority:   CRITICAL
Sound:       Loud siren/urgent tone
Vibration:   Pattern (urgent)
Icon:        Red ambulance
Action:      "Respond Now" button
Data:        {
  request_id: "req_123",
  blood_type: "O+",
  units_needed: 3,
  hospital_id: "hosp_456",
  hospital_name: "City Hospital",
  location: {lat, lng},
  distance: 2.3,
  urgency: "critical"
}
```

**When it triggers:**
- Hospital creates emergency request with urgency='critical'
- Blood type matches donor's blood type
- Donor is geographically nearby (within 5 km)
- Donor is eligible to donate (not donation_restricted)
- Donor has push notifications enabled

**What donor sees:**
- Modal dialog appears (if app is open)
- Notification badge shows red alert
- Sound + vibration plays
- "Respond Now" button opens request details

**Donor actions available:**
- **Accept** - "I can help" → Triggers hospital notification
- **Decline** - "Not available" → Removes notification
- **View Details** - See full request info
- **Share** - Send to contacts

**Follow-up behavior:**
- Stays at top of notification list
- Expires after 24 hours
- Auto-removes if request is fulfilled

---

### Scenario 1.2: Request Status Updates
**Trigger Event:** Emergency request status changes

#### **1.2.1 - Request Fulfilled**
```
Type:        EMERGENCY → CLOSED
Title:       "Blood Request Fulfilled"
Subtitle:    "The O+ blood request at City Hospital has been completed"
Data:        {unit_count: 3, timestamp}
```

**When it triggers:**
- When hospital closes the request
- Hospital has received enough blood units

**Purpose:** Inform donors who accepted that help is no longer needed

---

#### **1.2.2 - Request Cancelled**
```
Type:        EMERGENCY
Title:       "Request Cancelled"
Subtitle:    "The emergency blood request has been cancelled"
Data:        {cancellation_reason}
```

**When it triggers:**
- Hospital manually cancels the request
- Patient situation changed
- Request expired (24 hours)

**Purpose:** Let responding donors know they're no longer needed

---

### Scenario 1.3: Multiple Blood Types Needed
**Trigger Event:** Emergency request needs multiple blood types

**Notification Details:**
```
Type:        EMERGENCY
Title:       "🚨 Multiple Blood Types Needed!"
Subtitle:    "City Hospital needs O+, A+, and AB+ urgently"
Data:        {
  blood_types_needed: ["O+", "A+", "AB+"],
  hospital_name: "City Hospital",
  urgency: "critical"
}
```

**When it triggers:**
- Hospital creates request with multiple blood types
- Donor matches any of the blood types needed

**Purpose:** Cast wider net for urgent requests

---

### Scenario 1.4: Nearby Donor Availability Request
**Trigger Event:** Hospital searches for donors in area

**Notification Details:**
```
Type:        EMERGENCY
Title:       "Help Needed Nearby!"
Subtitle:    "Regional Hospital needs blood donors near you"
Data:        {
  hospital_name: "Regional Hospital",
  blood_types_needed: ["O+", "O-"],
  distance: 1.8 km,
  urgency_level: "high"
}
```

**When it triggers:**
- Hospital has active request
- Donor is within search radius
- Donor eligibility is confirmed

---

---

## **CATEGORY 2: DONATION APPOINTMENT SCENARIOS**

### Scenario 2.1: Appointment Confirmation
**Trigger Event:** Donor books appointment successfully

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Appointment Confirmed ✓"
Subtitle:    "Your donation is scheduled for tomorrow at 10:00 AM"
Data:        {
  appointment_id: "apt_789",
  hospital_id: "hosp_456",
  hospital_name: "City Hospital",
  donation_date: "2026-05-03",
  donation_time: "10:00 AM",
  duration_minutes: 45,
  address: "123 Medical Street",
  location: {lat, lng}
}
```

**When it triggers:**
- Immediately after successful appointment booking
- Within appointment creation response

**Donor actions:**
- Tap to view appointment details
- Reschedule appointment
- Cancel appointment
- Get directions

---

### Scenario 2.2: 24-Hour Appointment Reminder
**Trigger Event:** Scheduled task 24 hours before appointment

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Appointment Reminder 📅"
Subtitle:    "Your donation is tomorrow at 10:00 AM at City Hospital"
Data:        {
  appointment_id: "apt_789",
  hours_until: 24,
  appointment_details: {...}
}
```

**When it triggers:**
- Automatically 24 hours before scheduled appointment
- Back-end scheduled job
- If appointment is still pending/not cancelled

**Purpose:** Give donor time to prepare

**Donor actions:**
- Confirm attendance
- Reschedule
- Cancel
- Get directions

---

### Scenario 2.3: 2-Hour Appointment Reminder
**Trigger Event:** Scheduled task 2 hours before appointment

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Appointment Starting Soon ⏰"
Subtitle:    "Your donation at City Hospital starts in 2 hours"
Data:        {
  appointment_id: "apt_789",
  minutes_until: 120,
  should_leave_now: false
}
```

**When it triggers:**
- Automatically 2 hours before appointment
- To ensure donor is prepared & on the way

**Donor actions:**
- Start navigation
- Reschedule (late notice)
- Cancel (may affect score)

---

### Scenario 2.4: Appointment Rejection / Ineligibility
**Trigger Event:** Donor fails eligibility check before appointment

**Notification Details:**
```
Type:        APPOINTMENT → SYSTEM
Title:       "Appointment Cancelled - Health Check"
Subtitle:   "You're temporarily ineligible to donate. Please try again in 2 weeks."
Data:        {
  appointment_id: "apt_789",
  cancellation_reason: "health_check_failed",
  reason_details: "Low hemoglobin level",
  retry_date: "2026-05-17",
  eligibility_check_date: "2026-05-02"
}
```

**When it triggers:**
- System runs health eligibility check
- Donor fails requirement
- Appointment exists on that date

**Purpose:** Inform donor & prevent no-shows

---

### Scenario 2.5: Appointment Rescheduled by Hospital
**Trigger Event:** Hospital reschedules donor's appointment

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Appointment Rescheduled"
Subtitle:   "Your appointment has been moved to May 5 at 2:00 PM"
Data:        {
  appointment_id: "apt_789",
  original_date: "2026-05-03",
  original_time: "10:00 AM",
  new_date: "2026-05-05",
  new_time: "2:00 PM",
  reason: "Facility maintenance"
}
```

**When it triggers:**
- Hospital reschedules appointment
- Donor has confirmed presence

**Donor actions:**
- Accept new time
- Request alternative time
- Cancel

---

### Scenario 2.6: Appointment Cancellation by Hospital
**Trigger Event:** Hospital cancels scheduled appointment

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Appointment Cancelled"
Subtitle:   "Your donation appointment at City Hospital has been cancelled"
Data:        {
  appointment_id: "apt_789",
  cancellation_reason: "facility_closed",
  original_date: "2026-05-03",
  rebooking_option: true
}
```

**When it triggers:**
- Hospital cancels appointment
- Unexpected closure (emergency, maintenance, etc.)

**Donor actions:**
- View available alternatives
- Rebook at another time
- Contact hospital

---

---

## **CATEGORY 3: DONATION COMPLETION & CONFIRMATION**

### Scenario 3.1: Donation Completed
**Trigger Event:** Hospital/staff marks donation as complete

**Notification Details:**
```
Type:        REWARD
Title:       "🎉 Donation Complete!"
Subtitle:   "Thank you for saving lives! You earned 100 points"
Data:        {
  donation_id: "don_111",
  appointment_id: "apt_789",
  blood_units: 1,
  points_earned: 100,
  total_points: 1250,
  hospital_name: "City Hospital",
  donation_date: "2026-05-03",
  donation_time: "10:15 AM"
}
```

**When it triggers:**
- Hospital confirms donation completion
- Via QR code scan or manual entry
- Within 2 hours of appointment time

**Visual:**
- Celebration animation
- Point count displayed
- "View Certificate" or "Share" options

**Donor actions:**
- View donation details
- Share achievement
- Add to calendar
- View points

---

### Scenario 3.2: Donation Not Completed (No-Show)
**Trigger Event:** Appointment time passed without donation

**Notification Details:**
```
Type:        SYSTEM
Title:       "Appointment Missed"
Subtitle:   "You didn't show up for your donation appointment"
Data:        {
  appointment_id: "apt_789",
  missed_date: "2026-05-03",
  missed_time: "10:00 AM",
  hospital_name: "City Hospital",
  points_deducted: -25
}
```

**When it triggers:**
- Appointment time passed (30 min buffer)
- No confirmation received from hospital
- Automatic system check

**Purpose:** Track reliability & provide feedback

**Impact:**
- Reputation score decreased
- Hospital may prioritize other donors
- Reminder to reschedule

---

### Scenario 3.3: QR Code Verification
**Trigger Event:** Donor scans QR code at hospital

**Notification Details:**
```
Type:        APPOINTMENT
Title:       "Donation Confirmed ✓"
Subtitle:   "Your blood donation has been verified"
Data:        {
  donation_id: "don_111",
  verification_time: "2026-05-03T10:15:00Z",
  status: "verified",
  units_collected: 450
}
```

**When it triggers:**
- Donor scans hospital-provided QR code
- Verification successful
- Donation recorded in system

---

---

## **CATEGORY 4: REWARDS & POINTS SCENARIOS**

### Scenario 4.1: Points Earned
**Trigger Event:** Donation is confirmed & recorded

**Notification Details:**
```
Type:        REWARD
Title:       "Points Earned! 🎁"
Subtitle:   "You earned 100 points for your blood donation"
Data:        {
  points_earned: 100,
  donation_id: "don_111",
  total_balance: 1250,
  next_milestone: "500 points for Gold Badge (350 more needed)"
}
```

**When it triggers:**
- Immediately after donation completion
- Points calculated & added to account

**Donor actions:**
- View points history
- See available rewards
- View progress to badges

---

### Scenario 4.2: Reward Available for Redeem
**Trigger Event:** Donor reaches enough points for reward

**Notification Details:**
```
Type:        REWARD
Title:       "🏆 New Reward Unlocked!"
Subtitle:   "You can now redeem the 'Movie Tickets' reward with 250 points"
Data:        {
  reward_id: "rew_222",
  reward_name: "Movie Tickets",
  points_required: 250,
  points_available: 1250,
  can_redeem: true,
  expiry_date: "2026-06-02"
}
```

**When it triggers:**
- Donor's point balance >= reward's requirement
- Reward is active/not expired
- Donor hasn't redeemed before (if one-time)

**Donor actions:**
- Tap to view reward details
- Redeem immediately
- Share with others
- View expiry

---

### Scenario 4.3: Reward Redemption Confirmation
**Trigger Event:** Donor successfully redeems reward

**Notification Details:**
```
Type:        REWARD
Title:       "Reward Redeemed! 🎊"
Subtitle:   "Movie Tickets successfully redeemed. Check your email for voucher code"
Data:        {
  redemption_id: "red_333",
  reward_name: "Movie Tickets",
  points_deducted: 250,
  remaining_balance: 1000,
  voucher_code: "MV-TKT-ABC123",
  email_sent: true,
  expiry_date: "2026-06-02"
}
```

**When it triggers:**
- Immediately after successful redemption
- Points deducted from account
- Voucher generated

**Communication:**
- Email with voucher code
- SMS if phone is verified
- In-app notification

---

### Scenario 4.4: Points About to Expire
**Trigger Event:** Scheduled job checks point expiration

**Notification Details:**
```
Type:        SYSTEM
Title:       "⚠️ Points Expiring Soon"
Subtitle:   "Your 500 points will expire in 7 days. Redeem them now!"
Data:        {
  points_expiring: 500,
  days_remaining: 7,
  expiry_date: "2026-05-09",
  top_rewards_available: [...]
}
```

**When it triggers:**
- 7 days before points expiration
- Donor has points that will expire
- Scheduled background job

**Donor actions:**
- Browse available rewards
- Redeem points before expiry
- View expiry details

---

---

## **CATEGORY 5: BADGE & ACHIEVEMENT SCENARIOS**

### Scenario 5.1: Badge Unlocked (Donation Count)
**Trigger Event:** Donor completes Nth donation

**Notification Details:**
```
Type:        ACHIEVEMENT
Title:       "🏅 Silver Badge Unlocked!"
Subtitle:   "You've donated 5 times! You're now a Silver Donor"
Data:        {
  badge_id: "badge_silver",
  badge_name: "Silver Donor",
  total_donations: 5,
  previous_badge: "Bronze Donor",
  benefits: ["Priority scheduling", "Exclusive merchandise"],
  milestones: {
    bronze: 1,
    silver: 5,
    gold: 10,
    platinum: 25,
    diamond: 50
  }
}
```

**When it triggers:**
- After donation confirmation
- When total_donations == milestone number
- First time earning that badge

**Visual:**
- Achievement badge animation
- Badge image displayed
- Benefits listed
- Share option

**Donor actions:**
- View badge details
- Share achievement
- View next milestone

---

### Scenario 5.2: Badge Unlocked (Points Milestone)
**Trigger Event:** Donor reaches point milestone

**Notification Details:**
```
Type:        ACHIEVEMENT
Title:       "🏆 Gold Badge Unlocked!"
Subtitle:   "You earned 500 points! You've earned Gold Badge with priority scheduling"
Data:        {
  badge_id: "badge_gold",
  badge_name: "Gold Badge",
  total_points: 500,
  reward_unlocked: "Priority Donation Scheduling",
  next_badge: "Platinum (1000 points)"
}
```

**When it triggers:**
- After points added
- When total_points == milestone
- Badge system updated

---

### Scenario 5.3: Milestone Progress Update
**Trigger Event:** After each donation

**Notification Details:**
```
Type:        ACHIEVEMENT
Title:       "Progress to Next Badge 📈"
Subtitle:   "4 more donations to Silver Badge! You're almost there!"
Data:        {
  current_badge: "Bronze Donor",
  next_badge: "Silver Donor",
  donations_towards_next: 4,
  donations_needed: 5,
  progress_percentage: 80
}
```

**When it triggers:**
- After each donation completion
- If donor is close to next badge (optional)
- To encourage continued engagement

---

---

## **CATEGORY 6: ACCOUNT & SECURITY SCENARIOS**

### Scenario 6.1: Profile Updated Successfully
**Trigger Event:** Donor updates profile information

**Notification Details:**
```
Type:        SYSTEM
Title:       "Profile Updated ✓"
Subtitle:   "Your profile information has been updated successfully"
Data:        {
  fields_changed: ["phone", "address"],
  update_timestamp: "2026-05-02T14:30:00Z"
}
```

**When it triggers:**
- Immediately after profile save
- Confirmation of data change

---

### Scenario 6.2: Blood Type Verified/Changed
**Trigger Event:** Donor's blood type is verified or updated

**Notification Details:**
```
Type:        SYSTEM
Title:       "Blood Type Verified ✓"
Subtitle:   "Your blood type O+ has been verified"
Data:        {
  blood_type: "O+",
  verification_method: "document_scan",
  verified_date: "2026-05-02"
}
```

**When it triggers:**
- Blood type first verified
- Blood type changed after verification

**Purpose:** Ensure accurate request matching

---

### Scenario 6.3: Email Verification Required
**Trigger Event:** Donor changes email address

**Notification Details:**
```
Type:        SYSTEM
Title:       "Verify Your Email"
Subtitle:   "We sent a verification link to your new email address"
Data:        {
  new_email: "newemail@example.com",
  verification_link: "...",
  expires_in_hours: 24
}
```

**When it triggers:**
- When donor updates email
- Verification required before account access

---

### Scenario 6.4: Phone Verification Required
**Trigger Event:** Donor changes phone number

**Notification Details:**
```
Type:        SYSTEM
Title:       "Verify Your Phone Number"
Subtitle:   "We sent a verification code to +92-300-1111111"
Data:        {
  phone_number: "+92-300-1111111",
  verification_code: "***123",
  expires_in_minutes: 10
}
```

**When it triggers:**
- When donor updates phone
- OTP required for verification

---

### Scenario 6.5: Login from New Device
**Trigger Event:** Login attempt from new device/location

**Notification Details:**
```
Type:        SYSTEM
Title:       "New Login Detected 🔔"
Subtitle:   "Your account was accessed from Samsung Galaxy, Islamabad at 2:30 PM"
Data:        {
  device_name: "Samsung Galaxy",
  device_type: "Android",
  location: "Islamabad",
  ip_address: "123.45.67.89",
  timestamp: "2026-05-02T14:30:00Z",
  approve_action: "confirm_login"
}
```

**When it triggers:**
- Login from new device/IP detected
- Security check for unauthorized access

**Donor actions:**
- Confirm login is legitimate
- Deny & change password
- View all active sessions

---

### Scenario 6.6: Password Changed Successfully
**Trigger Event:** Donor successfully changes password

**Notification Details:**
```
Type:        SYSTEM
Title:       "Password Changed ✓"
Subtitle:   "Your password was changed on May 2 at 2:30 PM from Safari, iPad"
Data:        {
  device_name: "Safari, iPad",
  change_timestamp: "2026-05-02T14:30:00Z"
}
```

**When it triggers:**
- Immediately after password change
- Account security confirmation

---

### Scenario 6.7: Suspicious Activity Alert
**Trigger Event:** System detects suspicious activity

**Notification Details:**
```
Type:        SYSTEM
Title:       "⚠️ Suspicious Activity"
Subtitle:   "Multiple failed login attempts detected. Secure your account."
Data:        {
  activity_type: "failed_logins",
  attempt_count: 5,
  from_location: "Unknown",
  action_recommended: "change_password"
}
```

**When it triggers:**
- Multiple failed login attempts (>5)
- Unusual activity pattern detected
- IP from restricted/VPN location

**Donor actions:**
- Change password immediately
- Review account activity
- Enable 2FA

---

---

## **CATEGORY 7: HOSPITAL COMMUNICATION SCENARIOS**

### Scenario 7.1: Hospital Sends Message
**Trigger Event:** Hospital staff sends message to donor

**Notification Details:**
```
Type:        HOSPITAL
Title:       "Message from City Hospital 💬"
Subtitle:   "Thanks for your donation! Your blood will save 3 patients."
Data:        {
  message_id: "msg_444",
  hospital_id: "hosp_456",
  hospital_name: "City Hospital",
  message_content: "Thanks for your donation...",
  timestamp: "2026-05-02T14:30:00Z",
  requires_response: false
}
```

**When it triggers:**
- Hospital sends direct message to donor
- Via hospital admin interface

**Donor actions:**
- View full message
- Reply to hospital
- Rate hospital

---

### Scenario 7.2: Hospital Requests More Donors
**Trigger Event:** Blood request needs more units

**Notification Details:**
```
Type:        EMERGENCY
Title:       "More Donors Needed! 🚨"
Subtitle:   "City Hospital still needs O+ blood. Can you help again?"
Data:        {
  request_id: "req_123",
  hospital_name: "City Hospital",
  blood_type: "O+",
  units_still_needed: 2,
  units_received: 1,
  last_donation_days_ago: 56
}
```

**When it triggers:**
- Request still unfulfilled
- Days passed since last donor's donation
- Donor is eligible to donate again

---

### Scenario 7.3: Special Donation Event
**Trigger Event:** Hospital announces special donation event

**Notification Details:**
```
Type:        HOSPITAL
Title:       "🎉 Blood Donation Event!"
Subtitle:   "Join us this weekend at Central Hospital. Donate & win prizes!"
Data:        {
  event_id: "evt_555",
  hospital_name: "Central Hospital",
  event_name: "Spring Donation Drive",
  event_date: "2026-05-05",
  event_time: "9:00 AM - 5:00 PM",
  bonus_points: 50,
  prizes: ["Vouchers", "Health vouches"],
  location: {lat, lng}
}
```

**When it triggers:**
- Hospital creates event
- Notification sent to eligible donors in area
- 3-7 days before event

**Donor actions:**
- Register for event
- Get directions
- Share event
- View prizes

---

---

## **CATEGORY 8: SYSTEM & MAINTENANCE SCENARIOS**

### Scenario 8.1: App Update Available
**Trigger Event:** New app version available in store

**Notification Details:**
```
Type:        SYSTEM
Title:       "Update Available 📲"
Subtitle:   "New features: Improved notifications, better search, bug fixes"
Data:        {
  current_version: "1.0.0",
  new_version: "1.1.0",
  release_notes: "New features...",
  forced_update: false,
  update_url: "play.google.com/..."
}
```

**When it triggers:**
- New version released & detected
- Optional updates: prompted once per week
- Forced updates: every app open

---

### Scenario 8.2: System Maintenance Notice
**Trigger Event:** Scheduled maintenance announced

**Notification Details:**
```
Type:        SYSTEM
Title:       "Scheduled Maintenance 🔧"
Subtitle:   "The app will be unavailable for 2 hours on Sunday midnight"
Data:        {
  maintenance_type: "database_upgrade",
  start_time: "2026-05-07T00:00:00Z",
  end_time: "2026-05-07T02:00:00Z",
  duration_hours: 2,
  impact: "App will be read-only during maintenance"
}
```

**When it triggers:**
- 48 hours before maintenance
- 24 hours before maintenance
- At maintenance start time

---

### Scenario 8.3: System Outage / Emergency Alert
**Trigger Event:** Critical system issue detected

**Notification Details:**
```
Type:        SYSTEM
Title:       "⚠️ System Alert"
Subtitle:   "We're experiencing temporary connectivity issues. Please try again later."
Data:        {
  alert_type: "service_degradation",
  affected_services: ["emergency_requests", "donations"],
  status_page: "status.lifelink.app",
  estimated_resolution: "30 minutes"
}
```

**When it triggers:**
- Live incident detection
- Affects user experience
- Needs immediate awareness

---

---

## 🎯 NOTIFICATION FLOW DIAGRAM

```
DONOR APP EVENT
        │
        ▼
┌─────────────────────┐
│ EVENT TRIGGERED     │
│ - Donation complete │
│ - Request created   │
│ - Badge unlocked    │
│ - Points earned     │
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│ BACKEND VALIDATES   │
│ - Donor eligible?   │
│ - Location match?   │
│ - Notification on?  │
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│ NOTIFICATION TYPE   │
│ - Emergency         │
│ - Reward            │
│ - System            │
│ - Achievement       │
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│ DELIVERY METHOD     │
│ - Push notification │
│ - SMS (optional)    │
│ - Email (optional)  │
│ - In-app only       │
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│ DONOR RECEIVES      │
│ - See in inbox      │
│ - Sound/vibration   │
│ - Action prompt     │
│ - Can mark read     │
└─────────────────────┘
        │
        ▼
┌─────────────────────┐
│ ANALYTICS TRACKED   │
│ - Delivery time     │
│ - Read time         │
│ - Action taken      │
│ - Engagement metric │
└─────────────────────┘
```

---

## 🚀 PRIORITY & URGENCY LEVELS

### **CRITICAL** (Red)
```
- Emergency blood requests
- Immediate action required
- Delivery: Push + Sound + Vibration + SMS
- Hold time: 24 hours (or until fulfilled)
- Auto-refresh: Every 5 minutes
```

### **HIGH** (Orange)
```
- Appointment reminders (24h, 2h)
- Request status changes
- Achievement unlocked
- Delivery: Push + Sound
- Hold time: 7 days
- Auto-archive: After read
```

### **MEDIUM** (Blue)
```
- Points earned
- Reward available
- Hospital messages
- Delivery: Push (quiet)
- Hold time: 30 days
- Auto-archive: After 7 days
```

### **LOW** (Gray)
```
- Profile updates
- System notifications
- App updates
- Delivery: In-app only
- Hold time: 90 days
- Auto-delete: After 90 days
```

---

## ⚡ TRIGGER EVENTS (Backend Implementation)

### Events that trigger notifications:

| Event | Type | Trigger Condition | Payload |
|-------|------|---|---|
| `emergency_request.created` | EMERGENCY | request.urgency='critical' | request_id, blood_type, units, location |
| `emergency_request.fulfilled` | EMERGENCY | request.units_received >= request.units_needed | request_id, final_count |
| `emergency_request.cancelled` | EMERGENCY | request.status='cancelled' | request_id, reason |
| `donation.completed` | REWARD | appointment confirmed & donation marked complete | points_earned, total_balance |
| `badge.unlocked` | ACHIEVEMENT | milestone reached | badge_id, badge_name |
| `points.earned` | REWARD | points added to account | points_amount, source |
| `appointment.booked` | APPOINTMENT | appointment created successfully | appointment_id, datetime |
| `appointment.reminder_24h` | APPOINTMENT | scheduled job executes | appointment_id |
| `appointment.reminder_2h` | APPOINTMENT | scheduled job executes | appointment_id |
| `appointment.cancelled` | APPOINTMENT | appointment.status='cancelled' | appointment_id, reason |
| `appointment.rescheduled` | APPOINTMENT | appointment.datetime changed | appointment_id, new_time |
| `profile.updated` | SYSTEM | user profile changed | fields_changed |
| `email.verification_required` | SYSTEM | email changed | verification_link |
| `login.new_device` | SYSTEM | login from new device/IP | device_name, location |
| `points.expiring_soon` | SYSTEM | 7 days before expiration | points_amount, days_remaining |
| `hospital.message_sent` | HOSPITAL | hospital sends message | message_id, content |
| `event.announced` | HOSPITAL | hospital creates event | event_id, event_details |

---

## 📊 DATA MODEL

```
Notification Schema:
{
  id: UUID,
  
  // Basic info
  type: ENUM ['emergency', 'appointment', 'reward', 'achievement', 'system', 'hospital'],
  priority: ENUM ['critical', 'high', 'medium', 'low'],
  
  // Content
  title: String,
  subtitle: String,
  body: String (optional),
  icon_url: String (optional),
  badge_color: String,
  
  // Status
  is_read: Boolean,
  is_archived: Boolean,
  read_at: DateTime (nullable),
  archived_at: DateTime (nullable),
  
  // Timing
  created_at: DateTime,
  expires_at: DateTime,
  scheduled_for: DateTime (for scheduled notifications),
  
  // Recipient
  donor_id: UUID,
  hospital_id: UUID (optional),
  
  // Related entities
  emergency_request_id: UUID (optional),
  appointment_id: UUID (optional),
  donation_id: UUID (optional),
  badge_id: UUID (optional),
  
  // Delivery
  delivery_method: ENUM ['push', 'sms', 'email', 'in_app'],
  is_delivered: Boolean,
  delivered_at: DateTime (nullable),
  notification_token: String (for push),
  
  // Actions
  primary_action: {
    label: String,
    action_type: String,
    target_screen: String,
    payload: JSON
  },
  secondary_action: {...} (optional),
  
  // Metadata
  source_system: String,
  source_event: String,
  metadata: JSON
}
```

---

## 🔌 INTEGRATION POINTS

### **1. Frontend - Notification Service**
**Location:** `lib/data/remote/notification_api_service.dart`

```
METHODS:
- fetchNotifications(page, limit)
- getNotification(id)
- markAsRead(notificationId)
- markAllAsRead()
- deleteNotification(id)
- setNotificationPreferences(settings)
```

---

### **2. Backend - Notification Controller**
**Location:** `src/controllers/notification.controller.js`

```
ENDPOINTS:
POST   /api/v1/notifications/send
GET    /api/v1/donor/notifications
PUT    /api/v1/donor/notifications/:id/mark-read
DELETE /api/v1/donor/notifications/:id
```

---

### **3. Backend - Notification Service**
**Location:** `src/services/notification.service.js`

```
METHODS:
- sendEmergencyAlert(donors, request)
- sendAppointmentReminder(donor, appointment)
- sendPointsNotification(donor, points)
- sendBadgeNotification(donor, badge)
- sendSystemNotification(donors, message)
- getNotifications(donorId, filters)
```

---

### **4. Backend - Notification Queue**
**Pattern:** Redis Queue or Bull Queue

```
JOBS:
- send_emergency_notification
- send_appointment_reminder_24h
- send_appointment_reminder_2h
- send_points_earned
- send_badge_unlocked
- send_expiring_points_alert
```

---

### **5. Push Notification Service**
**Platforms:**
- Firebase Cloud Messaging (FCM) - Android
- Apple Push Notification (APNs) - iOS

```
PAYLOAD STRUCTURE:
{
  notification: {
    title: String,
    body: String,
    icon: String,
    color: String
  },
  data: {
    type: String,
    screen: String,
    payload: JSON
  }
}
```

---

## 📋 BACKEND REQUIREMENTS CHECKLIST

### Database Tables Needed:
```
✓ notifications
  - id, type, priority, title, subtitle
  - donor_id, hospital_id
  - is_read, is_archived
  - created_at, expires_at
  - delivery_method, is_delivered
  - Related entity IDs (request_id, appointment_id, etc.)

✓ notification_preferences
  - donor_id
  - emergency_alerts_enabled
  - appointment_reminders_enabled
  - reward_notifications_enabled
  - email_notifications
  - sms_notifications
  
✓ notification_delivery_logs
  - notification_id
  - delivery_method
  - status (pending, delivered, failed)
  - attempted_at
  - delivered_at
```

### Queue Jobs:
```
✓ Send emergency alerts (immediate, 5-min retry)
✓ Send appointment reminders 24h before
✓ Send appointment reminders 2h before
✓ Send expiring points alerts (daily)
✓ Clean up expired notifications (weekly)
✓ Archive old notifications (monthly)
```

### Event Listeners:
```
✓ donation.completed → send points notification
✓ badge.unlocked → send achievement notification
✓ emergency_request.created → send alerts to nearby donors
✓ appointment.created → send confirmation
✓ appointment.scheduled_time_24h → send reminder
✓ appointment.scheduled_time_2h → send reminder
✓ points.balance > 0 → track expiration
```

---

## 💡 IMPLEMENTATION NOTES

### **Order of Priority (for backend development):**

1. **Phase 1 - Emergency Alerts** (CRITICAL)
   - Emergency request notifications
   - Real-time matching
   - Geolocation-based delivery

2. **Phase 2 - Appointment Management** (HIGH)
   - Appointment confirmations
   - 24h and 2h reminders
   - Scheduled jobs

3. **Phase 3 - Rewards & Gamification** (HIGH)
   - Points earned notifications
   - Badge unlocked alerts
   - Points expiration warnings

4. **Phase 4 - System & Account** (MEDIUM)
   - Profile updates
   - Security alerts
   - Device login notifications

5. **Phase 5 - Hospital Communication** (MEDIUM)
   - Direct messages
   - Event announcements
   - Partnership communications

6. **Phase 6 - Analytics** (LOW)
   - Delivery tracking
   - Read analytics
   - Engagement metrics

---

## 🎓 KEY ARCHITECTURAL DECISIONS

### 1. **One Notification Table with Type Field**
**vs.** Separate tables per notification type

**Decision:** Single table with type field
**Reason:** Easier querying, unified design, less schema complexity

---

### 2. **In-App First, Push Optional**
**vs.** Push-only notifications

**Decision:** All notifications in-app, push for emergency only
**Reason:** Respects user preferences, reduces notification fatigue

---

### 3. **Scheduled Jobs for Time-Based**
**vs.** WebSocket/Real-time

**Decision:** Redis scheduled jobs
**Reason:** Reliable, cannot miss, works with server restart

---

### 4. **Soft Delete (Archive)**
**vs.** Hard delete

**Decision:** Archive instead of delete
**Reason:** Analytics, audit trail, recovery options

---

### 5. **Expiration-Based Cleanup**
**vs.** Keep all history

**Decision:** Auto-expire based on priority (24h critical, 90d low)
**Reason:** Database performance, storage efficiency

---

---

## 📞 CONTACT INFORMATION FOR CLARIFICATIONS

**Questions about notifications?**
```
- Check notification_repository.dart for UI integration
- Check notification_api_service.dart for API calls
- Refer to this document for business logic
```

---

**Document Status:** ✅ Complete & Ready for Backend Development  
**Next Steps:** Create notification backend service based on these scenarios  
**Estimated Backend Work:** 3-4 days for full implementation

---

