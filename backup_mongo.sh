#!/bin/bash

# ===== CONFIG =====
DB_NAME="mydb"                     # your database name
BACKUP_DIR="/home/ubuntu/mongo_backups"  # local backup path
S3_BUCKET="s3://your-bucket-name/mongo-backups"  # change to your S3 bucket

# ===== CREATE TIMESTAMP =====
TIMESTAMP=$(date +%F-%H-%M)
BACKUP_PATH="$BACKUP_DIR/$DB_NAME-$TIMESTAMP"

# ===== RUN BACKUP =====
echo "Starting backup for $DB_NAME at $TIMESTAMP ..."
mongodump --db=$DB_NAME --out=$BACKUP_PATH

# ===== CHECK BACKUP SUCCESS =====
if [ $? -eq 0 ]; then
    echo "Backup successful! Stored at $BACKUP_PATH"
else
    echo "Backup failed!"
    exit 1
fi

# ===== UPLOAD TO S3 =====
echo "Uploading to S3 bucket: $S3_BUCKET ..."
aws s3 cp $BACKUP_PATH $S3_BUCKET --recursive

if [ $? -eq 0 ]; then
    echo "Upload successful!"
else
    echo "Upload failed!"
    exit 1
fi

echo "Backup + Upload Done!"
