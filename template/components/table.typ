// Small wrapper for consistent table defaults.
// Pass normal Typst table arguments as named arguments.
#let report-table(..args) = table(
  width: 100%,
  inset: 6pt,
  align: left,
  stroke: 0.5pt,
  ..args,
)
