#import "../../template/main.typ": make-report, report-figure, report-table, report-code, isi
#import "metadata.typ": metadata

#show: doc => make-report(metadata, doc)

= Tujuan Praktikum

#isi(level: 1)[
  Tuliskan tujuan praktikum berdasarkan modul dan instruksi dosen.
]

= Dasar Teori

== Konsep Materi Pertama

#isi(level: 2)[
  Tuliskan penjelasan teori dengan bahasa akademik yang jelas.
]

= Hasil dan Pembahasan

== Persiapan Praktikum

#isi(level: 2)[
  Jelaskan perangkat, aplikasi, konfigurasi, atau kebutuhan awal yang benar-benar digunakan.
]

= Kesimpulan

#isi(level: 1)[
  Tuliskan kesimpulan berdasarkan tujuan dan hasil praktikum yang telah diverifikasi.
]

= Daftar Pustaka

#pad(left: 1.2cm)[
  #set par(hanging-indent: 0.75cm)
  #bibliography("references.bib", style: "ieee", title: none)
]
