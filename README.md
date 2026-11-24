# Starter Laporan Praktikum Typst

Dokumen ini menjelaskan cara mengedit, membuat pertemuan baru, menambahkan gambar, tabel, kode program, dan daftar pustaka untuk laporan praktikum berbasis Typst.

## 1. Persyaratan

Pasang perangkat berikut:

- Visual Studio Code.
- Ekstensi **Tinymist Typst**.
- Typst CLI untuk kompilasi melalui terminal.
- Font **Times New Roman** pada sistem operasi.

Template menggunakan kertas A4, margin, font, dan ukuran teks yang terpusat di `template/config.typ`. Jika Times New Roman tidak tersedia, instal font tersebut atau ubah pengaturan `font` pada file konfigurasi bersama.

## 2. Struktur Proyek

- `template/main.typ` — komponen bersama untuk cover, daftar isi, daftar gambar, penomoran, heading, isi, dan daftar pustaka.
- `template/config.typ` — satu file konfigurasi tampilan yang dipakai seluruh pertemuan.
- `template/meeting-template/` — scaffold sumber untuk membuat folder laporan pertemuan baru.
- `template/components/` — komponen pendukung cover, gambar, tabel, dan kode program.
- `template/styles/` — pengaturan halaman, tipografi, dan penomoran yang dipertahankan sebagai referensi.
- `meetings/` — satu folder mandiri untuk setiap pertemuan.
- `output/` — PDF hasil kompilasi.
- `.github/` — instruksi dan prompt Copilot untuk proyek ini.
- `AGENTS.md` — aturan penyusunan dan pengembangan laporan.

Setiap laporan berada dalam folder terpisah. Template bersama tidak boleh disalin ke folder pertemuan.

## 3. Quick Guide Mengubah Laporan yang Sudah Ada

Untuk mengedit laporan pertemuan 01:

1. Buka `meetings/pertemuan-01/report.typ`.
2. Gunakan preview Tinymist untuk melihat perubahan.
3. Ubah identitas dan metadata pada `meetings/pertemuan-01/metadata.typ`.
4. Ubah judul bagian, teori, hasil praktikum, pembahasan, kesimpulan, dan referensi pada `report.typ`.
5. Simpan file sebelum memeriksa preview.
6. Kompilasi melalui terminal dari root proyek:

   ```powershell
   typst compile --root . meetings\pertemuan-01\report.typ output\pertemuan-01.pdf
   ```

Folder `output/` akan dibuat terlebih dahulu jika belum tersedia.

### Menonaktifkan Daftar Isi atau Daftar Gambar untuk Satu Laporan

Template menyediakan opsi `show-toc` dan `show-figures` pada `make-report`. Keduanya bernilai `true` secara default, sehingga laporan lain tetap menampilkan daftar seperti biasa.

Untuk menonaktifkan Daftar Isi dan Daftar Gambar hanya pada satu laporan, ubah pemanggilan `make-report` di bagian atas file `report.typ` tersebut:

```typ
#show: doc => make-report(
  metadata,
  doc,
  show-toc: false,
  show-figures: false,
)
```

Untuk menonaktifkan salah satu saja, atur opsi yang diperlukan ke `false` dan biarkan opsi lainnya tetap `true`:

```typ
#show: doc => make-report(
  metadata,
  doc,
  show-toc: false,
  show-figures: true,
)
```

Opsi ini hanya berlaku pada laporan yang pemanggilan `make-report`-nya diubah. Penomoran halaman dan isi laporan tetap digunakan.

## 4. Quick Guide Membuat Pertemuan Baru

Setiap pertemuan baru dibuat dari scaffold yang berada di `template/meeting-template/`. Jangan menyalin folder pertemuan lama beserta isinya.

1. Buat folder pertemuan baru:

   ```powershell
   xcopy template\meeting-template meetings\pertemuan-02 /E /I
   ```

2. Edit metadata pada `meetings/pertemuan-02/metadata.typ`:

   ```typ
   meeting: "Pertemuan 02",
   topic: "Judul Materi Praktikum",
   student: "Nama Mahasiswa",
   student-id: "Nomor Induk Mahasiswa",
   class: "Nama Kelas",
   lecturer: "Nama Dosen",
   year: "2026",
   ```

3. Isi konten pada `meetings/pertemuan-02/report.typ`.
4. Tambahkan logo atau gambar ke `meetings/pertemuan-02/assets/`.
5. Perbarui `meetings/pertemuan-02/references.bib`.
6. Kompilasi dan periksa PDF:

   ```powershell
   typst compile --root . meetings\pertemuan-02\report.typ output\pertemuan-02.pdf
   ```

Scaffold sudah menyertakan logo UGM dan metadata menunjuk ke file tersebut. Jika menggunakan logo lain, salin file logo ke folder `assets/` pada pertemuan baru, lalu ubah nilai `logo`:

```typ
logo: image("assets/logo-ugm.png", width: 5.5cm),
```

Perubahan template bersama di `template/main.typ` atau `template/config.typ` akan otomatis diterapkan pada semua pertemuan.

## 5. Mengubah Metadata dan Cover

Metadata laporan dipisahkan dari isi laporan dan ditempatkan pada `metadata.typ` di folder pertemuan. Field yang tersedia meliputi:

- `report-title`
- `course`
- `meeting`
- `topic`
- `student`
- `student-id`
- `class`
- `lecturer`
- `program`
- `department`
- `faculty`
- `university`
- `city`
- `year`
- `logo`

Hanya ubah nilai di sebelah kanan tanda titik dua. Jangan mengubah nama field karena template membaca nama tersebut secara langsung.

Contoh perubahan nama mata kuliah:

```typ
course: "Pemrograman Web 2",
```

## 6. Menulis Heading dan Isi

Gunakan heading Typst seperti berikut:

```typ
= Tujuan Praktikum

#isi(level: 1)[
  Tuliskan tujuan praktikum yang benar-benar dilakukan.
]

== Dasar Teori

#isi(level: 2)[
  Tuliskan dasar teori yang mendukung kegiatan praktikum.
]

=== Konsep Pendukung

#isi(level: 3)[
  Tambahkan penjelasan lanjutan pada tingkat ini.
]
```

Penomoran otomatis:

- `= Heading` menghasilkan angka Romawi besar, misalnya `I.`, `II.`, dan seterusnya.
- `== Heading` menghasilkan huruf besar, misalnya `A.`, `B.`, dan seterusnya.
- `=== Heading` menghasilkan angka Arab, misalnya `1.`, `2.`, dan seterusnya.

Gunakan `#isi(...)` untuk teks isi agar indentasi konsisten. Format paragraf:

- Isi level 1 cocok untuk teks di bawah heading utama.
- Isi level 2 cocok untuk teks di bawah heading tingkat 2.
- Isi level 3 cocok untuk teks di bawah heading tingkat 3.

Jangan mengatur indentasi manual pada setiap paragraf, kecuali ada kebutuhan layout khusus.

## 7. Menambahkan Gambar

Simpan gambar pada folder `assets/` pada pertemuan terkait:

```text
meetings/pertemuan-02/assets/01-tampilan-awal.png
```

Gunakan nama file yang singkat dan deskriptif. Kemudian masukkan gambar di `report.typ`:

```typ
#report-figure(
  image("assets/01-tampilan-awal.png", width: 85%),
  caption: [Tampilan awal aplikasi],
)
```

Gunakan gambar yang benar-benar berasal dari hasil praktikum. Nama gambar dalam daftar gambar dan caption akan dibentuk otomatis.

Cara menambah gambar dengan label lokasi:

```typ
#report-figure(
  image("assets/02-hasil-form.png", width: 80%),
  placement: auto,
  caption: [Hasil pengujian form],
)
```

Nilai `width` dapat disesuaikan, tetapi disarankan memakai `70%` sampai `95%`.

## 8. Menambahkan Tabel

Contoh tabel sederhana:

```typ
#report-table(
  columns: 3,
  [Kolom 1], [Kolom 2], [Kolom 3],
  [Data A], [Data B], [Data C],
  [Data D], [Data E], [Data F],
)
```

Tambahkan caption tabel menggunakan komponen `figure` jika tabel perlu muncul pada daftar:

```typ
#figure(
  caption: [Ringkasan hasil pengujian],
)[
  #report-table(
    columns: 2,
    [Pengujian], [Hasil],
    [Login berhasil], [Lulus],
  )
]
```

Gunakan judul tabel singkat dan hindari tabel terlalu lebar agar tidak keluar dari margin halaman.

## 9. Menambahkan Kode Program

Gunakan helper `report-code` untuk menampilkan potongan kode:

```typ
#report-code(
  "<?php\necho \"Hello World\";\n?>",
  lang: "php",
)
```

Contoh untuk JavaScript:

```typ
#report-code(
  "console.log(\"Hello World\");",
  lang: "js",
)
```

Kode program sebaiknya hanya berisi potongan yang relevan dengan pembahasan, bukan satu file panjang tanpa konteks.

## 10. Menambahkan Daftar Pustaka IEEE

Setiap pertemuan memiliki file `references.bib` tersendiri.

Contoh sumber dokumentasi:

```bibtex
@online{laravel_docs,
  author = {{Laravel}},
  title = {Laravel Documentation},
  url = {https://laravel.com/docs},
  urldate = {2026-11-24},
}
```

Cite sumber dengan key yang sama pada isi laporan:

```typ
Menurut dokumentasi Laravel, ... @laravel_docs.
```

Pastikan:

- Setiap sumber yang dikutip terdaftar pada `references.bib`.
- Key BibTeX tidak mengandung spasi.
- URL dan tanggal akses valid.
- Tidak menambahkan sumber yang tidak benar-benar dikutip.
- Nama author, judul, penerbit, tahun, dan DOI diperiksa sebelum digunakan.

Daftar pustaka otomatis dirender oleh bagian berikut:

```typ
= Daftar Pustaka

#pad(left: 1.2cm)[
  #set par(hanging-indent: 0.75cm)
  #bibliography("references.bib", style: "ieee", title: none)
]
```

Gunakan format IEEE dan jangan mengubah indentasi daftar pustaka secara manual.

## 11. Mengubah Tampilan Seluruh Proyek

Buka `template/config.typ` untuk mengubah konfigurasi bersama:

- `paper`
- `margin`
- `font`
- `font-size`
- `language`
- `leading`
- `paragraph-spacing`
- `paragraph-indent`
- `figure-caption-size`
- `content-indent`
- `bibliography-hanging-indent`

Jangan menulis ulang pengaturan global pada setiap `report.typ`. Perubahan global sebaiknya dilakukan hanya pada template bersama agar semua pertemuan tetap konsisten.

Catatan Typst: nilai `leading` adalah jarak tambahan antarbaris, bukan otomatis setara dengan spasi 1,5 atau 2 pada pengolah kata. Periksa hasil PDF sebelum menyerahkan laporan.

## 12. Menjalankan Preview dan Kompilasi

### Preview melalui VS Code

1. Buka `meetings/pertemuan-01/report.typ`.
2. Jalankan preview Tinymist.
3. Periksa perubahan pada halaman cover, daftar isi dan daftar gambar jika diaktifkan, isi, serta daftar pustaka.

### Kompilasi satu laporan

```powershell
typst compile --root . meetings\pertemuan-01\report.typ output\pertemuan-01.pdf
```

Argumen `--root .` diperlukan agar Typst dapat mengakses `template/` dari folder laporan.

## 13. Pemeriksaan Sebelum Submit

Periksa hal berikut pada PDF akhir:

- Nama, NIM, kelas, dosen, mata kuliah, dan tahun sudah benar.
- Nomor cover tidak ditampilkan.
- Halaman pendahuluan memakai nomor Romawi kecil.
- Halaman isi memakai nomor Arab.
- Daftar isi dan daftar gambar tampil sesuai opsi pada `make-report`.
- Heading utama dan subheading bernomor otomatis.
- Tidak ada teks mentah, placeholder, atau petunjuk mengisi laporan.
- Gambar dapat dibaca dan tidak terpotong.
- Caption gambar ditulis dengan jelas.
- Tabel tidak melampaui margin.
- Potongan kode relevan dan tidak terpotong.
- Semua sitasi mempunyai entri pada `references.bib`.
- Daftar pustaka muncul dan formatnya mengikuti IEEE.
- Indentasi isi dan daftar pustaka konsisten.

## 14. Catatan Penyusunan Konten

Laporan yang sudah tersedia merupakan starter dan bukan laporan akademik yang selesai. Jangan mencantumkan hasil eksekusi, screenshot, observasi, atau bukti praktikum yang belum benar-benar diperoleh.

Untuk konten akademik:

- Gunakan bahasa Indonesia yang formal dan jelas.
- Ikuti modul serta instruksi dosen.
- Bedakan langkah yang dilakukan dengan hasil yang hanya diperkirakan.
- Gunakan satu sumber untuk satu klaim yang membutuhkan referensi.
- Jangan membuat author, judul, DOI, URL, atau tanggal referensi tanpa verifikasi.
