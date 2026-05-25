# Fintech — Payment Analytics & SQL Project

## Project Overview
This project simulates the work of a Data Analyst 
at a fintech company.

Using a structured dataset of transactions, merchants, 
FX rates and compliance flags, I performed end-to-end 
analysis covering payment performance, fraud detection, 
merchant health and regulatory compliance.

---

##  Business Problems Solved

| Problem | Analysis Done |
|---|---|
| High payment failure rates | Transaction success/failure analysis |
| Fraud exposure | Fraud rate by type and merchant |
| Compliance backlogs | Open vs resolved flags tracking |
| FX performance | Currency pair volatility analysis |
| Merchant growth | Top merchant volume scorecard |

---

##  Tools Used
- **MySQL** — Database creation and querying
- **Python (Pandas, SQLAlchemy)** — Data loading and cleaning
- **Power BI** — Interactive dashboard
- **Excel** — Data source and exports

---

## Database Structure

### Transactions Table
| Column | Description |
|---|---|
| transaction_id | Unique transaction identifier |
| merchant_id | Merchant who processed the transaction |
| amount | Transaction amount |
| currency | Transaction currency |
| transaction_type | Type of transaction |
| status | Success, failed or pending |
| is_fraud | 1 = fraud, 0 = legitimate |
| created_at | Transaction timestamp |

### Merchants Table
| Column | Description |
|---|---|
| merchant_id | Unique merchant identifier |
| merchant_name | Business name |
| business_type | Category of business |
| country | Country of operation |
| currency | Primary currency |
| onboarding_date | Date merchant joined |
| status | Active or inactive |

### FX Rates Table
| Column | Description |
|---|---|
| id | Unique record ID |
| base_currency | Source currency |
| target_currency | Target currency |
| rate | Exchange rate |
| rate_date | Date of rate |

### Compliance Table
| Column | Description |
|---|---|
| flag_id | Unique flag identifier |
| transaction_id | Linked transaction |
| flag_type | Type of compliance flag |
| flag_reason | Why it was flagged |
| flagged_at | When it was flagged |
| resolved | 1 = resolved, 0 = open |

---

## Key SQL Queries Written

1. Total transaction volume by currency
2. Payment success vs failure rate
3. Fraud rate by transaction type
4. Top 10 merchants by volume
5. Flagged transactions with full details
6. Unresolved compliance flags breakdown
7. FX rate volatility by currency pair
8. Monthly transaction growth trend
9. Merchant health scorecard
10. High risk transaction identification

---

## Key Findings

- NGN drives the highest transaction volume
- Fraud is concentrated in Cash OUT
  transactions
-Cash out and transfer compliance flags remain unresolved — 
  requiring immediate attention
- Top merchant, Abuja Electronics accounts for 31%
  of total platform volume



---

## Files in This Repository
