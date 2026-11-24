// Cover content. The caller controls page numbering and page breaks.

#let cover(meta) = {
  set align(center)
  set par(leading: 0.8em, spacing: 0.8em)

  text(size: 14pt)[
    #upper(meta.report-title) \
    #upper(meta.course) \
    #upper(meta.meeting) \
    #upper(meta.topic)
  ]

  v(1fr)

  if meta.logo != none {
    meta.logo
  } else {
    box(
      width: 5.5cm,
      height: 5.5cm,
      stroke: 0.5pt + gray,
      radius: 4pt,
      align(center + horizon)[
        text(size: 10pt, fill: gray)[Logo institusi]
      ],
    )
  }

  v(1fr)

  text(size: 13pt)[
    Disusun oleh: \
    #v(0.3em)
    #grid(
      columns: (auto, auto, auto),
      column-gutter: 0.5em,
      row-gutter: 0.45em,
      align: left,
      [Nama], [:], [#meta.student],
      [NIM], [:], [#meta.student-id],
      [Kelas], [:], [#meta.class],
      [Dosen Pengampu], [:], [#meta.lecturer],
    )
  ]

  v(1fr)

  text(size: 14pt)[
    #upper(meta.program) \
    #upper(meta.department) \
    #upper(meta.faculty) \
    #upper(meta.university) \
    #upper(meta.city) \
    #meta.year
  ]
}
