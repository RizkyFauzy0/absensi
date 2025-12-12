-- =====================================================
-- SISTEM ABSENSI SEKOLAH - DEVICE & KREDENSIAL
-- =====================================================

-- Tabel Device Absensi
CREATE TABLE IF NOT EXISTS device_absensi (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode_device VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    tipe ENUM('rfid', 'fingerprint', 'face', 'multi') NOT NULL,
    merk VARCHAR(50),
    model VARCHAR(50),
    serial_number VARCHAR(100),
    ip_address VARCHAR(45),
    port INT DEFAULT 4370,
    lokasi VARCHAR(100),
    fungsi ENUM('in', 'out', 'both') DEFAULT 'both',
    adms_enabled TINYINT(1) DEFAULT 0,
    adms_url VARCHAR(255),
    api_key VARCHAR(100),
    comm_key INT DEFAULT 0,
    last_ping DATETIME,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_serial (serial_number),
    INDEX idx_ip (ip_address)
);

-- Tabel Kredensial Siswa
CREATE TABLE IF NOT EXISTS siswa_kredensial (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    tipe ENUM('rfid', 'fingerprint', 'face', 'pin') NOT NULL,
    rfid_uid VARCHAR(50),
    finger_id INT,
    finger_index INT DEFAULT 1,
    finger_template BLOB,
    face_template BLOB,
    pin_code VARCHAR(10),
    is_active TINYINT(1) DEFAULT 1,
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    registered_by INT,
    device_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    FOREIGN KEY (registered_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (device_id) REFERENCES device_absensi(id) ON DELETE SET NULL,
    UNIQUE KEY unique_rfid (rfid_uid),
    INDEX idx_siswa (siswa_id),
    INDEX idx_rfid (rfid_uid),
    INDEX idx_finger (finger_id)
);

-- Tabel Kredensial Guru
CREATE TABLE IF NOT EXISTS guru_kredensial (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guru_id INT NOT NULL,
    tipe ENUM('rfid', 'fingerprint', 'face', 'pin') NOT NULL,
    rfid_uid VARCHAR(50),
    finger_id INT,
    finger_index INT DEFAULT 1,
    finger_template BLOB,
    face_template BLOB,
    pin_code VARCHAR(10),
    is_active TINYINT(1) DEFAULT 1,
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    registered_by INT,
    device_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (guru_id) REFERENCES guru(id) ON DELETE CASCADE,
    FOREIGN KEY (registered_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (device_id) REFERENCES device_absensi(id) ON DELETE SET NULL,
    UNIQUE KEY unique_rfid_guru (rfid_uid),
    INDEX idx_guru (guru_id),
    INDEX idx_rfid_guru (rfid_uid)
);
