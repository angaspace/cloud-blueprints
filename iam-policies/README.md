# IAM Security Baseline

## Standards
1. **No root usage:** root has MFA and is used only for account setup and billing.
2. **MFA for all human users.**
3. **Roles for workloads:** EC2, Lambda and CI jobs assume IAM roles (temporary credentials), never static keys.
4. **Credential hygiene:** review access keys and unused users at least quarterly.
5. **Audits:** IAM Credential Report and Access Advisor.

## Files
| File | Purpose |
| :--- | :--- |
| `iam-readonly-policy.json` | Allows reading IAM only (Get*/List*). For general audits use AWS managed `SecurityAudit` + `ViewOnlyAccess`. |
| `ec2-assume-role-trust-policy.json` | Trust policy letting EC2 assume a role. Attach permissions separately. |
| `password-policy.json` | Reference values for the account password policy. Not applied automatically. |

## Apply the password policy
```bash
aws iam update-account-password-policy \
  --minimum-password-length 14 \
  --require-symbols --require-numbers \
  --require-uppercase-characters --require-lowercase-characters \
  --allow-users-to-change-password \
  --max-password-age 90 --password-reuse-prevention 5
```
Note: current NIST guidance favors long passwords and MFA over forced expiry. Keep the 90 days only if a client's compliance rules require it.
