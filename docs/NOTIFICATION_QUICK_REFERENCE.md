# 🔔 DONOR NOTIFICATION QUICK SUMMARY

**Last Updated:** May 2, 2026  
**For:** Blood Donation App Donors

---

## ⚡ WHEN TO SEND NOTIFICATIONS TO DONORS

### 1️⃣ **EMERGENCY BLOOD REQUESTS** 🚨
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Hospital creates EMERGENCY request with blood type = donor's blood type
✓ Donor is within 5-10 km radius of hospital
✓ Donor is currently eligible to donate
✓ Donor hasn't disabled emergency notifications

NOTIFICATION:
Title:    "🚨 Emergency O+ Blood Request!"
Message:  "City Hospital needs O+ urgently, 2.3 km away"
Type:     EMERGENCY (Red, Loud, Urgent)
Action:   "Respond Now" button → Accept/Decline
```

**Variants:**
- Request fulfilled → "Blood Request Fulfilled"
- Request cancelled → "Request Cancelled"
- Multiple blood types needed → Multiple match notifications

---

### 2️⃣ **APPOINTMENT CONFIRMATIONS** ✅
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Donor successfully books appointment
✓ Hospital reschedules donor's appointment
✓ Hospital cancels donor's appointment

NOTIFICATION:
Title:    "Appointment Confirmed ✓"
Message:  "Your donation is scheduled for May 3 at 10:00 AM"
Type:     APPOINTMENT (Blue, Normal)
Action:   View details, Reschedule, Cancel, Get Directions
```

---

### 3️⃣ **APPOINTMENT REMINDERS** ⏰
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Automatically 24 HOURS before appointment
✓ Automatically 2 HOURS before appointment

NOTIFICATION (24h):
Title:    "Appointment Reminder 📅"
Message:  "Your donation is tomorrow at 10:00 AM at City Hospital"

NOTIFICATION (2h):
Title:    "Appointment Starting Soon ⏰"
Message:  "Your donation at City Hospital starts in 2 hours"
```

**Scheduled via:** Backend cron jobs / Queue system (Redis)

---

### 4️⃣ **DONATION COMPLETION** 🎉
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Hospital marks donation as COMPLETE
✓ Hospital confirms via QR code scan
✓ Donation is recorded in system

NOTIFICATION:
Title:    "🎉 Donation Complete!"
Message:  "Thank you for saving lives! You earned 100 points"
Type:     REWARD (Gold, Celebration sound)
Action:   View details, View certificate, Share
Data:     Points earned, total balance, donation date
```

---

### 5️⃣ **POINTS & REWARDS** 💰
```
NOTIFICATION 1 - Points Earned:
WHEN: After donation is confirmed
Title:  "Points Earned! 🎁"
Text:   "You earned 100 points for your donation"
Shows:  Total current balance, progress to next badge

NOTIFICATION 2 - Reward Unlocked:
WHEN: When donor's balance ≥ reward requirement
Title:  "🏆 New Reward Unlocked!"
Text:   "You can now redeem Movie Tickets (250 points)"
Action: "Redeem Now"

NOTIFICATION 3 - Reward Redeemed:
WHEN: After successful redemption
Title:  "Reward Redeemed! 🎊"
Text:   "Voucher code sent to your email"
Data:   Voucher code, expiry date

NOTIFICATION 4 - Points Expiring:
WHEN: 7 days before points expiration
Title:  "⚠️ Points Expiring Soon"
Text:   "Your 500 points expire in 7 days"
Action: "Browse Rewards"
```

---

### 6️⃣ **ACHIEVEMENTS & BADGES** 🏅
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Donor completes 5th donation → Silver Badge
✓ Donor completes 10th donation → Gold Badge
✓ Donor reaches 500 points → Gold Badge unlock
✓ After each donation → Progress update (if close)

NOTIFICATION:
Title:      "🏅 Silver Badge Unlocked!"
Message:    "You've donated 5 times! You're now a Silver Donor"
Type:       ACHIEVEMENT (Purple, Celebration)
Benefits:   Show badge perks (Priority scheduling, etc.)
Action:     Share, View next milestone
```

---

### 7️⃣ **ELIGIBILITY & REJECTIONS** ⛔
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Appointment cancelled due to health check failure
✓ Donation rejected at hospital due to eligibility

NOTIFICATION:
Title:    "Appointment Cancelled - Health Check"
Message:  "You're temporarily ineligible. Try again in 2 weeks"
Type:     SYSTEM (Gray, Informational)
Data:     Reason, retry date, what to do next
```

---

### 8️⃣ **ACCOUNT & SECURITY** 🔒
```
NOTIFICATION 1 - Profile Updated:
WHEN: Donor updates profile info
Title:  "Profile Updated ✓"
Message: "Your profile changes saved successfully"

NOTIFICATION 2 - Email Verification:
WHEN: Donor changes email
Title:  "Verify Your Email"
Message: "Verification link sent to new@email.com"
Action: Click link (24 hour expiry)

NOTIFICATION 3 - New Device Login:
WHEN: Login from new device/location
Title:  "New Login Detected 🔔"
Message: "Samsung Galaxy, Islamabad, 2:30 PM"
Action: Approve, Deny, or Change Password

NOTIFICATION 4 - Suspicious Activity:
WHEN: Multiple failed logins (>5)
Title:  "⚠️ Suspicious Activity"
Message: "Change your password immediately"
Action: Change Password, Review Activity
```

---

### 9️⃣ **HOSPITAL MESSAGES** 💬
```
WHEN DONOR SHOULD BE NOTIFIED:
✓ Hospital sends direct message to donor
✓ Hospital announces special event
✓ Hospital requests more donors (request still unfulfilled)

NOTIFICATION 1 - Direct Message:
Title:  "Message from City Hospital 💬"
Message: "Thanks for your donation! Your blood will save 3 lives"
Action: Reply, View full message

NOTIFICATION 2 - Special Event:
Title:  "🎉 Blood Donation Event!"
Message: "Spring Donation Drive this weekend at Central Hospital"
Bonus:  Special bonus points (50 extra)
Action: Register, Get Directions, Share
```

---

### 🔟 **SYSTEM & MAINTENANCE** 🔧
```
NOTIFICATION 1 - App Update:
WHEN: New version available
Title:  "Update Available 📲"
Message: "New features: Better notifications, faster search"
Action: Update Now

NOTIFICATION 2 - Maintenance Alert:
WHEN: 48 hours before scheduled maintenance
Title:  "Scheduled Maintenance 🔧"
Message: "App unavailable Sunday midnight for 2 hours"
```

---

## 📊 NOTIFICATION PRIORITY MATRIX

| Priority | Type | Sound? | Vibration? | Duration | Examples |
|----------|------|--------|-----------|----------|----------|
| 🔴 **CRITICAL** | Emergency | YES | Strong | 24h | Emergency blood requests |
| 🟠 **HIGH** | Appointment | YES | Medium | 7d | Reminders, completion |
| 🔵 **MEDIUM** | Rewards | Quiet | Light | 30d | Points, badges, messages |
| ⚪ **LOW** | System | NO | NO | 90d | Profile updates, info |

---

## 🎯 NOTIFICATION DELIVERY METHODS

| Type | Push? | SMS? | Email? | In-App? |
|------|-------|------|--------|---------|
| Emergency | ✅ YES | YES | - | YES |
| Appointment | ✅ YES | Opt-in | Opt-in | YES |
| Reward | ✅ YES | - | - | YES |
| Achievement | ✅ YES | - | - | YES |
| System | - | - | Opt-in | YES |
| Hospital | ✅ YES | Opt-in | - | YES |

---

## 📌 WHAT TRIGGERS EACH NOTIFICATION

```
DONOR'S ACTION / BACKEND EVENT → Notification sent:

1. Hospital creates emergency → Emergency alert to matching donors
2. Donor books appointment → Confirmation notification
3. Day before appointment → 24h reminder (auto)
4. 2 hours before appointment → 2h reminder (auto)
5. Donation completed → Celebration + points earned
6. Points added → Balance updated notification
7. Total points ≥ reward cost → "Reward unlocked" alert
8. Donor redeems reward → Confirmation notification
9. 7 days before points expire → Expiration warning
10. 5th/10th/etc donation → Badge unlock notification
11. Donor changes profile → Confirmation notification
12. Donor changes email → Verification required
13. New device login → Security alert
14. Failed login (>5) → Suspicious activity alert
15. Hospital sends message → Direct message notification
16. Hospital hosts event → Event announcement
17. New app version → Update available
18. Maintenance scheduled → Advance notice
```

---

## 🚀 IMPLEMENTATION CHECKLIST (For Backend)

### Phase 1 - Emergency Alerts (Week 1)
- [ ] Create `notifications` database table
- [ ] Build emergency request → notification mapping
- [ ] Implement geolocation filtering
- [ ] Set up push notification delivery
- [ ] Test with 5+ emergency scenarios

### Phase 2 - Appointments (Week 2)
- [ ] Create appointment reminder scheduler
- [ ] Set up 24-hour reminder job
- [ ] Set up 2-hour reminder job
- [ ] Create appointment status change listeners
- [ ] Test appointment workflows

### Phase 3 - Rewards (Week 2)
- [ ] Create points earned listener
- [ ] Create reward unlock trigger
- [ ] Create points expiration checker
- [ ] Implement redemption confirmation
- [ ] Test reward scenarios

### Phase 4 - System & Security (Week 3)
- [ ] Create login device detector
- [ ] Create failed login tracker
- [ ] Create profile update listener
- [ ] Create email/phone verification notifications
- [ ] Test security scenarios

### Phase 5 - Analytics (Week 4)
- [ ] Track push delivery status
- [ ] Track read/click rates
- [ ] Dashboard for notification stats
- [ ] A/B testing capabilities

---

## 💾 DATABASE SCHEMA OVERVIEW

```sql
CREATE TABLE notifications (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL,
  type VARCHAR(50),           -- 'emergency', 'appointment', 'reward', etc.
  priority VARCHAR(50),       -- 'critical', 'high', 'medium', 'low'
  title VARCHAR(255),
  subtitle TEXT,
  is_read BOOLEAN,
  is_archived BOOLEAN,
  created_at TIMESTAMP,
  expires_at TIMESTAMP,
  emergency_request_id UUID,  -- Optional, for emergency type
  appointment_id UUID,        -- Optional, for appointment type
  donation_id UUID,          -- Optional, for reward type
  FOREIGN KEY (donor_id) REFERENCES donors(id)
);

CREATE TABLE notification_preferences (
  id UUID PRIMARY KEY,
  donor_id UUID,
  emergency_alerts_enabled BOOLEAN,
  appointment_reminders_enabled BOOLEAN,
  reward_notifications_enabled BOOLEAN,
  push_notifications_enabled BOOLEAN,
  sms_notifications_enabled BOOLEAN,
  email_notifications_enabled BOOLEAN
);
```

---

## 🎓 KEY PRINCIPLES

1. **🔴 Emergency = Immediate** - No delays, push + sound + vibration
2. **⏰ Scheduled = Reliable** - Use cron jobs, not real-time
3. **🎯 Contextual = Relevant** - Only send if donor matches criteria
4. **📊 Trackable = Measured** - Log delivery, read, click events
5. **🔧 Configurable = Respectful** - Let donors control notification types
6. **🧹 Expiring = Cleanup** - Archive/delete old notifications

---

## ❓ COMMON QUESTIONS

**Q: Can a donor disable emergency notifications?**  
A: Generally NO - Emergency notifications are critical for safety. But they can disable push delivery method.

**Q: What if appointment is in past?**  
A: System checks appointment.datetime > NOW before sending reminders.

**Q: Can donor mute a specific notification?**  
A: YES - Mark as read, archive, or dismiss. Won't spam.

**Q: What if donor is offline?**  
A: Push goes to device queue. Notification saved in DB. Shown when app opens.

**Q: Should we send email too?**  
A: Optional. For emergency YES. For others, only if opted-in.

**Q: Can notifications expire?**  
A: YES - Emergency 24h, High 7d, Medium 30d, Low 90d. Auto-archived after.

---

## 📞 FINAL SUMMARY

**Send notifications to donors in these 10 situations:**

1. ✅ Emergency blood request (their blood type, nearby, eligible)
2. ✅ Appointment confirmation (after they book)
3. ✅ 24-hour appointment reminder (auto, next day)
4. ✅ 2-hour appointment reminder (auto, same day)
5. ✅ Donation completed (hospital confirms)
6. ✅ Points earned (after donation)
7. ✅ Badge unlocked (5 donations, 500 points, etc.)
8. ✅ Reward available (points balance ≥ requirement)
9. ✅ Account/Security events (login, profile, verification)
10. ✅ Hospital messages/events (direct communication)

---

**Document ready for:** Backend development, API design, database schema, push notification setup


