#let apply-typography(config) = {
  set text(
    font: config.font,
    size: config.font-size,
    lang: config.language,
  )
  set par(
    justify: true,
    leading: config.leading,
    spacing: config.paragraph-spacing,
    first-line-indent: config.paragraph-indent,
  )
}
