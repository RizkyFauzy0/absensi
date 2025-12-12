-- =====================================================
-- SISTEM ABSENSI SEKOLAH - DATABASE MASTER DATA
-- =====================================================

-- Tabel Users
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    role ENUM('superadmin', 'admin', 'operator', 'guru', 'wali_kelas') DEFAULT 'operator',
    foto VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1,
    last_login DATETIME,
    last_ip VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Tahun Ajaran
CREATE TABLE IF NOT EXISTS tahun_ajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(50) NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    is_active TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Semester
CREATE TABLE IF NOT EXISTS semester (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kode VARCHAR(20) NOT NULL,
    nama VARCHAR(50) NOT NULL,
    tipe ENUM('ganjil', 'genap') NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    is_active TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE CASCADE
);

-- Tabel Tingkat
CREATE TABLE IF NOT EXISTS tingkat (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode VARCHAR(10) NOT NULL UNIQUE,
    nama VARCHAR(50) NOT NULL,
    urutan INT DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Jurusan
CREATE TABLE IF NOT EXISTS jurusan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    singkatan VARCHAR(20),
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Kelas
CREATE TABLE IF NOT EXISTS kelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode_kelas VARCHAR(20) NOT NULL UNIQUE,
    nama_kelas VARCHAR(50) NOT NULL,
    tingkat_id INT,
    jurusan_id INT,
    kapasitas INT DEFAULT 36,
    ruangan VARCHAR(50),
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tingkat_id) REFERENCES tingkat(id) ON DELETE SET NULL,
    FOREIGN KEY (jurusan_id) REFERENCES jurusan(id) ON DELETE SET NULL
);

-- Tabel Siswa
CREATE TABLE IF NOT EXISTS siswa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nis VARCHAR(20) NOT NULL UNIQUE,
    nisn VARCHAR(20) UNIQUE,
    nama_lengkap VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    tempat_lahir VARCHAR(50),
    tanggal_lahir DATE,
    agama VARCHAR(20),
    alamat TEXT,
    no_telepon VARCHAR(20),
    email VARCHAR(100),
    nama_ayah VARCHAR(100),
    nama_ibu VARCHAR(100),
    no_telepon_ortu VARCHAR(20),
    foto VARCHAR(255),
    status ENUM('aktif', 'nonaktif', 'lulus', 'pindah', 'keluar') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nis (nis),
    INDEX idx_status (status)
);

-- Tabel Guru
CREATE TABLE IF NOT EXISTS guru (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    nip VARCHAR(30) UNIQUE,
    nuptk VARCHAR(30) UNIQUE,
    nama_lengkap VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    tempat_lahir VARCHAR(50),
    tanggal_lahir DATE,
    agama VARCHAR(20),
    alamat TEXT,
    no_telepon VARCHAR(20),
    email VARCHAR(100),
    jabatan VARCHAR(100),
    status_kepegawaian ENUM('PNS', 'PPPK', 'GTY', 'GTT', 'Honorer') DEFAULT 'GTT',
    foto VARCHAR(255),
    status ENUM('aktif', 'nonaktif', 'pensiun', 'pindah') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_nip (nip),
    INDEX idx_status (status)
);

-- Tabel Mata Pelajaran
CREATE TABLE IF NOT EXISTS mata_pelajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    kelompok VARCHAR(50),
    jam_per_minggu INT DEFAULT 2,
    urutan INT DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Jadwal Pelajaran
CREATE TABLE IF NOT EXISTS jadwal_pelajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kelas_id INT NOT NULL,
    mata_pelajaran_id INT NOT NULL,
    guru_id INT NOT NULL,
    tahun_ajaran_id INT,
    semester_id INT,
    hari ENUM('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu') NOT NULL,
    jam_ke INT NOT NULL,
    jam_mulai TIME,
    jam_selesai TIME,
    ruangan VARCHAR(50),
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id) ON DELETE CASCADE,
    FOREIGN KEY (mata_pelajaran_id) REFERENCES mata_pelajaran(id) ON DELETE CASCADE,
    FOREIGN KEY (guru_id) REFERENCES guru(id) ON DELETE CASCADE,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE SET NULL,
    FOREIGN KEY (semester_id) REFERENCES semester(id) ON DELETE SET NULL,
    INDEX idx_jadwal (kelas_id, hari, jam_ke)
);

-- Tabel Hari Libur
CREATE TABLE IF NOT EXISTS hari_libur (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    keterangan TEXT,
    jenis ENUM('nasional', 'sekolah', 'kegiatan') DEFAULT 'nasional',
    tahun_ajaran_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE SET NULL
);

-- Tabel Siswa Kelas
CREATE TABLE IF NOT EXISTS siswa_kelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    kelas_id INT NOT NULL,
    tahun_ajaran_id INT NOT NULL,
    no_absen INT,
    status ENUM('aktif', 'pindah', 'keluar') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id) ON DELETE CASCADE,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE CASCADE,
    UNIQUE KEY unique_siswa_tahun (siswa_id, tahun_ajaran_id)
);

-- Tabel Guru Mata Pelajaran
CREATE TABLE IF NOT EXISTS guru_mata_pelajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guru_id INT NOT NULL,
    mata_pelajaran_id INT NOT NULL,
    tahun_ajaran_id INT NOT NULL,
    is_primary TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guru_id) REFERENCES guru(id) ON DELETE CASCADE,
    FOREIGN KEY (mata_pelajaran_id) REFERENCES mata_pelajaran(id) ON DELETE CASCADE,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE CASCADE,
    UNIQUE KEY unique_guru_mapel (guru_id, mata_pelajaran_id, tahun_ajaran_id)
);

-- Tabel Wali Kelas
CREATE TABLE IF NOT EXISTS wali_kelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guru_id INT NOT NULL,
    kelas_id INT NOT NULL,
    tahun_ajaran_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guru_id) REFERENCES guru(id) ON DELETE CASCADE,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id) ON DELETE CASCADE,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id) ON DELETE CASCADE,
    UNIQUE KEY unique_kelas_tahun (kelas_id, tahun_ajaran_id)
);

-- Default Data
INSERT INTO users (username, email, password, nama_lengkap, role, is_active) VALUES
('admin', 'admin@sekolah.sch.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'superadmin', 1);

INSERT INTO tingkat (kode, nama, urutan) VALUES
('X', 'Kelas X', 1),
('XI', 'Kelas XI', 2),
('XII', 'Kelas XII', 3);

INSERT INTO tahun_ajaran (kode, nama, tanggal_mulai, tanggal_selesai, is_active) VALUES
('2024-2025', 'Tahun Ajaran 2024/2025', '2024-07-15', '2025-06-30', 1);
