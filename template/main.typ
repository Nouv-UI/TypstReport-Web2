// Shared, self-contained template for all practical meeting reports.
#import "config.typ": report-config

#let heading-numbering(..nums) = {
  let values = nums.pos()
  if values.len() == 1 {
    numbering("I.", values.at(0))
  } else if values.len() == 2 {
    numbering("A.", values.at(1))
  } else if values.len() == 3 {
    numbering("1.", values.at(2))
  } else {
    numbering("a.", values.at(3))
  }
}

#let report-figure(body, caption: none, placement: auto) = figure(
  body,
  placement: placement,
  caption: caption,
)

#let report-table(..args) = table(
  width: 100%,
  inset: 6pt,
  align: left,
  stroke: 0.5pt,
  ..args,
)

#let report-code(source, lang: "text") = block(
  width: 100%,
  fill: luma(245),
  stroke: 0.5pt + luma(210),
  radius: 3pt,
  inset: 8pt,
)[
  #raw(source, lang: lang)
]

#let isi(level: 2, body) = {
  let indent-map = (
    "1": 1.2cm,
    "2": 2cm,
    "3": 2.7cm,
  )
  pad(left: indent-map.at(str(level), default: 2cm), right: 0pt)[
    #set par(first-line-indent: report-config.paragraph-indent)
    #body
  ]
}

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

#let make-report(meta, body, show-toc: true, show-figures: true) = {
  set page(
    paper: report-config.paper,
    margin: report-config.margin,
  )
  set text(
    font: report-config.font,
    size: report-config.font-size,
    lang: report-config.language,
  )
  set par(
    justify: true,
    leading: report-config.leading,
    spacing: report-config.paragraph-spacing,
    first-line-indent: 0pt,
  )

  set page(numbering: none)
  cover(meta)

  pagebreak()
  set page(numbering: "i")
  counter(page).update(1)

  if show-toc {
    outline(
      title: align(center)[
        #text(size: 12pt, weight: "bold")[DAFTAR ISI]
      ],
      indent: 1.5em,
    )
  }

  if show-toc and show-figures {
    pagebreak()
  }

  if show-figures {
    outline(
      title: align(center)[
        #text(size: 12pt, weight: "bold")[DAFTAR GAMBAR]
      ],
      target: figure,
    )
    pagebreak()
  } else if show-toc {
    pagebreak()
  }

  set page(numbering: "1")
  counter(page).update(1)

  set figure(supplement: [Gambar])
  show figure.caption: it => {
    set text(size: report-config.figure-caption-size)
    [#it.supplement #context it.counter.display(it.numbering). #it.body]
  }

  set heading(numbering: heading-numbering)

  show heading.where(level: 1): it => {
    v(0.8em)
    block(width: 100%)[
      #set text(size: 12pt, weight: "bold")
      #grid(
        columns: (1.2cm, 1fr),
        [#numbering("I.", ..counter(heading).at(it.location()))],
        [#upper(it.body)],
      )
    ]
    v(0.3em)
  }

  show heading.where(level: 2): it => {
    v(0.4em)
    block(width: 100%)[
      #pad(left: 1.2cm)[
        #set text(size: 12pt, weight: "regular")
        #grid(
          columns: (0.8cm, 1fr),
          [#numbering("A.", counter(heading).at(it.location()).at(1))],
          [#it.body],
        )
      ]
    ]
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    v(0.2em)
    block(width: 100%)[
      #pad(left: 2cm)[
        #set text(size: 12pt, weight: "regular")
        #grid(
          columns: (0.7cm, 1fr),
          [#numbering("1.", counter(heading).at(it.location()).at(2))],
          [#it.body],
        )
      ]
    ]
  }

  show heading.where(level: 4): it => {
    block(width: 100%)[
      #pad(left: 2.7cm)[
        #set text(size: 12pt, weight: "regular")
        #grid(
          columns: (0.7cm, 1fr),
          [#numbering("a.", counter(heading).at(it.location()).at(3))],
          [#it.body],
        )
      ]
    ]
  }

  align(center)[
    #text(size: 12pt, weight: "bold")[
      #upper(meta.meeting) \
      #upper(meta.topic)
    ]
  ]
  v(0.5em)

  body
}
