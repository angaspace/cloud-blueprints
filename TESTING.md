# Testing Log

| Date | File | Environment | Result | Notes |
| :--- | :--- | :--- | :--- | :--- |
| 2026-11-13 | scripts/bootstrap-webserver.sh | us-east-1, Amazon Linux 2023, t3.micro | Pass | Page loaded over HTTP on the public IP |
| 2026-11-13 | scripts/encrypt-ebs-volume.sh | us-east-1, 1 GB gp3 test volume | Pass | New encrypted volume created. Mistake on first run: passed the AZ (us-east-1a) instead of the region (us-east-1) |
