# cloud-blueprints

Reusable AWS building blocks used by Anga Space for secure cloud setup and audits.

## Contents
| Path | What it is | Status |
| :--- | :--- | :--- |
| `iam-policies/` | IAM policy examples and security baseline | Reference |
| `scripts/bootstrap-webserver.sh` | EC2 user-data script: installs Apache | Tested: 2026-11-13, us-east-1 |
| `scripts/encrypt-ebs-volume.sh` | Encrypts an existing EBS volume via snapshot copy | Tested: not yet |

Update the Status column with the test date once you have run each item (see TESTING.md).

## How to use
- Run everything in a sandbox AWS account first.
- Read each script before running it. Never run scripts on a client account without written permission.
- Never commit credentials. See `.gitignore`.

## Security rules
- No static access keys on servers: use IAM roles.
- MFA for every human user.
- Least privilege: no `"Action": "*"` with `"Resource": "*"`.

Maintained by Anga Space (Founder: George Robert).
