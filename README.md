# Sistem Absensi Sekolah

Aplikasi sistem absensi sekolah berbasis web menggunakan CodeIgniter 3, Tailwind CSS, dan MySQL.

## Fitur Utama

- ✅ Multi-role Authentication (Superadmin, Admin, Operator, Guru, Wali Kelas)
- ✅ Master Data (Siswa, Guru, Kelas, Tahun Ajaran, Mata Pelajaran, Jadwal)
- ✅ Absensi Kehadiran (Scan RFID/Fingerprint, Input Manual, Batch)
- ✅ Jurnal Mengajar dengan Absensi per Mapel
- ✅ Monitoring Realtime dengan Auto-refresh
- ✅ Kiosk Mode untuk Absensi Mandiri
- ✅ Laporan Kehadiran (Export Excel/PDF)
- ✅ Notifikasi WhatsApp via Mpedia API
- ✅ Device Management (RFID/Fingerprint)
- ✅ Cron Jobs (Auto Alpha, Notifikasi Otomatis)

## Tech Stack

- **Backend:** CodeIgniter 3.1.13
- **Frontend:** Tailwind CSS 3.4, jQuery 3.7
- **Database:** MySQL 5.7+ / MariaDB 10.x
- **Hardware:** RFID Reader USB HID, ZKTeco Fingerprint (ADMS)
- **Notification:** WhatsApp via Mpedia API

## Instalasi

```bash
# 1. Clone repository
git clone https://github.com/RizkyFauzy0/absensi.git

# 2. Install dependencies
npm install

# 3. Build Tailwind CSS
npx tailwindcss -i ./src/input.css -o ./assets/css/output.css --minify

# 4. Import database
mysql -u root -p absensi_sekolah < database/01_master_data.sql
# ... import semua file SQL

# 5. Konfigurasi
# Edit: application/config/database.php
# Edit: application/config/config.php

# 6. Set permissions
chmod -R 755 assets/uploads/
chmod -R 755 application/logs/
chmod -R 755 backups/
```

## Default Login

- **Username:** admin
- **Password:** password

## Struktur Folder

```
absensi/
├── application/          # CodeIgniter application
├── assets/              # CSS, JS, Images, Uploads
├── database/            # SQL files
├── src/                 # Tailwind source
├── system/              # CodeIgniter system
├── .htaccess
├── index.php
├── package.json
└── tailwind.config.js
```

## Lisensi

MIT License

## Author

RizkyFauzy0