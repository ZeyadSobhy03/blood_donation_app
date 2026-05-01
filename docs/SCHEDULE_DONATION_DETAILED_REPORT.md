# 📅 SCHEDULE DONATION - DETAILED REPORT

**Report Date:** April 29, 2026  
**Status:** 95% Complete (Frontend UI + Model)  
**Backend Progress:** 0% - Not Started

---

## ✅ WHAT HAS BEEN BUILT

### Perfect 5-Step Stepper Flow

Your appointment booking system has **excellent UI implementation** with:

#### **Step 1: Location Selection** ✅
- Hospital list or search interface
- Hospital card with details (name, address, rating)
- Blood type filtering
- Distance/availability display
- "Next" button to proceed

**Output:** `hospital_id`

#### **Step 2: Date & Time Selection** ✅
- Calendar date picker
- Available time slots display
- Time slot capacity indicator
- Slot availability status (available/booked)
- "Next" button

**Output:** `slot_id`, `appointment_date`, `appointment_time`

#### **Step 3: Confirm Your Details** ✅
- Donor name display
- Contact number
- Blood type
- Email address
- Edit buttons for changes
- "Next" button

**Output:** Confirmed personal data

#### **Step 4: Review & Confirm** ✅
- Hospital summary
- Date/Time summary
- Donor information summary
- Donation type selection
- Special notes/instructions
- "Confirm" button
- "Back" button

**Output:** Ready for submission

#### **Step 5: Appointment Confirmed** ✅
- Confirmation code display (e.g., "APPT-2026-04-30-001")
- Hospital details (name, address, phone)
- Appointment details (date, time, blood type)
- Directions link
- Reminder instructions
- Special do's and don'ts
- "Close" or "Done" button

**Output:** Booking completed

### Files Created

```
lib/presentation/role/donor/tabs/donate/schedule_donation/
├── schedule_donation.dart                    # Main container
├── model/
│   ├── donation_schedule.dart               # Data model
│   └── donation_booking_card.dart           # Card model
├── cubit/
│   └── donation_schedule.dart               # State management
├── steps/
│   ├── location_step.dart                   # Step 1
│   ├── date_time_step.dart                  # Step 2
│   ├── confirm_your_details.dart            # Step 3
│   ├── review_and_confirm.dart              # Step 4
│   └── appointment_confirmed.dart           # Step 5
└── widgets/
    ├── title_step.dart                     # Step titles
    ├── time_slot_picker.dart               # Time selection
    ├── review_row.dart                     # Review item
    ├── review_card.dart                    # Summary card
    ├── note_card.dart                      # Notes section
    ├── navigation_button.dart              # Next/Prev buttons
    ├── input_with_label.dart               # Form input
    ├── input_label.dart                    # Labels
    ├── hospital_card.dart                  # Hospital display
    ├── donation_type_picker.dart           # Donation type
    ├── date_and_time_card.dart             # Selected date/time
    └── custom_text_form_field.dart         # Input fields
```

### UI Components

**Page View Stepper:**
- PageView with 5 pages
- Smooth navigation animations
- Progress indicator showing step 1/5, 2/5, etc.
- Back button to previous step
- Title changes with each step

**Form State Management:**
- BLOC/CUBIT for state management
- Form validation
- Data persistence across steps
- Error handling

---

## 🔴 WHAT'S MISSING (Backend)

Your app cannot currently:

| Feature | Impact | Status |
|---------|--------|--------|
| Load hospital slots | User sees no available times | ❌ MISSING |
| Check slot availability | Cannot verify slot is free | ❌ MISSING |
| Verify donor eligibility | No eligibility check | ❌ MISSING |
| Save appointment booking | Booking goes nowhere | ❌ MISSING |
| Generate confirmation code | No code created | ❌ MISSING |
| Award reward points | User gets no points | ❌ MISSING |
| Send confirmation email/SMS | No notification sent | ❌ MISSING |
| Schedule reminders | No reminder system | ❌ MISSING |
| Reschedule appointment | Cannot change booking | ❌ MISSING |
| Cancel appointment | Cannot cancel booking | ❌ MISSING |
| View my appointments | Cannot see bookings | ❌ MISSING |

---

## ✅ BACKEND SOLUTION

### 5 Critical Endpoints Needed

---

#### **1. Get Available Appointment Slots**

**Endpoint:**
```http
GET /api/v1/donations/book-appointment/slots
Authorization: Bearer {token}

Query Parameters:
- hospital_id: 550e8400-e29b-41d4-a716-446655440000
- start_date: 2026-04-30 (YYYY-MM-DD)
- end_date: 2026-05-07 (optional, default: 7 days)
- blood_type: O+ (required)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "550e8400-e29b-41d4-a716-446655440000",
    "hospital_name": "City Hospital",
    "blood_type": "O+",
    "available_slots": [
      {
        "slot_id": "550e8400-e29b-41d4-a716-446655440001",
        "date": "2026-04-30",
        "time_slot": "09:00-09:30",
        "start_time": "09:00",
        "end_time": "09:30",
        "capacity": 5,
        "booked_count": 3,
        "available_seats": 2,
        "is_available": true
      },
      {
        "slot_id": "550e8400-e29b-41d4-a716-446655440002",
        "date": "2026-04-30",
        "time_slot": "10:00-10:30",
        "start_time": "10:00",
        "end_time": "10:30",
        "capacity": 5,
        "booked_count": 5,
        "available_seats": 0,
        "is_available": false
      },
      {
        "slot_id": "550e8400-e29b-41d4-a716-446655440003",
        "date": "2026-05-01",
        "time_slot": "14:00-14:30",
        "start_time": "14:00",
        "end_time": "14:30",
        "capacity": 5,
        "booked_count": 1,
        "available_seats": 4,
        "is_available": true
      }
    ]
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

**What to do with this:**
- Display slots in time slot picker
- Show booked count vs capacity
- Gray out unavailable slots
- Sort by date and time

---

#### **2. Book Appointment** ⭐ CRITICAL

**Endpoint:**
```http
POST /api/v1/donations/book-appointment
Authorization: Bearer {token}
Content-Type: application/json

Body:
{
  "hospital_id": "550e8400-e29b-41d4-a716-446655440000",
  "slot_id": "550e8400-e29b-41d4-a716-446655440001",
  "blood_type": "O+",
  "notes": "I am available after 5 PM (optional)",
  "contact_number": "+92-300-1234567"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "550e8400-e29b-41d4-a716-446655440010",
    "donor_id": "550e8400-e29b-41d4-a716-446655440100",
    "hospital_id": "550e8400-e29b-41d4-a716-446655440000",
    "hospital_name": "City Hospital",
    "appointment_date": "2026-04-30",
    "appointment_time": "09:00-09:30",
    "blood_type_needed": "O+",
    "status": "confirmed",
    "confirmation_code": "APPT-2026-04-30-001",
    "directions_url": "https://api.example.com/api/v1/maps/directions?origin=24.8607,67.0011&destination=24.8615,67.0031",
    "hospital_address": "123 Medical Street, City, Country",
    "hospital_phone": "+92-21-123456",
    "instructions": [
      "Bring valid ID/passport",
      "Come 10 minutes early for check-in",
      "Avoid heavy meals 2 hours before donation",
      "Stay hydrated before appointment",
      "Wear comfortable, loose-fitting clothes"
    ],
    "reminder_scheduled": true,
    "reminders": {
      "email_24h": true,
      "sms_1h": true,
      "push_notification_on_day": true
    },
    "points_reward": 50,
    "created_at": "2026-04-29T15:22:00Z",
    "appointment_at": "2026-04-30T09:00:00Z"
  }
}
```

**What the backend should do:**
1. ✅ Check user token is valid
2. ✅ Verify slot exists and is available
3. ✅ Check donor eligibility (age, last donation date, health status)
4. ✅ Check blood type matches
5. ✅ Create appointment record in database
6. ✅ Decrement slot available seats
7. ✅ Generate unique confirmation code
8. ✅ Schedule reminder notifications (24h, 1h, on-day)
9. ✅ Award 50 points to donor
10. ✅ Send confirmation email/SMS/push
11. ✅ Log activity for audit trail
12. ✅ Return confirmation details

**What you do with response in UI:**
- Show Step 5: Confirmation screen
- Display confirmation code (copy-able)
- Show hospital details
- Show appointment date/time
- Show directions link
- Show instructions
- Ask user to mark reminder or add to calendar

---

#### **3. Cancel Appointment**

**Endpoint:**
```http
DELETE /api/v1/donations/book-appointment/{appointment_id}
Authorization: Bearer {token}
Content-Type: application/json

Body (optional):
{
  "reason": "Schedule conflict"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "550e8400-e29b-41d4-a716-446655440010",
    "status": "cancelled",
    "cancelled_at": "2026-04-29T15:25:00Z",
    "refund_points": 50,
    "message": "Appointment cancelled. 50 points refunded to your account."
  }
}
```

**Rules:**
- Can only cancel if > 24 hours before appointment
- Within 24 hours = cannot cancel (call hospital instead)
- Refund any awarded points
- Free up slot for others
- Send cancellation confirmation

---

#### **4. Reschedule Appointment**

**Endpoint:**
```http
PUT /api/v1/donations/book-appointment/{appointment_id}
Authorization: Bearer {token}
Content-Type: application/json

Body:
{
  "slot_id": "550e8400-e29b-41d4-a716-446655440005",
  "hospital_id": "550e8400-e29b-41d4-a716-446655440000" (optional)
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "550e8400-e29b-41d4-a716-446655440010",
    "new_date": "2026-05-01",
    "new_time": "14:00-14:30",
    "status": "rescheduled",
    "old_appointment_date": "2026-04-30",
    "old_appointment_time": "09:00-09:30",
    "message": "Appointment rescheduled successfully"
  }
}
```

**Rules:**
- Can only reschedule if > 12 hours before
- Check new slot availability
- Release old slot
- Update appointment record
- Reschedule reminders
- Send notification to hospital

---

#### **5. Get My Appointments**

**Endpoint:**
```http
GET /api/v1/donations/my-appointments
Authorization: Bearer {token}
Content-Type: application/json

Query Parameters:
- status: confirmed|cancelled|completed|pending (optional)
- start_date: 2026-04-30 (optional)
- end_date: 2026-05-30 (optional)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointments": [
      {
        "appointment_id": "550e8400-e29b-41d4-a716-446655440010",
        "hospital_name": "City Hospital",
        "hospital_id": "550e8400-e29b-41d4-a716-446655440000",
        "appointment_date": "2026-04-30",
        "appointment_time": "09:00-09:30",
        "blood_type": "O+",
        "status": "confirmed",
        "confirmation_code": "APPT-2026-04-30-001",
        "days_until_appointment": 1,
        "can_cancel": false,
        "can_reschedule": true,
        "hospital_address": "123 Medical Street, City",
        "hospital_phone": "+92-21-123456"
      },
      {
        "appointment_id": "550e8400-e29b-41d4-a716-446655440011",
        "hospital_name": "Central Hospital",
        "hospital_id": "550e8400-e29b-41d4-a716-446655440001",
        "appointment_date": "2026-04-25",
        "appointment_time": "10:00-10:30",
        "blood_type": "O+",
        "status": "completed",
        "points_earned": 50,
        "completion_date": "2026-04-25T10:15:00Z"
      }
    ]
  }
}
```

---

## 🛠️ How to Integrate Backend

### Step 1: Update Your Data Model

```dart
// model/donation_schedule.dart
class DonationSchedule {
  final String? hospitalId;
  final String? slotId;
  final DateTime? appointmentDate;
  final String? appointmentTime;
  final String? bloodType;
  final String? notes;
  final String? contactNumber;
  
  // Add these after booking:
  final String? appointmentId;
  final String? confirmationCode;
  final int? pointsAwarded;
  final DateTime? createdAt;
  
  DonationSchedule({
    this.hospitalId,
    this.slotId,
    this.appointmentDate,
    this.appointmentTime,
    this.bloodType,
    this.notes,
    this.contactNumber,
    this.appointmentId,
    this.confirmationCode,
    this.pointsAwarded,
    this.createdAt,
  });
}
```

### Step 2: Create BLOC Events

```dart
// cubit/donation_schedule_cubit.dart
part of 'donation_schedule_cubit.dart';

abstract class DonationScheduleEvent extends Equatable {
  const DonationScheduleEvent();
}

class GetAvailableSlotsEvent extends DonationScheduleEvent {
  final String hospitalId;
  final String bloodType;
  final DateTime startDate;
  final DateTime? endDate;
  
  const GetAvailableSlotsEvent({
    required this.hospitalId,
    required this.bloodType,
    required this.startDate,
    this.endDate,
  });
}

class BookAppointmentEvent extends DonationScheduleEvent {
  final String hospitalId;
  final String slotId;
  final String bloodType;
  final String? notes;
  final String contactNumber;
  
  const BookAppointmentEvent({...});
}

class CancelAppointmentEvent extends DonationScheduleEvent {
  final String appointmentId;
  final String? reason;
  
  const CancelAppointmentEvent({...});
}
```

### Step 3: Call API in Location Step

```dart
// steps/location_step.dart
class LocationStep extends StatefulWidget {
  @override
  State<LocationStep> createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  @override
  void initState() {
    super.initState();
    // Load hospitals when step loads
    context.read<DonationScheduleCubit>().getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationScheduleCubit, DonationScheduleState>(
      builder: (context, state) {
        if (state is DonationScheduleLoading) {
          return LoadingWidget();
        }
        if (state is DonationScheduleError) {
          return ErrorWidget(message: state.message);
        }
        if (state is HospitalsLoaded) {
          return ListView.builder(
            itemCount: state.hospitals.length,
            itemBuilder: (context, index) {
              final hospital = state.hospitals[index];
              return HospitalCard(
                hospital: hospital,
                onSelect: () {
                  context.read<DonationScheduleCubit>()
                    .selectHospital(hospital.id);
                  widget.nextStep();
                },
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
```

### Step 4: Call API in Date/Time Step

```dart
// steps/date_time_step.dart
void _loadAvailableSlots() async {
  final hospitallId = context.read<DonationScheduleCubit>().state.hospitalId;
  final bloodType = context.read<AuthCubit>().state.user.bloodType;
  
  context.read<DonationScheduleCubit>().getAvailableSlots(
    hospitalId: hospitallId,
    bloodType: bloodType,
    startDate: DateTime.now(),
  );
}

onSlotSelected: (slot) {
  context.read<DonationScheduleCubit>().selectSlot(slot);
  widget.next();
}
```

### Step 5: Call Booking API in Review Step

```dart
// steps/review_and_confirm.dart
void _confirmAppointment() async {
  try {
    final result = await context.read<DonationScheduleCubit>().bookAppointment(
      hospitalId: cubit.state.hospitalId,
      slotId: cubit.state.slotId,
      bloodType: cubit.state.bloodType,
      notes: cubit.state.notes,
      contactNumber: cubit.state.contactNumber,
    );
    
    if (result.success) {
      // Show success screen with confirmation code
      widget.next();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
```

---

## 📊 Complete Flow Diagram

```
Frontend                          Backend
─────────────────────────────────────────────────

Step 1: Select Hospital
    ↓
   GET /hospitals (list all)
    ↓
Display hospitals ← Response
    ↓
Select hospital → hospitalId

Step 2: Select Date & Time
    ↓
   GET /slots?hospital_id=X&blood_type=O+
    ↓
Display available slots ← Response
    ↓
Select slot → slotId, date, time

Step 3: Confirm Details
   (No API call, local validation)

Step 4: Review & Confirm
    ↓
   POST /book-appointment
   {hospitalId, slotId, bloodType, notes, phone}
    ↓
Backend:
  - Verify slot
  - Check eligibility
  - Create appointment
  - Award points
  - Schedule reminders
  - Send confirmation
    ↓
Step 5: Show Confirmation Code ← Response
```

---

## 🎯 Development Checklist

Backend Tasks:
- [ ] Create appointment.service.js
- [ ] Create appointment.controller.js
- [ ] Create appointment.routes.js
- [ ] Create appointment_slots table
- [ ] Create appointments table
- [ ] Implement getAvailableSlots endpoint
- [ ] Implement bookAppointment endpoint
- [ ] Implement cancelAppointment endpoint
- [ ] Implement rescheduleAppointment endpoint
- [ ] Implement getMyAppointments endpoint
- [ ] Add eligibility check (age, last donation date)
- [ ] Add point awarding logic (50 points per booking)
- [ ] Add reminder scheduling (24h, 1h, on-day)
- [ ] Add email/SMS notification
- [ ] Add confirmation code generation
- [ ] Add error handling & validation
- [ ] Add database constraints & indexes
- [ ] Write 30+ test cases
- [ ] Document API responses

Frontend Tasks:
- [ ] Update DonationScheduleCubit with API calls
- [ ] Update LocationStep to load hospitals
- [ ] Update DateTimeStep to load slots
- [ ] Update ReviewStep to call booking API
- [ ] Add error handling in each step
- [ ] Add loading indicators
- [ ] Add success/error SnackBars
- [ ] Test complete flow end-to-end

---

## 📈 Estimated Backend Work

**Time Required:** 3-4 days  
**Complexity:** HIGH  
**Database Tables:** 2 (appointment_slots, appointments)  
**API Endpoints:** 5  
**Integrations:** Email/SMS service, Points system  
**Tests Needed:** 40+ test cases

---

## 🚀 Sample Backend Code

```javascript
// src/services/appointment.service.js
class AppointmentService {
  async getAvailableSlots(hospitalId, startDate, endDate, bloodType) {
    const slots = await AppointmentSlot.findAll({
      where: {
        hospital_id: hospitalId,
        blood_type: bloodType,
        date: {[Op.gte]: startDate, [Op.lte]: endDate},
        active: true
      },
      order: [['date', 'ASC'], ['start_time', 'ASC']]
    });
    
    return slots.map(slot => ({
      slot_id: slot.id,
      date: slot.date,
      time_slot: `${slot.start_time}-${slot.end_time}`,
      capacity: slot.capacity,
      booked_count: slot.booked_count,
      available_seats: slot.capacity - slot.booked_count,
      is_available: slot.booked_count < slot.capacity
    }));
  }

  async bookAppointment(donorId, hospitalId, slotId, bloodType, notes, contactNumber) {
    // 1. Verify slot exists and is available
    const slot = await AppointmentSlot.findByPk(slotId);
    if (!slot || slot.booked_count >= slot.capacity) {
      throw new Error('Slot not available');
    }

    // 2. Check donor eligibility
    const donor = await User.findByPk(donorId);
    const lastDonation = await Donation.findOne({
      where: { donor_id: donorId, status: 'completed' },
      order: [['completed_at', 'DESC']]
    });
    const daysSinceLastDonation = moment().diff(lastDonation?.completed_at, 'days');
    if (daysSinceLastDonation < 56) {
      throw new Error('Must wait 56 days between donations');
    }

    // 3. Create appointment
    const confirmationCode = `APPT-${moment().format('YYYY-MM-DD')}-${Math.random().toString(36).substr(2, 5).toUpperCase()}`;
    const appointment = await Appointment.create({
      id: uuid(),
      donor_id: donorId,
      hospital_id: hospitalId,
      slot_id: slotId,
      blood_type: bloodType,
      notes: notes,
      contact_number: contactNumber,
      status: 'confirmed',
      confirmation_code: confirmationCode
    });

    // 4. Update slot booked count
    await AppointmentSlot.update(
      { booked_count: slot.booked_count + 1 },
      { where: { id: slotId } }
    );

    // 5. Award points
    await RewardPoint.create({
      donor_id: donorId,
      points: 50,
      reason: 'appointment_booking',
      appointment_id: appointment.id
    });

    // 6. Schedule reminders
    await this.scheduleReminders(appointment.id, slot.date, slot.start_time);

    // 7. Send confirmation
    await NotificationService.sendEmail(donor.email, {
      subject: 'Donation Appointment Confirmed',
      template: 'appointment_confirmation',
      data: {confirmationCode, appointmentDate: slot.date}
    });

    return appointment;
  }

  async scheduleReminders(appointmentId, appointmentDate, appointmentTime) {
    const appointmentDateTime = moment(`${appointmentDate} ${appointmentTime}`);
    
    // 24 hours before
    queue.add('send-reminder', {appointmentId}, {
      delay: appointmentDateTime.clone().subtract(24, 'hours').diff(moment())
    });
    
    // 1 hour before
    queue.add('send-reminder', {appointmentId}, {
      delay: appointmentDateTime.clone().subtract(1, 'hours').diff(moment())
    });
    
    // On day
    queue.add('send-reminder', {appointmentId}, {
      delay: appointmentDateTime.clone().startOf('day').diff(moment())
    });
  }
}
```

---

**Status:** Ready for backend development  
**Priority:** CRITICAL (Core feature for app)  
**Next Step:** Create appointment.service.js

