#import "../../template/main.typ": make-report, report-figure, report-table, report-code, isi
#import "metadata.typ": metadata

#show: doc => make-report(metadata, doc)

= Tujuan Praktikum

#isi(level: 1)[
  Tuliskan tujuan praktikum berdasarkan modul dan instruksi dosen. Sesuaikan dengan aktivitas yang benar-benar dikerjakan.
]

= Dasar Teori

== Konsep Materi Pertama

#isi(level: 2)[
  Tuliskan penjelasan teori dengan bahasa akademik yang jelas. Setiap klaim yang membutuhkan sumber harus didukung sitasi, misalnya @example_reference.
]

== Konsep Materi Kedua

#isi(level: 2)[
  Tambahkan konsep pendukung yang relevan dengan kegiatan praktikum.
]

= Hasil dan Pembahasan

== Persiapan Praktikum

#isi(level: 2)[
  Jelaskan perangkat, aplikasi, konfigurasi, atau kebutuhan awal yang benar-benar digunakan.
]

== Langkah Percobaan Pertama

#isi(level: 2)[
  Jelaskan langkah secara berurutan. Tambahkan bukti berupa gambar jika tersedia.

  #report-figure(
    rect(width: 85%, height: 4.5cm, stroke: 0.5pt + gray)[
      #align(center + horizon)[
        #text(size: 10pt, fill: gray)[Ganti placeholder dengan screenshot]
      ]
    ],
    caption: [Placeholder tangkapan layar langkah pertama],
  )
]

== Latihan Praktikum

#isi(level: 2)[
  Jelaskan soal latihan, pendekatan penyelesaian, implementasi, dan hasil yang benar-benar diperoleh.
]

= Kesimpulan

#isi(level: 1)[
  Tuliskan kesimpulan berdasarkan tujuan dan hasil praktikum yang telah dibahas. Hindari menyatakan semua tujuan tercapai jika belum diverifikasi.
]

= Daftar Pustaka

#pad(left: 1.2cm)[
  #set par(hanging-indent: 0.75cm)
  #bibliography("references.bib", style: "ieee", title: none)
]
