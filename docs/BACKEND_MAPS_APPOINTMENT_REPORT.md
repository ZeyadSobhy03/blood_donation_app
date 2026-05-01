# Backend API Requirements Report
## Maps & Donation Scheduling Features

---

## 📍 PART 1: MAPS IMPLEMENTATION ANALYSIS

### Current Frontend Implementation (maps.dart)

The frontend Maps screen currently implements:

1. **Display Location on Map** ✅
   - Shows hospital location using Google Maps
   - Receives coordinates via navigation arguments
   - Initial camera position at zoom level 16

2. **Open Directions** ✅
   - Launches Google Maps external app
   - Uses direct URL: `https://www.google.com/maps/dir/?api=1&destination=lat,lng`
   - Allows user to navigate to hospital

3. **Share Location** ✅
   - Shares location via SharePlus
   - Generates Google Maps search link
   - Includes coordinates in message

4. **States**
   - MapLoading: Shows loading spinner
   - MapError: Shows error message with SnackBar
   - MapLoaded: Shows map with controls

---

### 🔴 MISSING BACKEND ENDPOINT

**Current Issue:** The frontend launches external Google Maps, but there's **NO internal API endpoint** for:
- Calculating directions
- Getting ETA/travel time
- Finding routes
- Showing multiple hospitals on same map

---

### ✅ BACKEND SOLUTION: Implement `/api/v1/maps/directions`

#### Endpoint 1: Get Directions Between Two Locations

```http
GET /api/v1/maps/directions
Authorization: Bearer {token}
Content-Type: application/json

Query Parameters:
- origin_lat: float (required) - user's latitude
- origin_lng: float (required) - user's longitude
- destination_lat: float (required) - hospital latitude
- destination_lng: float (required) - hospital longitude
- travel_mode: string (optional) - driving|walking|transit (default: driving)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "direction_id": "uuid",
    "origin": {
      "lat": 24.8607,
      "lng": 67.0011,
      "address": "Donor Location, Karachi"
    },
    "destination": {
      "lat": 24.8615,
      "lng": 67.0031,
      "address": "Hospital Name, Karachi"
    },
    "distance_km": 2.5,
    "duration_minutes": 8,
    "estimated_arrival_time": "2026-04-29T15:30:00Z",
    "travel_mode": "driving",
    "polyline": "encoded_polyline_string",
    "steps": [
      {
        "instruction": "Head north on Street Name",
        "distance_meters": 150,
        "duration_seconds": 18
      }
    ]
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

---

#### Endpoint 2: Find Nearby Hospitals with Directions

```http
GET /api/v1/hospitals/nearby
Authorization: Bearer {token}
Content-Type: application/json

Query Parameters:
- latitude: float (required)
- longitude: float (required)
- radius_km: float (default: 5)
- blood_type: string (optional) - filter by blood availability
- sort_by: string (optional) - distance|rating|availability
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user_location": {
      "lat": 24.8607,
      "lng": 67.0011
    },
    "hospitals": [
      {
        "hospital_id": "uuid",
        "name": "Hospital A",
        "latitude": 24.8615,
        "longitude": 67.0031,
        "distance_km": 0.5,
        "duration_minutes": 2,
        "address": "Street, City",
        "phone": "+92-21-123456",
        "blood_available": {
          "O+": 10,
          "O-": 5,
          "A+": 8
        },
        "rating": 4.5,
        "is_accepting_requests": true,
        "urgency_level": "high"
      }
    ]
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

---

### Database Models Needed

#### directions Table
```sql
CREATE TABLE directions (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id),
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  origin_lat FLOAT NOT NULL,
  origin_lng FLOAT NOT NULL,
  destination_lat FLOAT NOT NULL,
  destination_lng FLOAT NOT NULL,
  distance_km FLOAT,
  duration_minutes INT,
  travel_mode VARCHAR(20) DEFAULT 'driving',
  polyline TEXT,
  route_json JSON,
  created_at TIMESTAMP DEFAULT NOW(),
  expires_at TIMESTAMP
);

CREATE INDEX idx_directions_user_id ON directions(user_id);
CREATE INDEX idx_directions_hospital_id ON directions(hospital_id);
```

---

### Backend Services Needed

#### 1. **MapsService** (New)
```javascript
// src/services/maps.service.js

class MapsService {
  // Integration with Google Maps API
  async getDirections(originLat, originLng, destLat, destLng, travelMode = 'driving') {
    // Call Google Maps Directions API
    // Parse response
    // Extract: distance, duration, polyline, steps
    // Cache result
  }

  async calculateETA(originLat, originLng, destLat, destLng) {
    // Get estimated time of arrival
  }

  async getNearbyHospitals(userLat, userLng, radiusKm, filters = {}) {
    // Query hospitals within radius
    // Calculate distance to each
    // Get directions for top 5
    // Filter by blood availability
    // Sort by distance/rating
  }

  async reverseGeocode(lat, lng) {
    // Convert coordinates to address
  }

  async saveDirectionHistory(userId, hospitalId, directionData) {
    // Save for analytics
  }
}
```

---

### Backend Routes Needed

```javascript
// src/routes/maps.routes.js
router.get('/directions', authenticate, getMapsController.getDirections);
router.get('/hospitals/nearby', authenticate, getMapsController.getNearbyHospitals);
router.post('/save-route', authenticate, getMapsController.saveRoute);

// In src/app.js
app.use('/api/v1/maps', mapsRoutes);
app.use('/api/v1/hospitals/nearby', mapsRoutes);
```

---

### External Integration

**Google Maps API Setup Required:**
- Enable: Directions API
- Enable: Maps SDK
- Enable: Geocoding API
- Set API key in environment variables

```env
GOOGLE_MAPS_API_KEY=your_api_key_here
GOOGLE_MAPS_API_TIMEOUT=5000
MAPS_CACHE_TTL=900 // 15 minutes
```

---

## 📅 PART 2: SCHEDULE DONATION APPOINTMENT

### Current Status
**Frontend:** Maps screen exists but no appointment booking UI ❌  
**Backend:** No appointment booking endpoint ❌  
**Database:** No appointment models ❌

---

### ✅ BACKEND SOLUTION: Implement Appointment Booking

#### Endpoint 1: Get Available Appointment Slots

```http
GET /api/v1/donations/book-appointment/slots
Authorization: Bearer {token}
Content-Type: application/json

Query Parameters:
- hospital_id: uuid (required)
- start_date: date (format: YYYY-MM-DD, required)
- end_date: date (format: YYYY-MM-DD, optional - default: 7 days)
- blood_type: string (required) - A+, B+, O+, AB+, etc
```

**Response:**
```json
{
  "success": true,
  "data": {
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "blood_type": "O+",
    "available_slots": [
      {
        "slot_id": "uuid",
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
        "slot_id": "uuid",
        "date": "2026-04-30",
        "time_slot": "10:00-10:30",
        "start_time": "10:00",
        "end_time": "10:30",
        "capacity": 5,
        "booked_count": 5,
        "available_seats": 0,
        "is_available": false
      }
    ]
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

---

#### Endpoint 2: Book Appointment

```http
POST /api/v1/donations/book-appointment
Authorization: Bearer {token}
Content-Type: application/json

Body:
{
  "hospital_id": "uuid",
  "slot_id": "uuid",
  "blood_type": "O+",
  "notes": "Available after 5 PM (optional)",
  "contact_number": "+92-300-1234567"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "uuid",
    "donor_id": "uuid",
    "hospital_id": "uuid",
    "hospital_name": "Hospital A",
    "appointment_date": "2026-04-30",
    "appointment_time": "09:00-09:30",
    "blood_type_needed": "O+",
    "status": "confirmed",
    "confirmation_code": "APPT-2026-04-30-001",
    "directions_url": "https://api.example.com/api/v1/maps/directions?...",
    "hospital_address": "Street, City, Country",
    "hospital_phone": "+92-21-123456",
    "instructions": [
      "Bring valid ID",
      "Come 10 minutes early",
      "Avoid heavy meals 2 hours before"
    ],
    "reminder_scheduled": true,
    "created_at": "2026-04-29T15:22:00Z",
    "appointment_at": "2026-04-30T09:00:00Z"
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

---

#### Endpoint 3: Cancel Appointment

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
    "appointment_id": "uuid",
    "status": "cancelled",
    "cancelled_at": "2026-04-29T15:25:00Z",
    "refund_points": 50,
    "message": "Appointment cancelled. 50 points refunded."
  },
  "timestamp": "2026-04-29T15:25:00Z"
}
```

---

#### Endpoint 4: Reschedule Appointment

```http
PUT /api/v1/donations/book-appointment/{appointment_id}
Authorization: Bearer {token}
Content-Type: application/json

Body:
{
  "slot_id": "new_uuid",
  "hospital_id": "uuid" (optional - same hospital if not provided)
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointment_id": "uuid",
    "new_date": "2026-05-01",
    "new_time": "14:00-14:30",
    "status": "rescheduled",
    "old_appointment_date": "2026-04-30",
    "old_appointment_time": "09:00-09:30",
    "message": "Appointment rescheduled successfully"
  },
  "timestamp": "2026-04-29T15:25:00Z"
}
```

---

#### Endpoint 5: Get My Appointments

```http
GET /api/v1/donations/my-appointments
Authorization: Bearer {token}
Content-Type: application/json

Query Parameters:
- status: string (optional) - confirmed|cancelled|completed|pending
- start_date: date (optional)
- end_date: date (optional)
```

**Response:**
```json
{
  "success": true,
  "data": {
    "appointments": [
      {
        "appointment_id": "uuid",
        "hospital_name": "Hospital A",
        "hospital_id": "uuid",
        "appointment_date": "2026-04-30",
        "appointment_time": "09:00-09:30",
        "blood_type": "O+",
        "status": "confirmed",
        "confirmation_code": "APPT-2026-04-30-001",
        "days_until_appointment": 1,
        "can_cancel": true,
        "can_reschedule": true
      }
    ],
    "total_count": 5,
    "upcoming_count": 1,
    "completed_count": 3,
    "cancelled_count": 1
  },
  "timestamp": "2026-04-29T15:22:00Z"
}
```

---

### Database Models Needed

#### appointments Table
```sql
CREATE TABLE appointments (
  id UUID PRIMARY KEY,
  donor_id UUID NOT NULL REFERENCES users(id),
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  appointment_slot_id UUID NOT NULL REFERENCES appointment_slots(id),
  blood_type_needed VARCHAR(10) NOT NULL,
  status VARCHAR(50) DEFAULT 'confirmed' 
    CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled', 'no-show')),
  confirmation_code VARCHAR(50) UNIQUE NOT NULL,
  donor_notes TEXT,
  contact_number VARCHAR(20),
  appointment_date DATE NOT NULL,
  appointment_time_start TIME NOT NULL,
  appointment_time_end TIME NOT NULL,
  reminder_sent BOOLEAN DEFAULT false,
  reminder_sent_at TIMESTAMP,
  cancellation_reason TEXT,
  cancelled_at TIMESTAMP,
  completed_at TIMESTAMP,
  points_awarded INT DEFAULT 50,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  expires_at TIMESTAMP
);

CREATE INDEX idx_appointments_donor_id ON appointments(donor_id);
CREATE INDEX idx_appointments_hospital_id ON appointments(hospital_id);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_appointments_appointment_date ON appointments(appointment_date);
```

#### appointment_slots Table
```sql
CREATE TABLE appointment_slots (
  id UUID PRIMARY KEY,
  hospital_id UUID NOT NULL REFERENCES hospitals(id),
  appointment_date DATE NOT NULL,
  time_slot_start TIME NOT NULL,
  time_slot_end TIME NOT NULL,
  capacity INT NOT NULL DEFAULT 5,
  booked_count INT DEFAULT 0,
  blood_type_needed VARCHAR(10),
  is_available BOOLEAN DEFAULT true,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_appointment_slots_hospital_id ON appointment_slots(hospital_id);
CREATE INDEX idx_appointment_slots_date ON appointment_slots(appointment_date);
CREATE INDEX idx_appointment_slots_available ON appointment_slots(is_available);
```

#### appointment_reminders Table
```sql
CREATE TABLE appointment_reminders (
  id UUID PRIMARY KEY,
  appointment_id UUID NOT NULL REFERENCES appointments(id),
  reminder_type VARCHAR(50) DEFAULT '24_hours_before'
    CHECK (reminder_type IN ('24_hours_before', '1_hour_before', 'on_day', 'custom')),
  scheduled_at TIMESTAMP NOT NULL,
  sent_at TIMESTAMP,
  notification_channel VARCHAR(50) DEFAULT 'push'
    CHECK (notification_channel IN ('push', 'sms', 'email')),
  is_sent BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_appointment_reminders_appointment_id ON appointment_reminders(appointment_id);
CREATE INDEX idx_appointment_reminders_scheduled_at ON appointment_reminders(scheduled_at);
```

---

### Backend Services Needed

#### 1. **AppointmentService** (New)
```javascript
// src/services/appointment.service.js

class AppointmentService {
  async getAvailableSlots(hospitalId, startDate, endDate, bloodType) {
    // Query appointment_slots
    // Filter by hospital, date range, blood type
    // Calculate available seats
    // Return sorted slots
  }

  async bookAppointment(donorId, hospitalId, slotId, bloodType, notes) {
    // Check donor eligibility
    // Check slot availability
    // Create appointment record
    // Update slot booked_count
    // Generate confirmation code
    // Schedule reminders
    // Award initial points
    // Send confirmation notification
  }

  async cancelAppointment(appointmentId, reason) {
    // Check if can cancel (not within 24 hours)
    // Update status to cancelled
    // Free up slot
    // Refund any awarded points
    // Send cancellation notification
  }

  async rescheduleAppointment(appointmentId, newSlotId) {
    // Check new slot availability
    // Cancel old appointment
    // Book new appointment
    // Send rescheduling notification
  }

  async getMyAppointments(donorId, filters) {
    // Get all appointments for donor
    // Apply status/date filters
    // Calculate days_until_appointment
    // Determine can_cancel and can_reschedule
  }

  async updateAppointmentStatus(appointmentId, newStatus) {
    // Update appointment status
    // If completed: award points, update donor stats
    // If no-show: penalize points, flag donor
  }

  async sendAppointmentReminders() {
    // Cron job: find upcoming appointments
    // Send notifications based on schedule
    // Update reminder_sent flag
  }
}
```

#### 2. **SlotManagementService** (New)
```javascript
// src/services/slot.service.js

class SlotManagementService {
  async createSlots(hospitalId, slotData) {
    // Create appointment slots for hospital
    // Bulk create for recurring slots
    // Validate capacity and timing
  }

  async updateSlotAvailability(slotId, isAvailable) {
    // Enable/disable slot
    // Used by hospital staff
  }

  async getSlotCapacityStatus(hospitalId, date) {
    // Get capacity info for date
    // Calculate occupancy percentage
  }

  async cleanupExpiredSlots() {
    // Cron job: remove past slots
  }
}
```

---

### Backend Routes Needed

```javascript
// src/routes/appointment.routes.js
router.get('/slots', authenticate, appointmentController.getAvailableSlots);
router.post('/book', authenticate, appointmentController.bookAppointment);
router.delete('/:appointmentId', authenticate, appointmentController.cancelAppointment);
router.put('/:appointmentId', authenticate, appointmentController.rescheduleAppointment);
router.get('/my-appointments', authenticate, appointmentController.getMyAppointments);
router.get('/:appointmentId', authenticate, appointmentController.getAppointmentDetails);

// In src/app.js
app.use('/api/v1/donations/book-appointment', appointmentRoutes);
```

---

### Donation Appointment Flow (Complete)

```
Donor Opens App
    ↓
Select Hospital
    ↓
Request: GET /api/v1/donations/book-appointment/slots
    ↓
Response: Available slots with times
    ↓
Donor Selects Slot
    ↓
Request: POST /api/v1/donations/book-appointment
    ↓
Backend:
  1. Check donor eligibility
  2. Create appointment record
  3. Schedule reminders (24h, 1h, on-day)
  4. Award 50 points
  5. Send confirmation SMS/Email/Push
    ↓
Response: Confirmation code + directions
    ↓
Reminders Sent:
  - 24 hours before
  - 1 hour before
  - On appointment day
    ↓
Appointment Day:
  - Donor goes to hospital
  - Hospital staff marks complete
  - Donation recorded
  - Points finalized
    ↓
Request: POST /api/v1/donations/complete
    ↓
Completion:
  1. Update appointment status
  2. Record donation
  3. Update donor stats
  4. Award bonus points
  5. Send thank you notification
```

---

## 📊 COMBINED IMPLEMENTATION CHECKLIST

### Phase 1: Setup (Week 1)
- [ ] Create `directions` table
- [ ] Create `appointments` table
- [ ] Create `appointment_slots` table
- [ ] Create `appointment_reminders` table
- [ ] Setup Google Maps API credentials
- [ ] Environment variables configuration

### Phase 2: Maps API (Week 2)
- [ ] Create `MapsService`
- [ ] Create `maps.controller.js`
- [ ] Create `maps.routes.js`
- [ ] Implement `/api/v1/maps/directions`
- [ ] Implement `/api/v1/hospitals/nearby`
- [ ] Add caching layer
- [ ] Add unit tests

### Phase 3: Appointment Booking (Week 3-4)
- [ ] Create `AppointmentService`
- [ ] Create `SlotManagementService`
- [ ] Create `appointment.controller.js`
- [ ] Create `appointment.routes.js`
- [ ] Implement all 5 appointment endpoints
- [ ] Create notification service integration
- [ ] Setup cron jobs for reminders
- [ ] Add validation & eligibility checks
- [ ] Add unit tests

### Phase 4: Frontend Integration (Week 5)
- [ ] Update maps.dart with API calls
- [ ] Create appointment booking UI
- [ ] Create appointment list screen
- [ ] Add appointment reminders (local)
- [ ] Add directions integration
- [ ] Testing & bug fixes

### Phase 5: Testing & Deployment (Week 6)
- [ ] Load testing (1000 concurrent)
- [ ] Security audit
- [ ] Performance optimization
- [ ] Documentation
- [ ] Production deployment

---

## 🔑 Key Requirements Summary

| Feature | Endpoints | Tables | Complexity |
|---------|-----------|--------|-----------|
| **Maps & Directions** | 2 | 1 | Medium |
| **Appointment Booking** | 5 | 3 | High |
| **Total** | **7** | **4** | **Hard** |

---

## 💾 Data Storage

```
appointments: ~100k records per year per hospital
appointment_slots: ~5k-10k active slots per hospital
appointment_reminders: ~300k records per year
directions: ~50k-100k lookups per month (with caching)
```

---

## 🎯 Success Metrics

- Appointment booking completion rate: > 95%
- Maps API response time: < 500ms
- Reminder delivery rate: > 99%
- No-show rate: < 5%
- Rescheduling rate: < 10%
- User satisfaction: > 4.5/5 stars

