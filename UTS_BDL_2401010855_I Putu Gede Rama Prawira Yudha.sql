

-- 1. DDL: Pembuatan Database dan Tabel --

-- Soal 1a
CREATE DATABASE uts_bdl_2401010855;

USE uts_bdl_2401010855;

-- Soal 1b
CREATE TABLE destinasi (
	id_destinasi CHAR(4) PRIMARY KEY,
	nama_destinasi VARCHAR(50) NOT NULL,
	kabupaten VARCHAR(30) NOT NULL,
	harga_tiket INT NOT NULL
);
SELECT * FROM destinasi;

CREATE TABLE paket_tur (
	id_paket CHAR(4) PRIMARY KEY,
	nama_paket VARCHAR(50) NOT NULL UNIQUE,
	id_destinasi CHAR(4) NOT NULL,
	harga INT NOT NULL,
	durasi_jam INT,
	FOREIGN KEY (id_destinasi) REFERENCES destinasi(id_destinasi)
);
SELECT * FROM paket_tur;

CREATE TABLE wisatawan (
	id_wisatawan CHAR(5) PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	asal_negara VARCHAR(30) NOT NULL,
	email VARCHAR(50) UNIQUE
);
SELECT * FROM wisatawan;

CREATE TABLE pemesanan (
    id_pesan INT PRIMARY KEY,
    id_wisatawan CHAR(5) NOT NULL,
    id_paket CHAR(4) NOT NULL,
    tgl_tur DATE NOT NULL,
    jumlah_orang INT NOT NULL,
    `status` VARCHAR(10) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (id_wisatawan) REFERENCES wisatawan(id_wisatawan),
    FOREIGN KEY (id_paket) REFERENCES paket_tur(id_paket)
);
SELECT * FROM pemesanan;

SHOW TABLES;

-- Soal 1c
ALTER TABLE destinasi ADD COLUMN rating DECIMAL(2,1);
-- ------------------------------------------------------------------ --

-- 2. DML: Mengisi dan Mengubah Data --

-- Soal 2a --
INSERT INTO destinasi (id_destinasi, nama_destinasi, kabupaten, harga_tiket) VALUES
('D001', 'Tanah Lot', 'Tabanan', 30000),
('D002', 'Ulun Danu Beratan', 'Tabanan', 50000),
('D003', 'Tirta Empul', 'Gianyar', 50000),
('D004', 'Goa Gajah', 'Gianyar', 50000),
('D005', 'Desa Penglipuran', 'Bangli', 25000),
('D006', 'Pura Besakih', 'Karangasem', 60000),
('D007', 'Jatiluwih', 'Tabanan', 50000);

INSERT INTO paket_tur VALUES
('P001', 'Sunset Tanah Lot', 'D001', 350000, 5),
('P002', 'Bedugul Lake Tour', 'D002', 450000, 8),
('P003', 'Ubud Water Temple', 'D003', 400000, 6),
('P004', 'Ubud Heritage Walk', 'D004', 300000, 4),
('P005', 'Penglipuran Culture Trip', 'D005', 375000, 6),
('P006', 'Besakih Spiritual Journey', 'D006', 500000, 8),
('P007', 'Tanah Lot Photo Tour', 'D001', 250000, 3);

INSERT INTO wisatawan VALUES
('W0001', 'Made Ayu', 'Indonesia', 'made.ayu@mail.com'),
('W0002', 'John Smith', 'Australia', 'john.s@mail.com'),
('W0003', 'Sarah Lee', 'Singapura', 'sarah.lee@mail.com'),
('W0004', 'Kenji Tanaka', 'Jepang', 'kenji.t@mail.com'),
('W0005', 'Putu Arya', 'Indonesia', 'putu.arya@mail.com'),
('W0006', 'Emma Brown', 'Australia', 'emma.b@mail.com'),
('W0007', 'Li Wei', 'Tiongkok', 'li.wei@mail.com'),
('W0008', 'Komang Sari', 'Indonesia', 'komang.s@mail.com');

INSERT INTO pemesanan VALUES
(1, 'W0001', 'P001', '2026-09-05', 2, 'Lunas'),
(2, 'W0002', 'P003', '2026-09-12', 4, 'Lunas'),
(3, 'W0003', 'P002', '2026-09-20', 2, 'Batal'),
(4, 'W0004', 'P004', '2026-10-02', 3, 'Lunas'),
(5, 'W0002', 'P001', '2026-10-03', 4, 'Lunas'),
(6, 'W0005', 'P005', '2026-10-10', 5, 'Lunas'),
(7, 'W0006', 'P003', '2026-10-15', 2, 'Pending'),
(8, 'W0004', 'P002', '2026-10-18', 1, 'Lunas'),
(9, 'W0007', 'P007', '2026-10-25', 3, 'Lunas'),
(10, 'W0001', 'P004', '2026-11-01', 2, 'Lunas'),
(11, 'W0006', 'P001', '2026-11-07', 6, 'Lunas'),
(12, 'W0003', 'P005', '2026-11-09', 2, 'Pending');

-- Soal 2b --
UPDATE destinasi
SET harga_tiket = 30000
WHERE id_destinasi = 'D005';

SELECT * FROM destinasi;

-- Soal 2c --
UPDATE pemesanan
SET STATUS = 'Lunas'
WHERE id_pesan = 12;

SELECT * FROM pemesanan;

-- Soal 2d --
DELETE FROM pemesanan
WHERE STATUS = 'Batal';

-- Soal 2e --
INSERT INTO wisatawan VALUES
('W0009', 'Anna Schmidt', 'Jerman', 'anna.s@mail.com');

SELECT * FROM wisatawan;

-- Soal 2f --
INSERT INTO wisatawan VALUES ('W0010','Budi Santoso', 'Indonesia', 'made.ayu@mail.com');

-- ERRORS!! --
-- 1 queries executed, 0 success, 1 errors, 0 warnings

-- Query: INSERT INTO wisatawan VALUES ('W0010','Budi Santoso', 'Indonesia', 'made.ayu@mail.com')

-- Error Code: 1062
-- Duplicate entry 'made.ayu@mail.com' for key 'email'

-- Execution Time : 0 sec
-- Transfer Time  : 0 sec
-- Total Time     : 0.002 sec --


-- PENJELASAN!! --
-- Constraint yang menolak perintah tersebut adalah UNIQUE pada kolom email di tabel wisatawan.   
-- Alasannya: Kolom email telah didefinisikan dengan constraint UNIQUE, 
-- yang artinya setiap nilai email di dalam tabel wisatawan harus bersifat unik 
-- dan tidak boleh sama antarbaris data. 
-- Pada perintah INSERT tersebut, data baru (W0010 - Budi Santoso) 
-- mencoba memasukkan alamat email 'made.ayu@mail.com' 
-- yang sebelumnya sudah digunakan oleh wisatawan W0001 (Made Ayu). Karena terjadi duplikasi nilai pada kolom UNIQUE, 
-- MySQL menolak eksekusi perintah tersebut dengan pesan error Duplicate entry 'made.ayu@mail.com' for key 'email'. --


-- 3. Query Satu Tabel --

-- Soal 3a --
SELECT nama_paket, harga
FROM paket_tur
WHERE harga BETWEEN 300000 AND 450000
ORDER BY harga ASC;

-- Soal 3b --
SELECT id_wisatawan, nama
FROM wisatawan
WHERE nama LIKE '%an%'
ORDER BY nama ASC;

-- Soal 3c --
SELECT id_pesan, id_wisatawan, jumlah_orang
FROM pemesanan
ORDER BY jumlah_orang DESC, id_pesan ASC
LIMIT 3;

-- Soal 3d --
SELECT id_pesan, tgl_tur, STATUS
FROM pemesanan
WHERE STATUS = 'Lunas' AND tgl_tur BETWEEN '2026-10-01' AND '2026-10-31'
ORDER BY tgl_tur ASC;
-- ---------------------------------------------------------------------------------- --

-- 4. JOIN --

-- Soal 4a --
SELECT w.nama, pt.nama_paket, p.tgl_tur
FROM pemesanan p
INNER JOIN wisatawan w ON p.id_wisatawan = w.id_wisatawan
INNER JOIN paket_tur pt ON p.id_paket = pt.id_paket
WHERE p.status = 'Lunas'
ORDER BY p.tgl_tur ASC;

-- Soal 4b --
SELECT pt.nama_paket, d.nama_destinasi, d.kabupaten
FROM paket_tur pt
INNER JOIN destinasi d ON pt.id_destinasi = d.id_destinasi
WHERE d.kabupaten = 'Gianyar'
ORDER BY pt.nama_paket ASC;

-- Soal 4c
SELECT w.id_wisatawan, w.nama
FROM wisatawan w
LEFT JOIN pemesanan p ON w.id_wisatawan = p.id_wisatawan
WHERE p.id_pesan IS NULL
ORDER BY w.id_wisatawan ASC;

-- Soal 4d --
SELECT pt.id_paket, pt.nama_paket
FROM pemesanan p
RIGHT JOIN paket_tur pt ON p.id_paket = pt.id_paket
WHERE p.id_pesan IS NULL;
-- --------------------------------------------------------------------------- --

-- 5. Fungsi Agregasi dan GROUP BY --

-- Soal 5a --
SELECT STATUS, COUNT(id_pesan) AS jumlah_pesanan, SUM(jumlah_orang) AS total_peserta
FROM pemesanan
GROUP BY STATUS
ORDER BY STATUS ASC;

-- Soal 5b --
SELECT pt.nama_paket, SUM(pt.harga * p.jumlah_orang) AS pendapatan
FROM pemesanan p
INNER JOIN paket_tur pt ON p.id_paket = pt.id_paket
WHERE p.status = 'Lunas'
GROUP BY pt.id_paket, pt.nama_paket
ORDER BY pendapatan DESC;

-- Soal 5c --
SELECT asal_negara, COUNT(id_wisatawan) AS jumlah_wisatawan
FROM wisatawan
GROUP BY asal_negara
ORDER BY jumlah_wisatawan DESC, asal_negara ASC;

-- Soal 5d --
SELECT kabupaten, ROUND(AVG(harga_tiket), 2) AS rata_rata, MAX(harga_tiket) 
AS tertinggi, MIN(harga_tiket) AS terendah
FROM destinasi
GROUP BY kabupaten
ORDER BY rata_rata DESC;

-- Soal 5e --
SELECT w.nama, SUM(p.jumlah_orang) AS total_peserta
FROM pemesanan p
INNER JOIN wisatawan w ON p.id_wisatawan = w.id_wisatawan
WHERE p.status = 'Lunas'
GROUP BY w.id_wisatawan, w.nama
ORDER BY total_peserta DESC
LIMIT 3;



























































