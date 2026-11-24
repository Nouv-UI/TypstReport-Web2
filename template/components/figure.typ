// Consistent image figure helper.
// Example: #report-figure(image("assets/screenshot.png", width: 85%), caption: [Description])

#let report-figure(body, caption: none, placement: auto) = {
  figure(
    body,
    placement: placement,
    caption: caption,
  )
}
