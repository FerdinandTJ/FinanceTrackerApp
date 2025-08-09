# 💰 Aplikasi Finance Tracker iOS

<div align="center">

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)
![SwiftData](https://img.shields.io/badge/SwiftData-Latest-purple.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

**Aplikasi pelacak keuangan pribadi yang indah dan modern dibuat dengan SwiftUI dan SwiftData**

[Fitur](#fitur) • [Screenshot](#screenshot) • [Instalasi](#instalasi) • [Cara Penggunaan](#cara-penggunaan) • [Kontribusi](#kontribusi)

</div>

---

## ✨ Fitur

### 📊 **Fungsi Utama**
- **Manajemen Transaksi**: Tambah, edit, dan hapus transaksi pemasukan/pengeluaran
- **Kategorisasi Cerdas**: Kategori yang telah ditentukan untuk pemasukan dan pengeluaran
- **Pencarian Real-time**: Cari transaksi secara instan
- **Filter Lanjutan**: Filter berdasarkan jenis transaksi, rentang tanggal, dan kategori
- **Persistensi Data**: Semua data disimpan secara lokal menggunakan SwiftData

### 📈 **Analitik & Wawasan**
- **Grafik Interaktif**: Grafik lingkaran, batang, dan garis yang indah
- **Ringkasan Keuangan**: Perhitungan saldo dan ringkasan secara real-time
- **Analisis Kategori**: Rincian detail pengeluaran berdasarkan kategori
- **Filter Berdasarkan Waktu**: Lihat data per minggu, bulan, tahun, atau semua waktu
- **Statistik Visual**: Halaman statistik komprehensif dengan wawasan

### 🎨 **Desain Modern**
- **UI yang Indah**: Latar belakang gradien modern dan animasi yang halus
- **UX yang Intuitif**: Antarmuka yang bersih dan ramah pengguna dengan umpan balik haptik
- **Mode Gelap/Terang**: Desain adaptif yang bekerja di kedua mode
- **Layout Responsif**: Dioptimalkan untuk semua ukuran layar iPhone
- **Sentuhan Profesional**: Layout berbasis kartu dengan bayangan halus dan efek

### 🔧 **Fitur Teknis**
- **Integrasi SwiftData**: Pengganti Core Data modern untuk manajemen data
- **Framework Charts**: Charts iOS native untuk visualisasi yang indah
- **Arsitektur MVVM**: Struktur kode yang bersih dan dapat dipelihara
- **Async/Await**: Pola concurrency Swift modern
- **Error Handling**: Penanganan kesalahan dan validasi yang komprehensif

---

## 📱 Screenshot

### Dashboard Utama
> Tampilan bersih status keuangan Anda dengan kartu ringkasan yang indah

### Manajemen Transaksi
> Form yang mudah digunakan untuk menambah dan mengedit transaksi dengan pratinjau langsung

### Analitik & Grafik
> Statistik komprehensif dengan grafik interaktif dan wawasan

### Fitur Cerdas
> Filter lanjutan, fungsi pencarian, dan manajemen kategori

---

## 🚀 Instalasi

### Prasyarat
- **Xcode 15.0+**
- **iOS 16.0+** target deployment
- **macOS Ventura 13.0+** untuk pengembangan

### Petunjuk Setup

1. **Clone repository**
   ```bash
   git clone https://github.com/FerdinandTJ/FinanceTrackerApp.git
   cd FinanceTrackerApp
   ```

2. **Buka di Xcode**
   ```bash
   open "Finance App.xcodeproj"
   ```

3. **Build dan Run**
   - Pilih target device atau simulator Anda
   - Tekan `Cmd + R` untuk build dan run
   - Tidak ada dependensi tambahan yang diperlukan!

---

## 💻 Cara Penggunaan

### Menambah Transaksi
1. Tap tombol **hijau "+"** di pojok kanan atas
2. Isi detail transaksi:
   - **Judul**: Deskripsi transaksi
   - **Jumlah**: Jumlah dalam IDR (Rupiah Indonesia)
   - **Jenis**: Pemasukan atau Pengeluaran
   - **Kategori**: Pilih dari kategori yang telah ditentukan
   - **Tanggal**: Kapan transaksi terjadi
   - **Catatan**: Detail tambahan opsional
3. Pratinjau transaksi Anda dan tap **Simpan**

### Melihat Statistik
1. Tap tombol **biru chart** di pojok kiri atas
2. Gunakan filter untuk menyesuaikan tampilan Anda:
   - **Periode Waktu**: Minggu Ini, Bulan Ini, Tahun Ini, Semua Waktu
   - **Jenis Grafik**: Grafik Lingkaran, Grafik Batang, Grafik Garis
3. Jelajahi wawasan dan rincian kategori

### Mengelola Data
- **Edit**: Tap transaksi apa pun untuk mengubah detail
- **Hapus**: Geser kiri pada transaksi untuk penghapusan cepat
- **Cari**: Gunakan bar pencarian untuk menemukan transaksi tertentu
- **Filter**: Gunakan filter pill untuk menampilkan hanya pemasukan atau pengeluaran

---

## 🏗️ Arsitektur

### Tech Stack
- **SwiftUI**: Framework UI deklaratif
- **SwiftData**: Layer persistensi data modern
- **Charts**: Framework charting iOS native
- **Combine**: Framework pemrograman reaktif

### Struktur Project
```
Finance App/
├── Models/
│   ├── Transaction.swift          # Model data utama
│   └── TransactionType.swift      # Enum dan tipe
├── Views/
│   ├── ContentView.swift          # Dashboard utama
│   ├── AddTransactionView.swift   # Form tambah transaksi
│   ├── EditTransactionView.swift  # Form edit transaksi
│   ├── StatisticsView.swift       # Dashboard analitik
│   └── ChartViews.swift          # Komponen chart
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
- **Headline**: SF Pro Display Bold
- **Body Text**: SF Pro Text Regular
- **Caption**: SF Pro Text Medium

### Komponen
- **Card**: Sudut membulat (16-24px) dengan bayangan halus
- **Button**: Latar belakang gradien dengan umpan balik haptik
- **Form**: Field input bersih dengan styling modern
- **Chart**: Skema warna konsisten di semua visualisasi

---

## 🔮 Pengembangan Masa Depan

### Fitur yang Direncanakan
- [ ] **Fungsi Ekspor**: Opsi ekspor PDF dan CSV
- [ ] **Target Budget**: Tetapkan dan lacak budget bulanan/tahunan
- [ ] **Transaksi Berulang**: Pemasukan/pengeluaran berulang otomatis
- [ ] **Dukungan Multi-Mata Uang**: Dukungan untuk berbagai mata uang
- [ ] **Sinkronisasi Cloud**: Sinkronisasi iCloud antar perangkat
- [ ] **Widget**: Widget layar beranda iOS untuk wawasan cepat
- [ ] **Face ID/Touch ID**: Perlindungan aplikasi biometrik
- [ ] **Integrasi Bank**: Koneksi dengan rekening bank (masa depan)

### Peningkatan Teknis
- [ ] **Unit Test**: Cakupan tes yang komprehensif
- [ ] **UI Test**: Testing UI otomatis
- [ ] **Optimisasi Performa**: Optimisasi Core Data
- [ ] **Aksesibilitas**: Fitur VoiceOver dan aksesibilitas yang ditingkatkan
- [ ] **Lokalisasi**: Dukungan multi-bahasa

---

## 🤝 Kontribusi

Kontribusi sangat diterima! Berikut cara Anda dapat membantu:

### Memulai
1. **Fork** repository
2. **Buat** branch fitur: `git checkout -b feature/fitur-menakjubkan`
3. **Commit** perubahan Anda: `git commit -m 'Tambah fitur menakjubkan'`
4. **Push** ke branch: `git push origin feature/fitur-menakjubkan`
5. **Buka** Pull Request

### Panduan
- Ikuti panduan gaya Swift
- Tulis pesan commit yang jelas
- Tambahkan komentar untuk logika kompleks
- Tes perubahan Anda secara menyeluruh
- Perbarui dokumentasi sesuai kebutuhan

### Area untuk Kontribusi
- 🐛 **Perbaikan Bug**: Bantu kami mengatasi bug
- ✨ **Fitur Baru**: Implementasikan fitur yang direncanakan
- 🎨 **Peningkatan UI/UX**: Tingkatkan pengalaman pengguna
- 📚 **Dokumentasi**: Perbaiki docs dan komentar kode
- 🧪 **Testing**: Tambah unit dan integration test

---

## 📝 Lisensi

Project ini dilisensikan di bawah **MIT License** - lihat file [LICENSE](LICENSE) untuk detail.

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

## 👨‍💻 Penulis

**Timotheus Ferdinand Tjondrojo**
- GitHub: [@FerdinandTJ](https://github.com/FerdinandTJ)
- LinkedIn: [ferdinandtj](https://www.linkedin.com/in/ferdinandtj/)
- Email: ferdinandtj@example.com

---

## 🙏 Ucapan Terima Kasih

- **Apple** untuk framework SwiftUI dan SwiftData
- **SF Symbols** untuk ikonografi yang indah
- **iOS Charts** untuk kemampuan charting
- **Swift Community** untuk inspirasi dan praktik terbaik

---

## 📊 Statistik Project

![GitHub repo size](https://img.shields.io/github/repo-size/FerdinandTJ/FinanceTrackerApp)
![GitHub last commit](https://img.shields.io/github/last-commit/FerdinandTJ/FinanceTrackerApp)
![GitHub issues](https://img.shields.io/github/issues/FerdinandTJ/FinanceTrackerApp)
![GitHub pull requests](https://img.shields.io/github/issues-pr/FerdinandTJ/FinanceTrackerApp)

---

<div align="center">

**⭐ Beri bintang pada repository ini jika bermanfaat!**

**Dibuat dengan ❤️ menggunakan SwiftUI**

</div>