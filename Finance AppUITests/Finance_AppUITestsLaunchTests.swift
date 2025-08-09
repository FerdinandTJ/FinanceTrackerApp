# 💰 Aplikasi Finance Tracker iOS

<div align="center">

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)
![SwiftData](https://img.shields.io/badge/SwiftData-Latest-purple.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

**Aplikasi pelacak keuangan pribadi yang indah dan modern dibangun dengan SwiftUI dan SwiftData**

[Fitur](#fitur) • [Screenshot](#screenshot) • [Instalasi](#instalasi) • [Cara Penggunaan](#cara-penggunaan) • [Kontribusi](#kontribusi)

</div>

---

## ✨ Fitur

### 📊 **Fungsionalitas Utama**
- **Manajemen Transaksi**: Tambah, edit, dan hapus transaksi pemasukan/pengeluaran
- **Kategorisasi Cerdas**: Kategori yang sudah tersedia untuk pemasukan dan pengeluaran
- **Pencarian Real-time**: Cari transaksi secara instan
- **Filter Lanjutan**: Filter berdasarkan jenis transaksi, rentang tanggal, dan kategori
- **Penyimpanan Data**: Semua data disimpan secara lokal menggunakan SwiftData

### 📈 **Analitik & Wawasan**
- **Grafik Interaktif**: Grafik pie, bar chart, dan line chart yang indah
- **Ringkasan Keuangan**: Kalkulasi saldo dan ringkasan secara real-time
- **Analisis Kategori**: Rincian detail pengeluaran berdasarkan kategori
- **Filter Berdasarkan Waktu**: Lihat data per minggu, bulan, tahun, atau semua waktu
- **Statistik Visual**: Halaman statistik komprehensif dengan wawasan mendalam

### 🎨 **Desain Modern**
- **UI yang Indah**: Background gradient modern dan animasi yang halus
- **UX yang Intuitif**: Antarmuka yang bersih dan mudah digunakan dengan haptic feedback
- **Mode Gelap/Terang**: Desain adaptif yang bekerja di kedua mode
- **Layout Responsif**: Dioptimalkan untuk semua ukuran layar iPhone
- **Polish Profesional**: Layout berbasis kartu dengan bayangan dan efek yang halus

### 🔧 **Fitur Teknis**
- **Integrasi SwiftData**: Pengganti Core Data modern untuk manajemen data
- **Framework Charts**: Visualisasi iOS Charts native yang indah
- **Arsitektur MVVM**: Struktur kode yang bersih dan mudah dipelihara
- **Async/Await**: Pola concurrency Swift modern
- **Error Handling**: Penanganan error dan validasi yang komprehensif

---

## 📱 Screenshot

### Dashboard Utama
<!-- TEMPLATE SCREENSHOT: Ganti dengan gambar dashboard utama Anda -->
<p align="center">
  <img src="screenshots/dashboard.png" alt="Dashboard Utama" width="300"/>
</p>

*Ringkasan bersih status keuangan Anda dengan kartu ringkasan yang indah*

### Manajemen Transaksi
<!-- TEMPLATE SCREENSHOT: Ganti dengan gambar form tambah transaksi -->
<p align="center">
  <img src="screenshots/add-transaction.png" alt="Tambah Transaksi" width="300"/>
</p>

*Form yang mudah digunakan untuk menambah dan mengedit transaksi dengan preview langsung*

### Analitik & Grafik
<!-- TEMPLATE SCREENSHOT: Ganti dengan gambar halaman statistik -->
<p align="center">
  <img src="screenshots/statistics.png" alt="Halaman Statistik" width="300"/>
</p>

*Statistik komprehensif dengan grafik interaktif dan wawasan mendalam*

### Fitur-Fitur Pintar
<!-- TEMPLATE SCREENSHOT: Ganti dengan gambar fitur filter dan pencarian -->
<div align="center">
  <img src="screenshots/search-filter.png" alt="Pencarian dan Filter" width="300"/>
  <img src="screenshots/transaction-list.png" alt="Daftar Transaksi" width="300"/>
</div>

*Filter lanjutan, fungsi pencarian, dan manajemen kategori yang canggih*

---

## 🚀 Instalasi

### Prasyarat
- **Xcode 15.0+**
- **iOS 16.0+** untuk deployment
- **macOS Ventura 13.0+** untuk pengembangan

### Instruksi Setup

1. **Clone repository**
   ```bash
   git clone https://github.com/username-anda/finance-tracker-ios.git
   cd finance-tracker-ios
   ```

2. **Buka di Xcode**
   ```bash
   open "Finance App.xcodeproj"
   ```

3. **Build dan Run**
   - Pilih target device atau simulator Anda
   - Tekan `Cmd + R` untuk build dan run
   - Tidak memerlukan dependency tambahan!

---

## 💻 Cara Penggunaan

### Menambah Transaksi
1. Tap tombol **hijau "+"** di pojok kanan atas
2. Isi detail transaksi:
   - **Judul**: Deskripsi transaksi
   - **Jumlah**: Jumlah dalam IDR (Rupiah Indonesia)
   - **Jenis**: Pemasukan atau Pengeluaran
   - **Kategori**: Pilih dari kategori yang sudah tersedia
   - **Tanggal**: Kapan transaksi terjadi
   - **Catatan**: Detail tambahan (opsional)
3. Preview transaksi Anda dan tap **Simpan**

### Melihat Statistik
1. Tap tombol **grafik biru** di pojok kiri atas
2. Gunakan filter untuk menyesuaikan tampilan:
   - **Periode Waktu**: Minggu Ini, Bulan Ini, Tahun Ini, Semua Waktu
   - **Jenis Grafik**: Pie Chart, Bar Chart, Line Chart
3. Jelajahi wawasan dan rincian kategori

### Mengelola Data
- **Edit**: Tap transaksi mana pun untuk mengubah detail
- **Hapus**: Geser kiri pada transaksi untuk menghapus dengan cepat
- **Cari**: Gunakan bar pencarian untuk menemukan transaksi tertentu
- **Filter**: Gunakan tombol filter untuk menampilkan hanya pemasukan atau pengeluaran

---

## 🏗️ Arsitektur

### Tech Stack
- **SwiftUI**: Framework UI deklaratif
- **SwiftData**: Layer persistensi data modern
- **Charts**: Framework charting iOS native
- **Combine**: Framework reactive programming

### Struktur Proyek
```
Finance App/
├── Models/
│   ├── Item.swift                 # Model data utama (Transaction)
│   └── TransactionType.swift      # Enum dan tipe data
├── Views/
│   ├── ContentView.swift          # Dashboard utama
│   ├── AddTransactionView.swift   # Form tambah transaksi
│   ├── EditTransactionView.swift  # Form edit transaksi
│   ├── StatisticsView.swift       # Dashboard analitik
│   └── ChartViews.swift          # Komponen grafik
├── Styles/
│   └── ModernUIComponents.swift   # Komponen UI yang dapat digunakan ulang
└── App/
    └── Finance_AppApp.swift       # Entry point aplikasi
```

### Pola Desain Utama
- **MVVM**: Arsitektur Model-View-ViewModel
- **Composition**: Komponen UI yang dapat digunakan ulang
- **Reactive Programming**: Manajemen state SwiftUI
- **Single Responsibility**: Setiap view memiliki tujuan yang jelas

---

## 🎨 Sistem Desain

### Palet Warna
- **Biru Utama**: `rgb(77, 153, 255)` - Navigasi dan aksen
- **Hijau Sukses**: `rgb(51, 204, 102)` - Pemasukan dan aksi positif
- **Merah Peringatan**: `rgb(255, 77, 102)` - Pengeluaran dan aksi negatif
- **Orange Aksen**: `rgb(255, 153, 51)` - Peringatan dan highlight

### Tipografi
- **Headlines**: SF Pro Display Bold
- **Body Text**: SF Pro Text Regular
- **Captions**: SF Pro Text Medium

### Komponen
- **Cards**: Sudut melengkung (16-24px) dengan bayangan halus
- **Buttons**: Background gradient dengan haptic feedback
- **Forms**: Field input bersih dengan styling modern
- **Charts**: Skema warna konsisten di semua visualisasi

---

## 🔮 Pengembangan Masa Depan

### Fitur yang Direncanakan
- [ ] **Fungsi Export**: Opsi export PDF dan CSV
- [ ] **Target Budget**: Tetapkan dan lacak budget bulanan/tahunan
- [ ] **Transaksi Berulang**: Pemasukan/pengeluaran berulang otomatis
- [ ] **Dukungan Multi-Mata Uang**: Dukungan untuk berbagai mata uang
- [ ] **Sinkronisasi Cloud**: Sinkronisasi iCloud antar perangkat
- [ ] **Widget**: Widget layar beranda iOS untuk wawasan cepat
- [ ] **Face ID/Touch ID**: Perlindungan aplikasi biometrik
- [ ] **Integrasi Bank**: Koneksi dengan akun bank (masa depan)

### Peningkatan Teknis
- [ ] **Unit Tests**: Cakupan test yang komprehensif
- [ ] **UI Tests**: Testing UI otomatis
- [ ] **Optimisasi Performa**: Optimisasi Core Data
- [ ] **Aksesibilitas**: Fitur VoiceOver dan aksesibilitas yang ditingkatkan
- [ ] **Lokalisasi**: Dukungan multi-bahasa

---

## 🤝 Kontribusi

Kontribusi sangat diterima! Berikut cara Anda dapat membantu:

### Memulai
1. **Fork** repository ini
2. **Buat** feature branch: `git checkout -b feature/fitur-amazing`
3. **Commit** perubahan Anda: `git commit -m 'Tambah fitur amazing'`
4. **Push** ke branch: `git push origin feature/fitur-amazing`
5. **Buka** Pull Request

### Panduan
- Ikuti panduan style Swift
- Tulis pesan commit yang jelas
- Tambahkan komentar untuk logic yang kompleks
- Test perubahan Anda secara menyeluruh
- Update dokumentasi sesuai kebutuhan

### Area untuk Kontribusi
- 🐛 **Bug Fixes**: Bantu kami membasmi bug
- ✨ **Fitur Baru**: Implementasikan fitur yang direncanakan
- 🎨 **Peningkatan UI/UX**: Tingkatkan pengalaman pengguna
- 📚 **Dokumentasi**: Perbaiki docs dan komentar kode
- 🧪 **Testing**: Tambah unit dan integration tests

---

## 📱 Template Screenshot

### Untuk menambahkan screenshot Anda sendiri:

1. **Buat folder `screenshots/` di root directory**
   ```bash
   mkdir screenshots
   ```

2. **Ambil screenshot dari aplikasi Anda dan simpan dengan nama:**
   - `dashboard.png` - Tampilan dashboard utama
   - `add-transaction.png` - Form tambah transaksi
   - `statistics.png` - Halaman statistik dan grafik
   - `search-filter.png` - Fitur pencarian dan filter
   - `transaction-list.png` - Daftar transaksi

3. **Ukuran yang disarankan:**
   - Width: 300-400px untuk screenshot tunggal
   - Pastikan screenshot jelas dan readable
   - Gunakan device frame untuk tampilan yang lebih profesional

4. **Tools untuk mengambil screenshot:**
   - Xcode Simulator: `Cmd + S`
   - Device Screenshots menggunakan Xcode
   - Tools seperti SimSim atau Screenshots.pro untuk frame

---

## 📝 Lisensi

Proyek ini dilisensikan di bawah **MIT License** - lihat file [LICENSE](LICENSE) untuk detail.

```
MIT License

Copyright (c) 2025 Timotheus Ferdinand Tjondrojo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 👨‍💻 Pembuat

**Timotheus Ferdinand Tjondrojo**
- GitHub: [@ferdinandtj](https://github.com/ferdinandtj)
- LinkedIn: [Timotheus Ferdinand](https://linkedin.com/in/timotheus-ferdinand)
- Email: timotheus.ferdinand@example.com

---

## 🙏 Ucapan Terima Kasih

- **Apple** untuk framework SwiftUI dan SwiftData
- **SF Symbols** untuk iconografi yang indah
- **iOS Charts** untuk capabilities charting
- **Swift Community** untuk inspirasi dan best practices

---

## 📊 Statistik Proyek

![GitHub repo size](https://img.shields.io/github/repo-size/ferdinandtj/finance-tracker-ios)
![GitHub last commit](https://img.shields.io/github/last-commit/ferdinandtj/finance-tracker-ios)
![GitHub issues](https://img.shields.io/github/issues/ferdinandtj/finance-tracker-ios)
![GitHub pull requests](https://img.shields.io/github/issues-pr/ferdinandtj/finance-tracker-ios)

---

<div align="center">

**⭐ Beri bintang pada repository ini jika terbantu!**

**Dibuat dengan ❤️ menggunakan SwiftUI**

</div>
