# FollupApp

Aplikasi ini menggunakan arsitektur **MVVM (Model-View-ViewModel)**.

## Arsitektur MVVM & Struktur Folder

```text
FollupApp/
├── Models/           # Data dan Logika Bisnis
├── ViewModels/       # Logika Presentasi (State & Data fetching)
├── Views/            # Tampilan (User Interface)
│   ├── Components/   # Reusable UI (Card, Button, dll)
│   └── Pages/        # Screen Utama (Layar Penuh)
├── Extensions/       # Fungsi tambahan (Color, Utils, dll)
└── Assets.xcassets/  # Gambar, Ikon, dan Warna
```

### 1. Models (`/Models`)
**Fungsi:** Menyimpan struktur data (biasanya berupa `struct` atau `class`) dan logika bisnis murni yang independen dari UI.
**Apa yang ditaruh di sini?**
- Representasi data/objek, misalnya data dari response API (`User`, `SummaryCardModel`, dll).
- Parsing JSON, mapping data.

### 2. ViewModels (`/ViewModels`)
**Fungsi:** Menjadi jembatan perantara (mediator) antara Model dan View. ViewModel mengelola state (kondisi) data untuk View, serta menangani aksi dari View.
**Apa yang ditaruh di sini?**
- Class yang menggunakan `@Observable` atau mematuhi `ObservableObject`.
- Variabel state yang dipantau oleh View (menggunakan `@Published`).
- Logika pengambilan data dari API atau database lokal, lalu memprosesnya untuk ditampilkan.
- Fungsi untuk menangani interaksi user yang kompleks dari View (contoh: `DashboardViewModel`).

### 3. Views (`/Views`)
**Fungsi:** Mengatur tata letak dan tampilan aplikasi (User Interface) menggunakan SwiftUI. **Jangan ada** pemanggilan API atau logika bisnis yang rumit di sini. View hanya bertugas untuk menampilkan state dari ViewModel.
**Apa yang ditaruh di sini?**
- **`/Pages`:** Untuk tampilan layar utama secara penuh (misalnya: `DashboardView`, `LoginView`).
- **`/Components`:** Untuk potongan UI kecil yang bisa dipakai ulang (reusable) di banyak tempat (misalnya: `SummaryCardView`, tombol custom, form input).

### 4. Extensions (`/Extensions`)
**Fungsi:** Tempat menyimpan fungsi bantuan tambahan yang memperluas tipe data bawaan (String, Date, Color, View).
**Apa yang ditaruh di sini?**
- Definisi warna khusus dari aset (`ColorTheme.swift`).
- Extension untuk format tanggal (`Date+Formatter.swift`).
- Helper fungsi untuk merapikan kode.

## Contoh Alur Kerja (Workflow)
1. Ingin buat halaman baru? Buat UI-nya di folder `Views/Pages/`.
2. Butuh data dari API untuk halaman tersebut? Buat class di folder `ViewModels/`, tarik datanya di sana.
3. Struktur datanya seperti apa? Definisikan `struct`-nya di folder `Models/`.
4. Di file View, panggil ViewModel tersebut (misal pakai `@StateObject` atau `@EnvironmentObject`) dan tampilkan datanya.
