# Backend API Quick Reference
## Blood Donation App - All Screens & Endpoints

---

## DONOR ROLE - API SUMMARY

| Screen | Key Endpoints | Method | Purpose |
|--------|---|--------|---------|
| **Home** | `/api/v1/donor/dashboard` | GET | Dashboard stats & urgent requests |
| | `/api/v1/urgent-requests` | GET | List emergency requests |
| | `/api/v1/donor/recent-activity` | GET | Activity timeline |
| **Find Hospital** | `/api/v1/hospitals` | GET | List all hospitals |
| | `/api/v1/hospitals/{id}` | GET | Hospital details & blood status |
| **Donate** | `/api/v1/donor/donation-eligibility` | GET | Check if can donate |
| | `/api/v1/donations/book-appointment` | POST | Book donation appointment |
| | `/api/v1/donations/complete` | POST | Record completed donation |
| | `/api/v1/donor/donations` | GET | Donation history |
| **Rewards** | `/api/v1/donor/points` | GET | Current points |
| | `/api/v1/rewards` | GET | Available rewards |
| | `/api/v1/rewards/{id}/redeem` | POST | Redeem reward |
| | `/api/v1/donor/badges` | GET | Badges & progress |
| | `/api/v1/donor/redemptions` | GET | Redemption history |
| **Profile** | `/api/v1/donor/profile` | GET/PUT | Personal information |
| | `/api/v1/donor/health-history` | GET | Health data |
| **Request Details** | `/api/v1/urgent-requests/{id}` | GET | Full request details |
| | `/api/v1/urgent-requests/{id}/accept` | POST | Accept request |
| | `/api/v1/urgent-requests/{id}/decline` | POST | Decline request |
| **Notifications** | `/api/v1/donor/notifications` | GET | List notifications |
| | `/api/v1/donor/notifications/{id}/mark-read` | PUT | Mark as read |
| **2FA** | `/api/v1/auth/2fa/setup` | POST | Enable 2FA |
| | `/api/v1/auth/2fa/verify` | POST | Verify OTP |
| | `/api/v1/auth/2fa/disable` | POST | Disable 2FA |
| **Help** | `/api/v1/help/faq` | GET | FAQ content |
| | `/api/v1/help/documents/{type}` | GET | Download docs |
| | `/api/v1/support/contact` | POST | Submit support ticket |

**Total Donor Endpoints:** 27

---

## HOSPITAL ROLE - API SUMMARY

| Screen | Key Endpoints | Method | Purpose |
|--------|---|--------|---------|
| **Home** | `/api/v1/hospital/dashboard` | GET | Hospital dashboard |
| | `/api/v1/hospital/blood-inventory` | GET | Current blood stock |
| **Requests** | `/api/v1/hospital/requests/create-emergency` | POST | Create emergency request |
| | `/api/v1/hospital/requests` | GET | Request history |
| | `/api/v1/hospital/requests/{id}/responses` | GET | Donor responses |
| | `/api/v1/hospital/requests/{id}/close` | POST | Close request |
| **Staff** | `/api/v1/hospital/staff` | GET | Staff roster |
| **Reports** | `/api/v1/hospital/reports/monthly` | GET | Monthly statistics |
| **Profile** | `/api/v1/hospital/profile` | GET/PUT | Hospital info |
| | `/api/v1/hospital/blood-bank-settings` | PUT | Blood bank config |
| | `/api/v1/hospital/notification-preferences` | GET/PUT | Notification settings |

**Total Hospital Endpoints:** 11

---

## ADMIN ROLE - API SUMMARY

| Screen | Key Endpoints | Method | Purpose |
|--------|---|--------|---------|
| **Dashboard** | `/api/v1/admin/dashboard` | GET | Admin dashboard stats |
| | `/api/v1/admin/blood-inventory-summary` | GET | Blood status all hospitals |
| | `/api/v1/admin/alerts` | GET | System alerts |
| **Users - Donors** | `/api/v1/admin/donors` | GET | Donor list |
| | `/api/v1/admin/donors/{id}` | GET | Donor details |
| | `/api/v1/admin/donors/{id}` | PUT | Update donor status |
| **Users - Hospitals** | `/api/v1/admin/hospitals` | GET | Hospital list |
| | `/api/v1/admin/hospitals/{id}` | GET | Hospital details |
| | `/api/v1/admin/hospitals/{id}` | PUT | Update hospital |
| | `/api/v1/admin/hospitals` | POST | Create hospital |
| **Users - Admins** | `/api/v1/admin/admins` | GET | Admin list |
| | `/api/v1/admin/admins/{id}` | GET | Admin details |
| | `/api/v1/admin/admins/{id}` | PUT | Update admin |
| | `/api/v1/admin/admins` | POST | Create admin |
| | `/api/v1/admin/admins/{id}` | DELETE | Delete admin |
| **System Settings** | `/api/v1/admin/system-health` | GET | System health status |
| | `/api/v1/admin/system-health/check` | POST | Check system health |
| | `/api/v1/admin/maintenance-mode` | POST | Enable maintenance |
| | `/api/v1/admin/maintenance-mode/status` | GET | Maintenance status |
| | `/api/v1/admin/audit-logs` | GET | Audit log history |
| | `/api/v1/admin/permissions/roles` | GET | Role permissions |
| | `/api/v1/admin/permissions/roles/{role}` | PUT | Update role perms |

**Total Admin Endpoints:** 22

---

## SHARED/AUTH - API SUMMARY

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/v1/auth/login` | POST | User login |
| `/api/v1/auth/register` | POST | User registration |
| `/api/v1/auth/send-otp` | POST | Send OTP code |
| `/api/v1/auth/verify-otp` | POST | Verify OTP |
| `/api/v1/auth/password-reset` | POST | Request password reset |
| `/api/v1/auth/reset-password` | POST | Complete password reset |
| `/api/v1/auth/logout` | POST | User logout |
| `/api/v1/auth/refresh-token` | POST | Refresh access token |
| `/api/v1/auth/validate-token` | POST | Validate token (splash screen) |
| `/api/v1/hospitals/nearby` | GET | Find nearby hospitals |
| `/api/v1/maps/directions` | GET | Get directions (external) |

**Total Auth/Shared Endpoints:** 11

---

## COMPLETE ENDPOINT INVENTORY

```
Total Unique Endpoints: ~71
Total API Operations: ~80+

By Role:
- Donor: 27 endpoints
- Hospital: 11 endpoints
- Admin: 22 endpoints
- Auth/Shared: 11 endpoints
```

---

## MOST CRITICAL ENDPOINTS (Implement First)

### Phase 1 (Week 1-2):
1. `/api/v1/auth/login` ⭐
2. `/api/v1/auth/register` ⭐
3. `/api/v1/auth/send-otp` ⭐
4. `/api/v1/auth/verify-otp` ⭐
5. `/api/v1/donor/profile` ⭐
6. `/api/v1/hospital/profile` ⭐

### Phase 2 (Week 3-4):
7. `/api/v1/donor/dashboard` ⭐
8. `/api/v1/hospitals` ⭐
9. `/api/v1/donations/book-appointment` ⭐
10. `/api/v1/donations/complete` ⭐
11. `/api/v1/hospital/requests/create-emergency` ⭐
12. `/api/v1/urgent-requests` ⭐

### Phase 3 (Week 5-6):
13. `/api/v1/donor/points` (Rewards)
14. `/api/v1/rewards`
15. `/api/v1/donor/badges`
16. `/api/v1/admin/dashboard`
17. `/api/v1/admin/donors`
18. `/api/v1/admin/hospitals`

### Phase 4 (Week 7+):
- All remaining endpoints
- Analytics & Reporting
- Advanced filtering & search

---

## HTTP STATUS CODES MAPPING

```
✅ 200 - Success
✅ 201 - Created
✅ 204 - No Content

❌ 400 - Invalid Request
❌ 401 - Unauthorized
❌ 403 - Forbidden
❌ 404 - Not Found
❌ 409 - Conflict (insufficient points, limits)
❌ 429 - Rate Limited
❌ 500 - Server Error
```

---

## AUTHENTICATION PATTERN

All endpoints (except login/register) require:

```http
Authorization: Bearer {access_token}
Content-Type: application/json
```

Token expires in: **15-30 minutes**
Refresh token expires in: **7 days**

---

## RESPONSE FORMAT TEMPLATE

```json
{
  "success": true,
  "data": {
    // Endpoint-specific data here
  },
  "pagination": {
    // Only if applicable
    "current_page": 1,
    "total_pages": 5,
    "total_items": 100
  },
  "timestamp": "2024-04-26T12:00:00Z"
}
```

---

## COMMON QUERY PARAMETERS

```
For list endpoints:
- page: number (default: 1)
- limit: number (default: 20, max: 100)
- sort: string (field name)
- sort_order: ASC|DESC
- filter: JSON object
- search: string

For location endpoints:
- latitude: float
- longitude: float
- radius_km: float
- filters: {...}
```

---

## DATABASE PRIORITIES

### Tables - Implement Order:

**Priority 1 (Must Have First):**
1. users
2. auth_tokens
3. donors
4. hospitals
5. donations

**Priority 2 (Core Features):**
6. emergency_requests
7. emergency_responses
8. blood_inventory
9. user_points_accounts
10. points_transactions

**Priority 3 (Enhanced Features):**
11. rewards_catalog
12. reward_redemptions
13. user_badges
14. notifications
15. admins

**Priority 4 (Operational):**
16. audit_logs
17. system_health_logs
18. appointment_schedules
19. user_addresses
20. user_health_data

---

## KEY METRICS TO MONITOR

### Performance Targets:
- API Response Time: < 500ms (p95)
- Database Query: < 100ms
- Reward Redemption: < 1s
- Appointment Booking: < 500ms

### Load Testing Targets:
- Concurrent Users: 10,000+
- Requests/sec: 1,000+
- Database Connections: 100+

### Reliability Targets:
- Uptime: 99.5%
- Error Rate: < 0.5%
- Auto-recovery time: < 5 minutes

---

## COMMON ERROR CODES

```
INSUFFICIENT_POINTS - User lacks points for redemption
INVALID_BLOOD_TYPE - Incompatible blood type
NOT_ELIGIBLE_TO_DONATE - User cannot donate
HOSPITAL_OFFLINE - Hospital not accepting requests
APPOINTMENT_UNAVAILABLE - Time slot not available
RATE_LIMIT_EXCEEDED - Too many requests
UNAUTHORIZED_ACCESS - Invalid permissions
INVALID_OTP - Wrong OTP code
DUPLICATE_ENTRY - Already exists in system
RESOURCE_NOT_FOUND - Item doesn't exist
```

---

## CACHING STRATEGY

```
User Profile: 1 hour
Hospital Info: 1 hour
Rewards Catalog: 24 hours
Badge Definitions: 24 hours
User Points: 5 minutes
Blood Inventory: 15 minutes
Donation History: 1 hour
```

**Cache Invalidation:**
- On any write operation
- Manual invalidation by admin
- Time-based expiration (TTL)

---

## SECURITY HEADERS

All responses should include:

```http
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Strict-Transport-Security: max-age=31536000
Content-Security-Policy: default-src 'self'
Access-Control-Allow-Origin: https://yourdomain.com
```

---

## RATE LIMITING

```
Standard Endpoints: 100 req/hour per user
List Endpoints: 50 req/hour per user
Admin Endpoints: 1000 req/hour per admin
Auth Endpoints: 10 attempts per 15 min
```

---

## TESTING CHECKLIST

### Unit Tests:
- [ ] Input validation
- [ ] Authorization checks
- [ ] Business logic
- [ ] Error handling

### Integration Tests:
- [ ] End-to-end flows
- [ ] Database operations
- [ ] External integrations
- [ ] Notification triggers

### Performance Tests:
- [ ] Load testing (10k concurrent)
- [ ] Stress testing (20k concurrent)
- [ ] Spike testing
- [ ] Soak testing (24+ hours)

### Security Tests:
- [ ] SQL injection
- [ ] XSS attacks
- [ ] CSRF protection
- [ ] Authentication bypass
- [ ] Authorization bypass

---

## DEPLOYMENT CHECKLIST

- [ ] All endpoints documented
- [ ] Database backups configured
- [ ] Monitoring & alerts setup
- [ ] Logging configured
- [ ] Rate limiting enabled
- [ ] Security headers added
- [ ] HTTPS enforced
- [ ] API versioning ready
- [ ] Documentation completed
- [ ] Load testing passed

---

**Version:** 1.0  
**Last Updated:** April 26, 2026  
**Status:** Ready for Development

