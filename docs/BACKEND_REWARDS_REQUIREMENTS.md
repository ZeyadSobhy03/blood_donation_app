# Backend Requirements Report - Donor Rewards System

**Document Version:** 1.0  
**Date:** April 26, 2026  
**Prepared For:** Backend Development Team  
**Status:** Complete Feature Specification

---

## 1. Executive Summary

This document outlines the backend requirements for implementing the **Donor Rewards & Achievements** system for the Blood Donation App. The system manages user points, redeemable rewards, and achievement badges for donors.

### Key Features:
- ✅ Points Management System
- ✅ Rewards Catalog & Redemption
- ✅ Achievement Badges System
- ✅ Points History & Tracking
- ✅ User Achievements Tracking

---

## 2. Data Models & Database Schema

### 2.1 User Points Account

```json
{
  "user_id": "string (uuid)",
  "total_points": "integer",
  "points_balance": "integer",
  "lifetime_points_earned": "integer",
  "last_updated": "timestamp",
  "tier_level": "string (bronze, silver, gold, platinum)"
}
```

**Database Table:** `user_points_accounts`

**Indexes:** `user_id (PRIMARY)`, `last_updated`

---

### 2.2 Points History/Transactions Log

```json
{
  "transaction_id": "string (uuid)",
  "user_id": "string (uuid)",
  "points_amount": "integer (positive for earned, negative for redeemed)",
  "transaction_type": "enum",
  "description": "string",
  "reference_id": "string (donation_id, redeem_id, etc.)",
  "created_at": "timestamp",
  "updated_at": "timestamp"
}
```

**Database Table:** `points_transactions`

**Indexes:** `user_id`, `created_at`, `transaction_type`

**Transaction Types:**
- `BLOOD_DONATION` - Points earned from blood donation (200 points)
- `EMERGENCY_RESPONSE` - Points earned from emergency response (100 points)
- `PROFILE_COMPLETION` - Points earned from profile completion (50 points)
- `REFERRAL_BONUS` - Points earned from referral (150 points)
- `REWARD_REDEEMED` - Points deducted from reward redemption
- `ADMIN_ADJUSTMENT` - Admin-granted or revoked points
- `TIER_BONUS` - Points from tier promotion bonus
- `FIRST_DONATION` - Bonus for first donation (100 points)

---

### 2.3 Rewards Catalog

```json
{
  "reward_id": "string (uuid)",
  "name": "string",
  "description": "string",
  "points_cost": "integer",
  "category": "string",
  "icon_type": "string",
  "color_code": "string (hex)",
  "status": "enum (ACTIVE, INACTIVE, LIMITED)",
  "daily_limit": "integer (null if unlimited)",
  "monthly_limit": "integer (null if unlimited)",
  "partner_id": "string (uuid) (nullable)",
  "redemption_count": "integer",
  "created_at": "timestamp",
  "updated_at": "timestamp"
}
```

**Database Table:** `rewards_catalog`

**Indexes:** `reward_id (PRIMARY)`, `status`, `category`

**Predefined Rewards (From UI):**
| Name | Cost | Category | Partner Integration |
|------|------|----------|-------------------|
| Coffee Voucher | 500 pts | Food & Beverage | Required |
| Movie Tickets | 1000 pts | Entertainment | Required |
| Restaurant Gift Card | 1500 pts | Food & Beverage | Required |
| Health Check-up | 2000 pts | Health & Wellness | Required |
| Premium Badge | 2500 pts | Status | Internal |
| Gym Membership | 3000 pts | Health & Wellness | Required |

---

### 2.4 Reward Redemptions

```json
{
  "redemption_id": "string (uuid)",
  "user_id": "string (uuid)",
  "reward_id": "string (uuid)",
  "points_spent": "integer",
  "redemption_status": "enum",
  "confirmation_code": "string (unique)",
  "delivery_method": "enum (EMAIL, SMS, IN_APP, PARTNER_PORTAL)",
  "delivery_details": "object",
  "redeemed_at": "timestamp",
  "expires_at": "timestamp (nullable)",
  "created_at": "timestamp",
  "updated_at": "timestamp"
}
```

**Database Table:** `reward_redemptions`

**Indexes:** `user_id`, `reward_id`, `redemption_status`, `redeemed_at`

**Redemption Status Values:**
- `PENDING` - Awaiting confirmation
- `CONFIRMED` - Successfully redeemed
- `DELIVERED` - Delivered to user
- `CANCELLED` - Cancelled by user
- `EXPIRED` - Reward expired

---

### 2.5 Achievement Badges System

```json
{
  "badge_id": "string (uuid)",
  "badge_name": "string",
  "badge_description": "string",
  "badge_icon": "string",
  "category": "enum (DONATION, EMERGENCY, ENGAGEMENT, SOCIAL)",
  "unlock_condition": "object",
  "unlock_threshold": "integer",
  "points_reward": "integer (bonus points when unlocked)",
  "rarity": "enum (COMMON, RARE, EPIC, LEGENDARY)",
  "created_at": "timestamp"
}
```

**Database Table:** `badge_definitions`

**Indexes:** `badge_id (PRIMARY)`, `category`, `rarity`

**Predefined Badges (From UI):**
| Badge Name | Unlock Condition | Threshold | Rarity |
|------------|-------------------|-----------|--------|
| First Timer | First Donation | 1 | Common |
| Regular Donor | Donations Completed | 5 | Common |
| Life Saver | Donations Completed | 10 | Rare |
| Hero | Donations Completed | 20 | Epic |
| Legend | Donations Completed | 50 | Legendary |
| Emergency Responder | Emergency Responses | 10 | Epic |
| Social Butterfly | Referrals Made | 5 | Common |
| Community Helper | Emergency Responses | 25 | Legendary |

---

### 2.6 User Achievements/Badge Progress

```json
{
  "user_badge_id": "string (uuid)",
  "user_id": "string (uuid)",
  "badge_id": "string (uuid)",
  "unlock_status": "enum (LOCKED, UNLOCKED, COMPLETED)",
  "progress_current": "integer",
  "progress_target": "integer",
  "unlocked_at": "timestamp (nullable)",
  "created_at": "timestamp"
}
```

**Database Table:** `user_badges`

**Indexes:** `user_id`, `badge_id`, `unlock_status`

---

## 3. API Endpoints Specification

### 3.1 Points Management

#### GET `/api/v1/donor/points`
**Description:** Retrieve user's current points information

**Request:**
```http
GET /api/v1/donor/points
Authorization: Bearer {token}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "user_id": "uuid",
    "total_points": 2340,
    "points_balance": 2340,
    "lifetime_points_earned": 5000,
    "next_tier": "silver",
    "points_to_next_tier": 660,
    "current_tier": "bronze",
    "tier_benefits": {
      "bronze": ["5% bonus on redemptions"],
      "silver": ["10% bonus on redemptions", "Early access to rewards"],
      "gold": ["15% bonus on redemptions", "Exclusive rewards"],
      "platinum": ["20% bonus on redemptions", "VIP support"]
    }
  }
}
```

#### GET `/api/v1/donor/points/history`
**Description:** Retrieve points transaction history (paginated)

**Request:**
```http
GET /api/v1/donor/points/history?page=1&limit=20&filter=ALL
Authorization: Bearer {token}
```

**Query Parameters:**
- `page`: integer (default: 1)
- `limit`: integer (default: 20, max: 100)
- `filter`: enum (ALL, EARNED, REDEEMED, ADJUSTMENTS) (default: ALL)
- `date_from`: ISO 8601 timestamp (optional)
- `date_to`: ISO 8601 timestamp (optional)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "transactions": [
      {
        "transaction_id": "uuid",
        "points_amount": 200,
        "transaction_type": "BLOOD_DONATION",
        "description": "Blood Donation - Successful",
        "reference_id": "donation_123",
        "created_at": "2024-04-20T10:30:00Z"
      },
      {
        "transaction_id": "uuid",
        "points_amount": 100,
        "transaction_type": "EMERGENCY_RESPONSE",
        "description": "Emergency Response - A+ Required",
        "reference_id": "request_456",
        "created_at": "2024-04-13T15:45:00Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 5,
      "total_items": 100,
      "has_next": true
    }
  }
}
```

---

### 3.2 Rewards Management

#### GET `/api/v1/rewards`
**Description:** Retrieve all available rewards

**Request:**
```http
GET /api/v1/rewards?category=ALL&status=ACTIVE
Authorization: Bearer {token}
```

**Query Parameters:**
- `category`: enum (ALL, FOOD, ENTERTAINMENT, HEALTH, STATUS) (default: ALL)
- `status`: enum (ACTIVE, INACTIVE, LIMITED) (default: ACTIVE)
- `sort_by`: enum (COST_ASC, COST_DESC, POPULARITY) (default: COST_ASC)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "rewards": [
      {
        "reward_id": "uuid",
        "name": "Coffee Voucher",
        "description": "Free coffee at partner cafes",
        "points_cost": 500,
        "category": "FOOD",
        "icon_type": "coffee",
        "color_code": "#FF6B6B",
        "status": "ACTIVE",
        "redemption_count": 150,
        "available": true,
        "daily_limit": null,
        "monthly_limit": null
      },
      {
        "reward_id": "uuid",
        "name": "Movie Tickets",
        "description": "2 movie tickets at major cinemas",
        "points_cost": 1000,
        "category": "ENTERTAINMENT",
        "icon_type": "movie",
        "color_code": "#FF6B6B",
        "status": "ACTIVE",
        "redemption_count": 85,
        "available": true,
        "daily_limit": 5,
        "monthly_limit": 50
      }
    ],
    "filter_options": {
      "categories": ["FOOD", "ENTERTAINMENT", "HEALTH", "STATUS"],
      "min_cost": 500,
      "max_cost": 3000
    }
  }
}
```

#### POST `/api/v1/rewards/{reward_id}/redeem`
**Description:** Redeem a reward using points

**Request:**
```http
POST /api/v1/rewards/{reward_id}/redeem
Authorization: Bearer {token}
Content-Type: application/json

{
  "quantity": 1,
  "delivery_preference": "EMAIL",
  "delivery_contact": "user@email.com"
}
```

**Validation Rules:**
- User must have sufficient points
- Reward must be ACTIVE
- Daily/monthly limits must not be exceeded
- Reward must not be expired

**Response (200):**
```json
{
  "success": true,
  "data": {
    "redemption_id": "uuid",
    "confirmation_code": "RWD-2024-ABC123",
    "reward_name": "Coffee Voucher",
    "points_spent": 500,
    "remaining_points": 1840,
    "redemption_status": "CONFIRMED",
    "delivery_method": "EMAIL",
    "delivery_details": {
      "sent_to": "user@email.com",
      "sent_at": "2024-04-26T12:00:00Z"
    },
    "expires_at": "2024-05-26T23:59:59Z",
    "message": "Reward redeemed successfully! Check your email for details."
  }
}
```

**Response (400):**
```json
{
  "success": false,
  "error": {
    "code": "INSUFFICIENT_POINTS",
    "message": "You need 500 points to redeem this reward. You have 350 points.",
    "user_points": 350,
    "required_points": 500,
    "shortfall": 150
  }
}
```

#### GET `/api/v1/donor/redemptions`
**Description:** Retrieve user's redemption history

**Request:**
```http
GET /api/v1/donor/redemptions?status=ALL&page=1&limit=20
Authorization: Bearer {token}
```

**Query Parameters:**
- `status`: enum (ALL, PENDING, CONFIRMED, DELIVERED, CANCELLED, EXPIRED) (default: ALL)
- `page`: integer (default: 1)
- `limit`: integer (default: 20, max: 100)

**Response (200):**
```json
{
  "success": true,
  "data": {
    "redemptions": [
      {
        "redemption_id": "uuid",
        "reward_name": "Coffee Voucher",
        "confirmation_code": "RWD-2024-ABC123",
        "points_spent": 500,
        "status": "DELIVERED",
        "delivery_method": "EMAIL",
        "redeemed_at": "2024-04-20T10:30:00Z",
        "expires_at": "2024-05-20T23:59:59Z"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 3,
      "total_items": 45
    }
  }
}
```

---

### 3.3 Badges & Achievements

#### GET `/api/v1/donor/badges`
**Description:** Retrieve all badges and user's progress

**Request:**
```http
GET /api/v1/donor/badges
Authorization: Bearer {token}
```

**Response (200):**
```json
{
  "success": true,
  "data": {
    "unlocked_count": 3,
    "total_count": 8,
    "completion_percentage": 37.5,
    "badges": [
      {
        "badge_id": "uuid",
        "badge_name": "First Timer",
        "badge_description": "Completed your first blood donation",
        "badge_icon": "heart",
        "category": "DONATION",
        "rarity": "COMMON",
        "unlock_status": "UNLOCKED",
        "unlocked_at": "2024-01-15T08:00:00Z",
        "progress_current": 1,
        "progress_target": 1,
        "progress_percentage": 100
      },
      {
        "badge_id": "uuid",
        "badge_name": "Regular Donor",
        "badge_description": "Completed 5 blood donations",
        "badge_icon": "trophy",
        "category": "DONATION",
        "rarity": "COMMON",
        "unlock_status": "UNLOCKED",
        "unlocked_at": "2024-02-20T08:00:00Z",
        "progress_current": 5,
        "progress_target": 5,
        "progress_percentage": 100
      },
      {
        "badge_id": "uuid",
        "badge_name": "Life Saver",
        "badge_description": "Completed 10 blood donations",
        "badge_icon": "star",
        "category": "DONATION",
        "rarity": "RARE",
        "unlock_status": "UNLOCKED",
        "unlocked_at": "2024-03-25T08:00:00Z",
        "progress_current": 10,
        "progress_target": 10,
        "progress_percentage": 100
      },
      {
        "badge_id": "uuid",
        "badge_name": "Hero",
        "badge_description": "Completed 20 blood donations",
        "badge_icon": "badge",
        "category": "DONATION",
        "rarity": "EPIC",
        "unlock_status": "LOCKED",
        "progress_current": 10,
        "progress_target": 20,
        "progress_percentage": 50
      }
    ],
    "stats": {
      "total_donations": 10,
      "total_emergency_responses": 3,
      "total_referrals": 2,
      "days_as_donor": 101
    }
  }
}
```

---

## 4. Points Earning Rules

### 4.1 Points Allocation Rules

**Current Implementation Rules:**

| Activity | Points | Conditions | Frequency |
|----------|--------|-----------|-----------|
| Blood Donation | 200 | Successful completion | Per donation |
| Emergency Response | 100 | Accept & respond to emergency | Per response |
| Profile Completion | 50 | Complete all profile fields | One-time |
| Referral Bonus | 150 | Referred person donates blood | Per successful referral |
| First Donation | 100 | (Bonus on top of 200) | One-time |
| Tier Promotion Bonus | 50-500 | Advancing to higher tier | Per tier promotion |

### 4.2 Business Rules

1. **Points Expiration:** Points never expire (no TTL)
2. **Negative Points:** Cannot reduce balance below 0
3. **Duplicate Prevention:** Verify transaction uniqueness using `reference_id`
4. **Concurrent Redemption:** Implement pessimistic locking on `user_points_accounts`
5. **Points Audit Trail:** All transactions must be logged immutably
6. **Tier Progression:**
   - Bronze: 0-999 points
   - Silver: 1000-2499 points
   - Gold: 2500-4999 points
   - Platinum: 5000+ points

---

## 5. Integration Requirements

### 5.1 External Integrations (Partner APIs)

The following rewards require integration with external partners:

#### Coffee Voucher & Restaurant Gift Cards
- **Partner Integration:** Coffee shop chains, restaurant platforms
- **Requirements:**
  - API to generate unique voucher codes
  - Expiration management
  - Redemption verification endpoint
  - Real-time inventory tracking

#### Movie Tickets
- **Partner Integration:** Cinema chains, ticketing platforms
- **Requirements:**
  - Real-time seat availability
  - Booking confirmation API
  - QR code generation
  - Show timing availability

#### Health Check-up
- **Partner Integration:** Healthcare providers, diagnostic centers
- **Requirements:**
  - Appointment booking API
  - Center availability calendar
  - Voucher validation
  - Completion confirmation

#### Gym Membership
- **Partner Integration:** Gym chains, fitness platforms
- **Requirements:**
  - Membership creation API
  - Duration management (3, 6, 12 months)
  - Center directory with locations
  - Activation verification

---

## 6. Event Triggers & Webhooks

### 6.1 Internal Event Triggers

Implement event system to award points automatically:

```json
{
  "event_types": [
    {
      "event": "DONATION_COMPLETED",
      "points_awarded": 200,
      "trigger_source": "Donation Service"
    },
    {
      "event": "EMERGENCY_REQUEST_ACCEPTED",
      "points_awarded": 100,
      "trigger_source": "Emergency Request Service"
    },
    {
      "event": "PROFILE_COMPLETED",
      "points_awarded": 50,
      "trigger_source": "User Service"
    },
    {
      "event": "REFERRAL_DONATION_COMPLETED",
      "points_awarded": 150,
      "trigger_source": "Donation Service + Referral Service"
    },
    {
      "event": "BADGE_UNLOCKED",
      "points_awarded": "varies",
      "trigger_source": "Badges Service"
    }
  ]
}
```

### 6.2 Webhook Events

**Outbound webhooks for external partner integrations:**

```http
POST /partner-webhooks/reward-redeemed
Content-Type: application/json

{
  "event": "REWARD_REDEEMED",
  "timestamp": "2024-04-26T12:00:00Z",
  "data": {
    "user_id": "uuid",
    "reward_id": "uuid",
    "confirmation_code": "RWD-2024-ABC123",
    "delivery_details": {
      "contact_info": "user@email.com",
      "delivery_method": "EMAIL"
    }
  }
}
```

---

## 7. Backend Service Architecture

### 7.1 Microservices/Components Required

1. **Points Service**
   - Manages user points accounts
   - Tracks points transactions
   - Calculates tier levels
   - Triggers points-related events

2. **Rewards Service**
   - Manages rewards catalog
   - Handles redemption workflow
   - Tracks redemption history
   - Integrates with partner APIs

3. **Badges Service**
   - Manages badge definitions
   - Tracks user progress
   - Unlocks badges automatically
   - Listens to event triggers

4. **Event Service** (if not using message queue)
   - Publishes points events
   - Listens for donation/emergency events
   - Coordinates between services

5. **Notification Service**
   - Sends reward redemption confirmations
   - Sends badge unlock notifications
   - Sends points milestone notifications

---

## 8. Security & Validation Requirements

### 8.1 Input Validation

```
- User ID: UUID format validation
- Points amount: Positive integer, < 1,000,000
- Reward ID: Existing reward in database
- Confirmation code: Unique, alphanumeric
- Delivery contact: Valid email/phone format
```

### 8.2 Authorization

```
- Users can only view/modify their own points
- Admin only: Manual point adjustments
- Admin only: Reward status management
- Admin only: Badge definition management
```

### 8.3 Rate Limiting

```
- Points history: 100 requests/hour per user
- Redemptions: 20 requests/hour per user
- Badge retrieval: 50 requests/hour per user
```

### 8.4 Data Protection

```
- Encrypt sensitive reward delivery details (email, phone)
- Audit all point modifications (admin changes)
- Implement database row-level security
- Regular backup of transactions table
```

---

## 9. Performance Requirements

### 9.1 Query Performance Targets

| Query | Target | Notes |
|-------|--------|-------|
| Get user points | < 100ms | Cache for 5 mins |
| List points history (100 items) | < 500ms | Paginated |
| Redeem reward | < 1s | Needs transaction lock |
| Get badges | < 200ms | Cache for 10 mins |
| List redemptions (50 items) | < 400ms | Paginated |

### 9.2 Caching Strategy

```
- User points: Redis, 5-minute TTL
- Rewards catalog: Redis, 1-hour TTL
- Badge definitions: Redis, 24-hour TTL
- User badges: Redis, 10-minute TTL
- Invalidate on: Any points change, reward status change
```

### 9.3 Database Optimization

```
- Connection pooling: Min 10, Max 50 connections
- Batch point transactions for bulk operations
- Archive old transactions (> 2 years) quarterly
- Analyze query plans quarterly
```

---

## 10. Error Handling & Status Codes

### 10.1 Common HTTP Responses

```
200 OK - Request successful
201 Created - Resource created
400 Bad Request - Invalid input
401 Unauthorized - Missing/invalid token
403 Forbidden - Insufficient permissions
404 Not Found - Resource not found
409 Conflict - Redemption limit exceeded, insufficient points
429 Too Many Requests - Rate limit exceeded
500 Internal Server Error - Server error
503 Service Unavailable - Service maintenance
```

### 10.2 Standard Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {
      "field": "additional_context"
    },
    "timestamp": "2024-04-26T12:00:00Z"
  }
}
```

---

## 11. Admin Panel Requirements

### 11.1 Admin Endpoints

**Manual Point Adjustment:**
```http
POST /api/v1/admin/users/{user_id}/points/adjust
Authorization: Bearer {admin_token}

{
  "amount": 100,
  "reason": "Customer service compensation",
  "admin_notes": "Resolved refund issue"
}
```

**Manage Rewards:**
```http
POST /api/v1/admin/rewards/{reward_id}/status
Authorization: Bearer {admin_token}

{
  "status": "INACTIVE",
  "reason": "Partner out of stock"
}
```

**View User Points Details:**
```http
GET /api/v1/admin/users/{user_id}/points/analytics
Authorization: Bearer {admin_token}
```

---

## 12. Analytics & Reporting

### 12.1 Required Analytics Endpoints

1. **Points Statistics**
   - Total points distributed
   - Average points per user
   - Top earners
   - Points distribution by activity type

2. **Rewards Analytics**
   - Most redeemed rewards
   - Redemption rate by category
   - Partner integration success rate
   - Revenue impact by reward

3. **Badges Analytics**
   - Badge unlock rates
   - Time to unlock
   - Badge distribution
   - User retention by badges

---

## 13. Testing Checklist

### 13.1 Unit Tests
- [ ] Points calculation logic
- [ ] Points validation rules
- [ ] Redemption eligibility checks
- [ ] Badge unlock conditions
- [ ] Tier calculation logic

### 13.2 Integration Tests
- [ ] Points earning flow (end-to-end)
- [ ] Redemption workflow
- [ ] Partner API integrations
- [ ] Event publishing and handling
- [ ] Notification delivery

### 13.3 Load Tests
- [ ] 1000 concurrent redemption requests
- [ ] Points history pagination under load
- [ ] Badge calculation with 100k+ users
- [ ] Redis cache performance

---

## 14. Implementation Timeline (Estimated)

| Phase | Task | Duration | Dependencies |
|-------|------|----------|--------------|
| Phase 1 | Database schema & core APIs | 2 weeks | None |
| Phase 2 | Points & transactions logic | 1.5 weeks | Phase 1 |
| Phase 3 | Rewards & redemption system | 2 weeks | Phase 1, 2 |
| Phase 4 | Badges & achievements | 1.5 weeks | Phase 1 |
| Phase 5 | Partner integrations | 3 weeks | Phase 3 |
| Phase 6 | Event system & webhooks | 1.5 weeks | All phases |
| Phase 7 | Admin endpoints & analytics | 1.5 weeks | Phase 3, 5 |
| Phase 8 | Testing & optimization | 2 weeks | All phases |
| **Total** | | **~15 weeks** | |

---

## 15. Frontend-Backend Contract

### 15.1 Current Hardcoded Values to Replace

The frontend currently uses hardcoded/dummy data:

```dart
// In rewards_screen.dart
static ValueNotifier<int> userPoints = ValueNotifier<int>(2340);

// In rewards_tab.dart - hardcoded rewards
CustomRedeemCard(
  title: "Coffee Voucher",
  neededPoints: 500,
)

// In badges_tab.dart - hardcoded badges
CustomBadgeCard(
  title: "First Timer",
  subtitle: "Completed first donation",
  isUnlocked: true,
)
```

**These should be replaced with API calls to:**
- `GET /api/v1/donor/points`
- `GET /api/v1/rewards`
- `GET /api/v1/donor/badges`

### 15.2 API Contract for Frontend

All responses should follow the standard format:
```json
{
  "success": true,
  "data": { /* endpoint-specific data */ },
  "pagination": { /* if applicable */ }
}
```

---

## 16. Additional Notes & Considerations

1. **Database Consistency:** Use transactions for all point modifications to ensure ACID compliance
2. **Audit Trail:** Never delete transaction records; use soft deletes if needed
3. **Partner Management:** Implement circuit breaker pattern for partner APIs
4. **Scalability:** Design for 1M+ concurrent users
5. **Localization:** Support multiple currencies for international rewards (future)
6. **Monitoring:** Set up alerts for:
   - High redemption rates
   - Unusual point distributions
   - Partner API failures
   - Points account anomalies

---

## 17. Contact & Questions

For clarifications on these requirements, please contact:
- **Frontend Team Lead:** [Contact Info]
- **Product Manager:** [Contact Info]
- **Mobile App Development:** [Contact Info]

---

**Document Approval:**
- [ ] Backend Lead
- [ ] Product Manager
- [ ] QA Lead
- [ ] DevOps Lead

**Last Updated:** April 26, 2026

