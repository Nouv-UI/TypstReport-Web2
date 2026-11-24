// Shared document configuration.
// Adjust this file to change the visual style across all meeting reports.

#let report-config = (
  paper: "a4",
  margin: (
    top: 3cm,
    bottom: 3cm,
    left: 2cm,
    right: 2cm,
  ),
  font: "Times New Roman",
  font-size: 12pt,
  language: "id",
  // Typst leading is additional inter-line spacing, not a direct
  // word-processor line-spacing multiplier. Verify against the required PDF.
  leading: 0.9em,
  paragraph-spacing: 1.1em,
  paragraph-indent: 1.2cm,
  figure-width: 85%,
  figure-caption-size: 11pt,
  content-indent: 1.2cm,
  bibliography-hanging-indent: 0.75cm,
)
