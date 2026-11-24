// Code block helper. Example:
// #report-code("echo 'Hello';", lang: "php")
#let report-code(source, lang: "text") = {
  block(
    width: 100%,
    fill: luma(245),
    stroke: 0.5pt + luma(210),
    radius: 3pt,
    inset: 8pt,
  )[
    #raw(source, lang: lang)
  ]
}
