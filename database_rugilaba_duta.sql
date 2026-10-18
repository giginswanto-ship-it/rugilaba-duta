-- ========================================================================
-- DATABASE LAPORAN KEUANGAN KONSOLIDASI MULTI-UNIT (RUGILABA DUTA)
-- ENTITAS: Shop & Drive | Snaprint Grand Wisata | Snaprint Zamrud
-- STANDAR AKUNTANSI: SAK EMKM / Ketentuan Perpajakan UU HPP No. 7/2021
-- STATUS DATA: Bersih / Siap Input (Tanpa Data Dummy)
-- ========================================================================

CREATE DATABASE IF NOT EXISTS `db_rugilaba_duta` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_rugilaba_duta`;

-- ------------------------------------------------------------------------
-- 1. TABEL UNIT USAHA
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `unit_usaha`;
CREATE TABLE `unit_usaha` (
  `id_unit` VARCHAR(10) NOT NULL PRIMARY KEY,
  `nama_unit` VARCHAR(100) NOT NULL,
  `bidang_usaha` VARCHAR(100) NOT NULL,
  `lokasi` VARCHAR(150) DEFAULT NULL,
  `management_fee_rate` DECIMAL(5,4) DEFAULT 0.0000 COMMENT 'Tarif Management Fee (contoh: 0.0300 untuk S&D)',
  `keterangan` TEXT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `unit_usaha` (`id_unit`, `nama_unit`, `bidang_usaha`, `lokasi`, `management_fee_rate`, `keterangan`) VALUES
('unit_a', 'Shop & Drive', 'Otomotif, Aki, Oli & Servis Cepat', 'Outlet Shop & Drive', 0.0300, 'Dikenakan Management Fee 3% dari Penjualan Kotor'),
('unit_b', 'Snaprint Grand Wisata', 'Digital Printing Large Format & Outdoor', 'Grand Wisata Bekasi', 0.0000, 'Spesialis cetak outdoor, billboard, banner & UV roll'),
('unit_c', 'Snaprint Zamrud', 'Production Press A3+, Copy Center & Retail', 'Zamrud Bekasi', 0.0000, 'Spesialis kartu nama, brosur, merchandise & finishing'),
('unit_hq', 'Kantor Pusat / Holding', 'Manajemen Bersama, Legal, IT & Server', 'Kantor Pusat Duta', 0.0000, 'Alokasi inventaris bersama dan biaya holding');

-- ------------------------------------------------------------------------
-- 2. TABEL KERANJANG PEMASUKAN & HPP BULANAN PER UNIT USAHA
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `pemasukan_bulanan`;
CREATE TABLE `pemasukan_bulanan` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tahun` INT NOT NULL,
  `bulan` INT NOT NULL COMMENT '1 sampai 12',
  `nama_bulan` VARCHAR(20) NOT NULL,
  `kuartal` VARCHAR(5) NOT NULL,
  `id_unit` VARCHAR(10) NOT NULL,
  `omzet_kotor` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `hpp` DECIMAL(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Harga Pokok Penjualan Bulanan',
  `potongan_retur` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `management_fee` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `pendapatan_bersih` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `laba_kotor` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `tanggal_input` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`id_unit`) REFERENCES `unit_usaha`(`id_unit`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Inisialisasi Matriks 12 Bulan Tahun Buku 2026 (Nilai Bersih / 0.00)
INSERT INTO `pemasukan_bulanan` (`tahun`, `bulan`, `nama_bulan`, `kuartal`, `id_unit`, `omzet_kotor`, `hpp`, `potongan_retur`, `management_fee`, `pendapatan_bersih`, `laba_kotor`) VALUES
(2026, 1, 'Januari', 'Q1', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 1, 'Januari', 'Q1', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 1, 'Januari', 'Q1', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 2, 'Februari', 'Q1', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 2, 'Februari', 'Q1', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 2, 'Februari', 'Q1', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 3, 'Maret', 'Q1', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 3, 'Maret', 'Q1', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 3, 'Maret', 'Q1', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 4, 'April', 'Q2', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 4, 'April', 'Q2', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 4, 'April', 'Q2', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 5, 'Mei', 'Q2', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 5, 'Mei', 'Q2', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 5, 'Mei', 'Q2', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 6, 'Juni', 'Q2', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 6, 'Juni', 'Q2', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 6, 'Juni', 'Q2', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 7, 'Juli', 'Q3', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 7, 'Juli', 'Q3', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 7, 'Juli', 'Q3', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 8, 'Agustus', 'Q3', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 8, 'Agustus', 'Q3', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 8, 'Agustus', 'Q3', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 9, 'September', 'Q3', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 9, 'September', 'Q3', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 9, 'September', 'Q3', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 10, 'Oktober', 'Q4', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 10, 'Oktober', 'Q4', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 10, 'Oktober', 'Q4', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 11, 'November', 'Q4', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 11, 'November', 'Q4', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 11, 'November', 'Q4', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),

(2026, 12, 'Desember', 'Q4', 'unit_a', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 12, 'Desember', 'Q4', 'unit_b', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(2026, 12, 'Desember', 'Q4', 'unit_c', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00);

-- ------------------------------------------------------------------------
-- 3. TABEL HARGA POKOK PENJUALAN (HPP) / BIAYA LANGSUNG TAHUNAN
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `harga_pokok_penjualan`;
CREATE TABLE `harga_pokok_penjualan` (
  `id_hpp` INT AUTO_INCREMENT PRIMARY KEY,
  `tahun` INT NOT NULL,
  `id_unit` VARCHAR(10) NOT NULL,
  `bahan_baku_sukucadang` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `upah_tenaga_kerja_langsung` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (`id_unit`) REFERENCES `unit_usaha`(`id_unit`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `harga_pokok_penjualan` (`tahun`, `id_unit`, `bahan_baku_sukucadang`, `upah_tenaga_kerja_langsung`) VALUES
(2026, 'unit_a', 0.00, 0.00),
(2026, 'unit_b', 0.00, 0.00),
(2026, 'unit_c', 0.00, 0.00);

-- ------------------------------------------------------------------------
-- 4. TABEL RINCIAN BIAYA OPERASIONAL (OPEX)
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `biaya_operasional`;
CREATE TABLE `biaya_operasional` (
  `id_biaya` INT AUTO_INCREMENT PRIMARY KEY,
  `kode_kategori` VARCHAR(50) NOT NULL,
  `nama_kategori` VARCHAR(150) NOT NULL,
  `tahun` INT NOT NULL,
  `nominal_a` DECIMAL(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Shop & Drive',
  `nominal_b` DECIMAL(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Snaprint Grand Wisata',
  `nominal_c` DECIMAL(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Snaprint Zamrud'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biaya_operasional` (`kode_kategori`, `nama_kategori`, `tahun`, `nominal_a`, `nominal_b`, `nominal_c`) VALUES
('gaji', '1. Gaji & Tunjangan Staf Toko / Kasir / Frontline', 2026, 0.00, 0.00, 0.00),
('sewa', '2. Sewa Tempat / Lokasi Outlet & IPL', 2026, 0.00, 0.00, 0.00),
('utilitas', '3. Listrik Daya Tinggi, Air & Internet', 2026, 0.00, 0.00, 0.00),
('marketing', '4. Pemasaran, Iklan Digital & Promosi', 2026, 0.00, 0.00, 0.00),
('perawatan', '5. Servis Mesin, Kalibrasi & Tooling Khusus', 2026, 0.00, 0.00, 0.00),
('perlengkapan', '6. Perlengkapan Kerja, Packaging & ATK', 2026, 0.00, 0.00, 0.00),
('limbah_k3', '7. Pengelolaan Limbah B3/Sampah & K3', 2026, 0.00, 0.00, 0.00),
('software', '8. Lisensi POS, Adobe CC, RIP & Merchant Fee', 2026, 0.00, 0.00, 0.00);

-- ------------------------------------------------------------------------
-- 5. TABEL JADWAL PENYUSUTAN ASET TETAP (DEPRESIASI FISKAL)
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `aset_tetap`;
CREATE TABLE `aset_tetap` (
  `kode_aset` VARCHAR(20) NOT NULL PRIMARY KEY,
  `nama_aset` VARCHAR(150) NOT NULL,
  `id_unit` VARCHAR(10) NOT NULL,
  `harga_perolehan` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `kelompok_fiskal` VARCHAR(30) NOT NULL,
  `masa_manfaat_tahun` INT NOT NULL,
  `tarif_susut` DECIMAL(5,2) NOT NULL,
  `beban_susut_tahunan` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (`id_unit`) REFERENCES `unit_usaha`(`id_unit`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- (Tabel aset_tetap bersih tanpa data dummy, siap diisi aset nyata perusahaan)

-- ------------------------------------------------------------------------
-- 6. TABEL BIAYA HOLDING & PENDAPATAN LAIN
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS `biaya_holding_pendapatan_lain`;
CREATE TABLE `biaya_holding_pendapatan_lain` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tahun` INT NOT NULL,
  `alokasi_holding_overhead` DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  `pendapatan_jasa_giro_bunga` DECIMAL(15,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `biaya_holding_pendapatan_lain` (`tahun`, `alokasi_holding_overhead`, `pendapatan_jasa_giro_bunga`) VALUES
(2026, 0.00, 0.00);

-- ------------------------------------------------------------------------
-- 7. VIEW REKAPITULASI LAPORAN LABA RUGI KONSOLIDASI (TAHUNAN)
-- ------------------------------------------------------------------------
CREATE OR REPLACE VIEW `v_rekap_omzet_tahunan` AS
SELECT 
    u.id_unit,
    u.nama_unit,
    SUM(p.omzet_kotor) AS total_omzet_kotor,
    SUM(p.hpp) AS total_hpp,
    SUM(p.potongan_retur) AS total_potongan_retur,
    SUM(p.management_fee) AS total_management_fee,
    SUM(p.pendapatan_bersih) AS total_net_revenue,
    SUM(p.laba_kotor) AS total_laba_kotor
FROM unit_usaha u
LEFT JOIN pemasukan_bulanan p ON u.id_unit = p.id_unit
WHERE u.id_unit IN ('unit_a', 'unit_b', 'unit_c')
GROUP BY u.id_unit, u.nama_unit;

-- ========================================================================
-- CATATAN INTEGRASI:
-- File SQL ini dapat diimport langsung ke MySQL, MariaDB, phpMyAdmin, DBeaver,
-- Navicat, PostgreSQL, atau SQLite untuk diakses dari device / server lain.
-- ========================================================================
