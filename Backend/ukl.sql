-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 24 Bulan Mei 2022 pada 18.50
-- Versi server: 8.0.29-0ubuntu0.20.04.3
-- Versi PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ukl`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id_detail_transaksi` int NOT NULL,
  `id_transaksi` int NOT NULL,
  `id_paket` int NOT NULL,
  `qty` double DEFAULT NULL,
  `keterangan` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `member`
--

CREATE TABLE `member` (
  `id_member` int NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` text,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `tlp` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `member`
--

INSERT INTO `member` (`id_member`, `nama`, `alamat`, `jenis_kelamin`, `tlp`, `createdAt`, `updatedAt`) VALUES
(1, 'member1', 'Pasuruan', 'P', '123456', '2022-05-18 10:26:11', '2022-05-18 18:14:47'),
(2, 'member2', 'Nganjuk', 'L', '12345', '2022-05-18 10:54:00', '2022-05-18 10:54:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `outlet`
--

CREATE TABLE `outlet` (
  `id_outlet` int NOT NULL,
  `id_user` int DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` text,
  `tlp` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `outlet`
--

INSERT INTO `outlet` (`id_outlet`, `id_user`, `nama`, `alamat`, `tlp`, `createdAt`, `updatedAt`) VALUES
(1, NULL, 'LaundryKu 2', 'Nganjuk', '0821900219021', '2022-05-18 17:13:16', '2022-05-18 10:19:48'),
(3, NULL, 'LaundryKu 1', 'Mojokerto', '082190219021', '2022-05-18 10:54:26', '2022-05-18 17:46:54'),
(5, NULL, 'LaundryJajar', 'Sawojajar Malang', '082140819001', '2022-05-18 17:50:55', '2022-05-18 17:50:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `paket`
--

CREATE TABLE `paket` (
  `id_paket` int NOT NULL,
  `id_outlet` int NOT NULL,
  `jenis` enum('kiloan','selimut','bed_cover','kaos','kain') DEFAULT NULL,
  `nama_paket` varchar(255) DEFAULT NULL,
  `harga` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `paket`
--

INSERT INTO `paket` (`id_paket`, `id_outlet`, `jenis`, `nama_paket`, `harga`, `createdAt`, `updatedAt`) VALUES
(8, 3, 'kiloan', 'baju putih', 15000, '2022-05-18 14:30:50', '2022-05-18 14:52:17'),
(15, 1, 'kaos', 'Baju Putih', 5000, '2022-05-24 11:47:07', '2022-05-24 11:47:07'),
(16, 1, 'kiloan', 'Kemeja', 7000, '2022-05-24 11:47:22', '2022-05-24 11:47:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `SequelizeMeta`
--

CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Dumping data untuk tabel `SequelizeMeta`
--

INSERT INTO `SequelizeMeta` (`name`) VALUES
('20220412035039-create-member.js'),
('20220412035250-create-outlet.js'),
('20220412035622-create-user.js'),
('20220412035943-create-paket.js'),
('20220412040830-create-transaksi.js'),
('20220412041020-create-detail-transaksi.js');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int NOT NULL,
  `id_outlet` int NOT NULL,
  `kode_invoice` varchar(255) DEFAULT NULL,
  `id_member` int NOT NULL,
  `tgl` datetime DEFAULT NULL,
  `batas_waktu` datetime DEFAULT NULL,
  `tgl_bayar` datetime DEFAULT NULL,
  `biaya_tambahan` int DEFAULT NULL,
  `diskon` double DEFAULT NULL,
  `pajak` int DEFAULT NULL,
  `status` enum('baru','proses','selesai','diambil') DEFAULT NULL,
  `dibayar` enum('dibayar','belum_bayar') DEFAULT NULL,
  `id_user` int NOT NULL,
  `total` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` text,
  `id_outlet` int NOT NULL,
  `role` enum('admin','kasir','owner') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `password`, `id_outlet`, `role`, `createdAt`, `updatedAt`) VALUES
(2, 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 'admin', '2022-05-18 10:17:58', '2022-05-18 10:17:58'),
(4, 'owner', 'owner', '72122ce96bfec66e2396d2e25225d70a', 1, 'owner', '2022-05-18 10:23:49', '2022-05-18 10:23:49'),
(8, 'kasir', 'kasir', '827ccb0eea8a706c4c34a16891f84e7b', 1, 'kasir', '2022-05-24 11:38:23', '2022-05-24 11:48:54');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id_detail_transaksi`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_paket` (`id_paket`);

--
-- Indeks untuk tabel `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indeks untuk tabel `outlet`
--
ALTER TABLE `outlet`
  ADD PRIMARY KEY (`id_outlet`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `paket`
--
ALTER TABLE `paket`
  ADD PRIMARY KEY (`id_paket`),
  ADD KEY `id_outlet` (`id_outlet`);

--
-- Indeks untuk tabel `SequelizeMeta`
--
ALTER TABLE `SequelizeMeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_outlet` (`id_outlet`),
  ADD KEY `id_member` (`id_member`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_outlet` (`id_outlet`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id_detail_transaksi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `member`
--
ALTER TABLE `member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `outlet`
--
ALTER TABLE `outlet`
  MODIFY `id_outlet` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `paket`
--
ALTER TABLE `paket`
  MODIFY `id_paket` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`id_paket`) REFERENCES `paket` (`id_paket`);

--
-- Ketidakleluasaan untuk tabel `paket`
--
ALTER TABLE `paket`
  ADD CONSTRAINT `paket_ibfk_1` FOREIGN KEY (`id_outlet`) REFERENCES `outlet` (`id_outlet`);

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_outlet`) REFERENCES `outlet` (`id_outlet`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_member`) REFERENCES `member` (`id_member`),
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Ketidakleluasaan untuk tabel `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`id_outlet`) REFERENCES `outlet` (`id_outlet`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
