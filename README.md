# Automated_backups_S3


This project provides a simple way to **back up a MongoDB database** and upload it to **AWS S3** automatically using a shell script.

## 🚀 Features
- Takes backup of a specific MongoDB database  
- Stores backups locally with timestamped folders  
- Uploads backups to an AWS S3 bucket  
- Easy to schedule with cron jobs  

## 📂 Project Structure
```
.
├── backup.sh   # Shell script to perform backup & upload
└── README.md   # Documentation
```

## ⚙️ Prerequisites
- **MongoDB tools** installed (`mongodump`)  
- **AWS CLI** configured (`aws configure`) with valid credentials  
- An **S3 bucket** created for storing backups

Install Mongo
1. Commands to install mongo:
   ```
   echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

   ```

## 🛠️ Setup
1. Clone this repo:
   ```bash
   git clone https://https://github.com/AnweshaPanigrahi/Automated_backups_S3.git
   cd mongo-backup-s3
   ```
2. Update variables inside `backup.sh`:
   - `DB_NAME` → Your MongoDB database name  
   - `BACKUP_DIR` → Local backup directory path  
   - `S3_BUCKET` → Your S3 bucket name/path  

3. Make the script executable:
   ```bash
   chmod +x backup_mongo.sh
   ```

4. Run the backup script:
   ```bash
   ./backup_mongo.sh
   ```

## ⏰ Automating with Cron
To schedule automatic backups (e.g., daily at 2 AM):
```bash
crontab -e
```
Add the line:
```bash
0 2 * * * /home/ubuntu/mongo-backups/backup.sh >> /home/ubuntu/mongo-backups/backup.log 2>&1
```

## 📦 Example Backup Output
```
/home/ubuntu/mongo_backups/
  ├── mydb-2025-08-21-13-00/
  │   ├── collection1.bson
  │   ├── collection2.bson
  │   └── ...
```

## ✅ Result
- Local backups stored with timestamps  
- Automatically uploaded to S3 for safekeeping  
- Easy restore when needed with `mongorestore`  

---

