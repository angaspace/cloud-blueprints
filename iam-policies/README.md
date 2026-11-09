# Anga Space - IAM Security Baseline

This repository holds the production security standards enforced by Anga Space for cloud identity management.

## Core Tenets:
1. **Zero Root Usage:** Root account is locked with hardware/virtual MFA and never used for operational tasks.
2. **Enforced MFA:** All IAM human users must authenticate with MFA.
3. **Role-Based Workloads:** EC2, Lambda, and compute workloads must assume IAM Roles with temporary STS credentials—never static access keys.
4. **Credential Hygiene:** 90-day password rotation and automated access key expiration checks.
5. **Quarterly Audits:** Continuous verification via IAM Credential Reports and IAM Access Advisor.
