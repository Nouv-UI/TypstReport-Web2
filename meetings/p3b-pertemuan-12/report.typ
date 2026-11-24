#import "../../template/main.typ": make-report, report-figure, report-table, report-code, isi
#import "metadata.typ": metadata

#show: doc => make-report(
  metadata,
  doc,
  show-toc: false,
  show-figures: false,
)

= Link Repository
#isi(level: 1)[
  https://github.com/Nouv-UI/PPPBD_12_NotesApp
]

= Output
== Tambah Catatan (Create)
#isi(level: 2)[
  Untuk menambahkan Catatan, user perlu  memasukkan judul catatan pada OutlinedTextField, lalu mengklik tombol Tambah.


  #report-figure(
    image("assets/add.jpeg", height: 12cm),
    placement: none,
    caption: [Tampilan Input & Penambahan Data],
  )
  
]


== List Catatan (Read)
#isi(level: 2)[
   Catatan baru akan muncul di bagian teratas daftar. List Menampilkan title, ID, dan note nya. 

  #report-figure(
    image("assets/edit 1.jpeg", height: 12cm),
    placement: none,
    caption: [Tampilan List Catatan],
  )
]
== Edit Catatan (Edit)
#isi(level: 2)[
  Untuk mengubah catatan, klik icon pensil. Untuk mengonfirmasi perubahan, klik tombol centang. Sedangkan untuk membatalkan, klik silang.

  #report-figure(
    image("assets/edit.jpeg", height: 10cm),
    placement: none,
    caption: [Tampilan Mode Edit],
  )
]
== Hapus Catatan (Delete)
#isi(level: 2)[
  Untuk menghapus catatan, klik icon sampah (delete). 

  #report-figure(
    image("assets/awal.jpeg", height: 10cm),
    placement: none,
    caption: [Untuk Menghapus Catatan, Klik tombol Hapus],
  )
]

= Ringkasan Materi

== SQLite

#isi(level: 2)[
  SQLite adalah sistem basis data relasional (RDBMS) yang menyimpan data dalam file lokal dan digunakan Android sebagai penyimpanan data. Disini, basis datanya bernama `notes.db`. Data tetap tersedia setelah aplikasi ditutup, kecuali jika aplikasi di-uninstal @android_sqlite.
]

== Room Database Abstraction Layer

#isi(level: 2)[
  Room merupakan lapisan abstraksi Android di atas SQLite. Room menyediakan anotasi untuk mendefinisikan entity, DAO, dan database sehingga operasi basis data dapat ditulis dengan API Kotlin @room_android.
]

== Entity (`Note.kt`)

#isi(level: 2)[
  Entity memetakan objek Kotlin ke tabel basis data. Pada contoh dibawah, `Note` merepresentasikan satu baris pada tabel `notes`. Kolom `id` menjadi primary key (nilainya auto-generate), sedangkan `title` menyimpan judul catatan @room_android.

  #report-code(
  (
    "package com.example.notesapp",
    "",
    "import androidx.room.Entity",
    "import androidx.room.PrimaryKey",
    "",
    "@Entity(tableName = \"notes\")",
    "data class Note(",
    "    @PrimaryKey(autoGenerate = true)",
    "    val id: Long = 0L,",
    "    val title: String,",
    ")",
  ).join("\n"),
  lang: "kotlin",
)
]

== Data Access Object / DAO (`NoteDao.kt`)

#isi(level: 2)[
  DAO adalah operasi untuk membaca dan mengubah data. `getAll()` mengembalikan `Flow` yang diurutkan berdasarkan ID sehingga catatan dengan ID terbesar ditampilkan lebih dahulu (Descending). Operasi insert, update, dan delete dideklarasikan sebagai fungsi `suspend` @room_android.

  #report-code(
    (
      "package com.example.notesapp",
      "",
      "import androidx.room.Dao",
      "import androidx.room.Delete",
      "import androidx.room.Insert",
      "import androidx.room.Query",
      "import androidx.room.Update",
      "import kotlinx.coroutines.flow.Flow",
      "",
      "@Dao",
      "interface NoteDao {",
      "    @Query(\"SELECT * FROM notes ORDER BY id DESC\")",
      "    fun getAll(): Flow<List<Note>>",
      "",
      "    @Insert",
      "    suspend fun insert(note: Note)",
      "",
      "    @Update",
      "    suspend fun update(note: Note)",
      "",
      "    @Delete",
      "    suspend fun delete(note: Note)",
      "}",
    ).join("\n"),
    lang: "kotlin",
  )
]



// === Database Class (`AppDatabase.kt`)

// #isi(level: 3)[
//   `AppDatabase` menjadi titik akses utama ke basis data Room dan menyediakan `NoteDao`. Pola singleton mencegah pembuatan instance basis data berulang. `@Volatile` dan `synchronized` membantu menjaga konsistensi pembuatan instance, sedangkan `applicationContext` menghindari penyimpanan context Activity yang berumur pendek @room_android.
// ]

// #report-code(
//   (
//     "package com.example.notesapp",
//     "",
//     "import android.content.Context",
//     "import androidx.room.Database",
//     "import androidx.room.Room",
//     "import androidx.room.RoomDatabase",
//     "",
//     "@Database(entities = [Note::class], version = 1, exportSchema = false)",
//     "abstract class AppDatabase : RoomDatabase() {",
//     "    abstract fun noteDao(): NoteDao",
//     "",
//     "    companion object {",
//     "        @Volatile",
//     "        private var INSTANCE: AppDatabase? = null",
//     "",
//     "        fun getInstance(context: Context): AppDatabase =",
//     "            INSTANCE ?: synchronized(this) {",
//     "                INSTANCE ?: Room.databaseBuilder(",
//     "                    context.applicationContext,",
//     "                    AppDatabase::class.java,",
//     "                    \"notes.db\",",
//     "                ).build().also { INSTANCE = it }",
//     "            }",
//     "    }",
//     "}",
//   ).join("\n"),
//   lang: "kotlin",
// )

// === ViewModel (`NotesViewModel.kt`)

// #isi(level: 3)[
//   `NotesViewModel` menyediakan state catatan dan fungsi untuk melakukan operasi CRUD. ViewModel dapat mempertahankan state selama perubahan konfigurasi, seperti rotasi layar, tetapi tidak dengan sendirinya menjamin pemulihan state setelah proses aplikasi dihentikan. Composable dapat menerima state dan callback dari ViewModel agar pengelolaan state antarmuka tetap terpusat (state hoisting) @viewmodel_android.
// ]

// #report-code(
//   (
//     "package com.example.notesapp",
//     "",
//     "import android.app.Application",
//     "import androidx.lifecycle.AndroidViewModel",
//     "import androidx.lifecycle.viewModelScope",
//     "import kotlinx.coroutines.flow.SharingStarted",
//     "import kotlinx.coroutines.flow.StateFlow",
//     "import kotlinx.coroutines.flow.stateIn",
//     "import kotlinx.coroutines.launch",
//     "",
//     "class NotesViewModel(application: Application) :",
//     "    AndroidViewModel(application) {",
//     "    private val dao = AppDatabase.getInstance(application).noteDao()",
//     "",
//     "    val notes: StateFlow<List<Note>> = dao.getAll().stateIn(",
//     "        scope = viewModelScope,",
//     "        started = SharingStarted.WhileSubscribed(5_000),",
//     "        initialValue = emptyList(),",
//     "    )",
//     "",
//     "    fun addNote(title: String) {",
//     "        val text = title.trim()",
//     "        if (text.isNotEmpty()) {",
//     "            viewModelScope.launch {",
//     "                dao.insert(Note(title = text))",
//     "            }",
//     "        }",
//     "    }",
//     "",
//     "    fun updateNote(note: Note, newTitle: String) {",
//     "        val text = newTitle.trim()",
//     "        if (text.isNotEmpty()) {",
//     "            viewModelScope.launch {",
//     "                dao.update(note.copy(title = text))",
//     "            }",
//     "        }",
//     "    }",
//     "",
//     "    fun deleteNote(note: Note) {",
//     "        viewModelScope.launch {",
//     "            dao.delete(note)",
//     "        }",
//     "    }",
//     "}",
//   ).join("\n"),
//   lang: "kotlin",
// )

// === Kotlin Coroutines dan `viewModelScope`

// #isi(level: 3)[
//   Operasi basis data tidak seharusnya memblokir Main Thread karena dapat membuat antarmuka tidak responsif. Fungsi DAO yang bersifat `suspend` dapat dipanggil dari coroutine; Room menjalankan operasi basis data melalui executor-nya. `viewModelScope.launch` mengikat coroutine pada siklus hidup ViewModel, sehingga coroutine dibatalkan ketika ViewModel dihancurkan @android_coroutines.
// ]

// === Flow, StateFlow, dan `collectAsState`

// #isi(level: 3)[
//   `Flow<List<Note>>` dari Room memancarkan ulang daftar ketika data pada tabel yang diamati berubah. ViewModel mengubah Flow tersebut menjadi `StateFlow` menggunakan `stateIn` dan kebijakan `SharingStarted.WhileSubscribed(5_000)`. Di Jetpack Compose, `collectAsState()` mengubah nilai yang diamati menjadi state Compose; perubahan nilai dapat memicu recomposition pada bagian UI yang menggunakannya @kotlin_flows.
// ]

== `LazyColumn` dan Komponen UI Compose

#isi(level: 2)[
  `LazyColumn` menampilkan daftar vertikal dan hanya menyusun item yang diperlukan untuk area tampilan. Komponen ini dapat digunakan untuk menampilkan daftar catatan tanpa adapter dan ViewHolder. Parameter `key` memberi identitas stabil pada item, sedangkan `ListItem` dari Material 3 menampilkan judul dan ID catatan @compose_lists.

  #report-code(
    (
      "LazyColumn {",
      "    items(notes, key = { it.id }) { note ->",
      "        ListItem(",
      "            headlineContent = { Text(note.title) },",
      "            supportingContent = { Text(\"ID: ${note.id}\") },",
      "        )",
      "    }",
      "}",
    ).join("\n"),
    lang: "kotlin",
  )
]



= Daftar Pustaka

#pad(left: 1.2cm)[
  #set par(hanging-indent: 0.75cm)
  #bibliography("references.bib", style: "ieee", title: none)
]
