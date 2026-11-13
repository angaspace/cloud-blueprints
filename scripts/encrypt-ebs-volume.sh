#!/bin/bash
# Anga Space - Encrypt an existing unencrypted EBS volume
# Usage: ./encrypt-ebs-volume.sh <volume-id> <region> [kms-key-id-or-alias]
# Tested: not yet (see TESTING.md)
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <volume-id> <region> [kms-key]"
  exit 1
fi

VOLUME_ID="$1"
REGION="$2"
KMS_KEY="${3:-alias/aws/ebs}"

read -r AZ VOL_TYPE ENCRYPTED < <(aws ec2 describe-volumes --region "$REGION" \
  --volume-ids "$VOLUME_ID" \
  --query 'Volumes[0].[AvailabilityZone,VolumeType,Encrypted]' --output text)

if [ "$ENCRYPTED" = "True" ]; then
  echo "Volume $VOLUME_ID is already encrypted. Nothing to do."
  exit 0
fi

echo "1/3 Creating snapshot of $VOLUME_ID..."
SNAP_ID=$(aws ec2 create-snapshot --region "$REGION" --volume-id "$VOLUME_ID" \
  --description "pre-encryption snapshot of $VOLUME_ID" \
  --query SnapshotId --output text)
aws ec2 wait snapshot-completed --region "$REGION" --snapshot-ids "$SNAP_ID"

echo "2/3 Copying snapshot with encryption..."
ENC_SNAP_ID=$(aws ec2 copy-snapshot --region "$REGION" --source-region "$REGION" \
  --source-snapshot-id "$SNAP_ID" --encrypted --kms-key-id "$KMS_KEY" \
  --description "encrypted copy of $SNAP_ID" \
  --query SnapshotId --output text)
aws ec2 wait snapshot-completed --region "$REGION" --snapshot-ids "$ENC_SNAP_ID"

echo "3/3 Creating encrypted $VOL_TYPE volume in $AZ..."
# Note: io1/io2 volumes need --iops. Add it manually if the original used them.
NEW_VOL=$(aws ec2 create-volume --region "$REGION" --availability-zone "$AZ" \
  --snapshot-id "$ENC_SNAP_ID" --volume-type "$VOL_TYPE" \
  --query VolumeId --output text)

echo "Done. New encrypted volume: $NEW_VOL"
echo "Temporary snapshots: $SNAP_ID, $ENC_SNAP_ID (delete after verifying)."
echo "Next (manual): stop instance, detach $VOLUME_ID, attach $NEW_VOL with the same device name, verify, then delete the old volume."
