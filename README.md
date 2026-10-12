# Laporan Tugas Praktikum 2 & AI Design Exploration

**Nama:** Muhammad Althaf Farrel Natajaya  
**NIM:** 24.52.0004  
**Prodi:** S1 Teknologi Informasi  

---

## 1. Implementasi Aplikasi Academic Overview
Aplikasi ini dikembangkan dari *Student Dashboard* menjadi *Academic Overview* yang responsif dengan fitur:
- **Header Profil:** Menampilkan foto avatar, nama lengkap, NIM, dan program studi.
- **Kartu Informasi Akademik:** Menampilkan `Assignments`, `Attendance`, `Portfolio`, dan `Current Week`.
- **Responsive Layout:** Menggunakan `LayoutBuilder` dengan konstanta breakpoint `kWideBreakpoint = 700` (1 kolom pada layar sempit < 700px dan 2 kolom pada layar lebar >= 700px).
- **Light & Dark Theme:** Dilengkapi dengan `CupertinoSwitch` untuk berpindah tema secara dinamis.
- **Aksesibilitas:** Seluruh komponen penting dibungkus dengan widget `Semantics`.

---

## 2. AI Prompt Challenge & Exploration

### Prompt 1: Perbandingan Layout (`GridView` vs `LayoutBuilder` + `Column`)
* **Prompt:** *"Bandingkan dua tata letak dashboard akademik untuk Flutter: versi GridView dan versi LayoutBuilder + Column. Jelaskan trade-off responsif dan aksesibilitasnya."*
* **Output Ringkas AI:** 
  - `GridView` lebih efisien untuk grid item berukuran homogen dengan pengelolaan *scrolling* bawaan, namun pengaturannya lebih kaku untuk rasio aspek.
  - `LayoutBuilder + Column` memberikan fleksibilitas penuh dalam mengatur komponen heterogen (seperti gabungan Header Profil + Grid), namun membutuhkan pengelolaan *scroll* manual menggunakan `SingleChildScrollView`.
* **Keputusan Teknis:** Menggabungkan `SingleChildScrollView` + `Column` untuk menyusun Header Profil dan `GridView.count` untuk kartu informasi.

### Prompt 2: Analisis `Expanded` Overflow
* **Prompt:** *"Jelaskan kapan penggunaan Expanded justru menyebabkan overflow di dalam Row, beri contoh kode yang gagal dan perbaikannya."*
* **Output Ringkas AI:** `Expanded` menyebabkan *error* jika ditempatkan di dalam widget yang tidak memberikan batasan lebar (*unconstrained width*), seperti di dalam `Row` yang berada di dalam `SingleChildScrollView` horizontal tanpa ukuran terbatas.
* **Perbaikan:** Memastikan `Row` berada di dalam konteks parent yang membatasi lebarnya.

### Prompt 3: Audit Mandiri AI (Verification Prompt)
* **Prompt:** *"Periksa kembali rekomendasi layout di atas: apakah tetap responsif di bawah 600px, apakah mengurangi aksesibilitas, dan apakah ada widget yang tidak tersedia di Flutter stabil saat ini?"*
* **Hasil Verifikasi:** Rekomendasi aman, menggunakan widget stabil standar (`Material 3`, `CupertinoSwitch`, `Semantics`), serta responsif hingga ukuran mobile sempit (360px–400px).

---

## 3. Checklist Verifikasi & Testing
- [x] `flutter analyze` tidak menghasilkan error maupun warning.
- [x] `flutter test` lulus semua widget test responsif di folder `test/`.
- [x] Screenshot layar sempit dan lebar tersimpan pada folder `screenshots/`.