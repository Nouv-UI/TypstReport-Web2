# Practical Report Project — Agent Instructions

## Project purpose
This workspace contains university practical reports authored in Typst.
Each meeting is an independent report that reuses the shared template.

## Before making changes
1. Inspect the relevant report, template components, and project instructions.
2. Identify the exact files that need to change.
3. Preserve the established visual style unless the user explicitly requests a redesign.
4. Do not overwrite existing meeting work or final PDFs without permission.

## Academic writing
- Write report content in formal, clear academic Indonesian.
- Follow the lecturer's module and instructions as the primary source of practical scope.
- Use concise explanations and avoid repetition.
- Do not invent procedures, code execution results, screenshots, observations, dates, or experimental outcomes.
- Clearly distinguish expected results from results actually verified by the student.
- Keep the standard sections unless the lecturer specifies a different structure:
  1. Tujuan Praktikum
  2. Dasar Teori
  3. Hasil dan Pembahasan
  4. Kesimpulan
  5. Daftar Pustaka

## Sources and citations
- Use IEEE citation style through Typst bibliography support.
- Store references in the current meeting's `references.bib`.
- Never fabricate authors, titles, publication dates, URLs, DOIs, or access dates.
- Prefer primary documentation, official manuals, standards, and credible technical publications.
- Verify that each citation key exists in the bibliography.
- Do not add a source to the bibliography unless it is cited, unless the user requests a separate reading list.
- If web access is unavailable, identify references that still need verification rather than pretending they were verified.

## Typst conventions
- Reuse files and functions under `template/`; do not duplicate global styles in meeting reports.
- Keep meeting-specific metadata in that meeting's `report.typ` or a meeting-local metadata file.
- Keep bibliography data in `references.bib`.
- Store screenshots and other report assets in the meeting's `assets/` directory.
- Use relative asset paths from the report source.
- Use descriptive, stable filenames such as `01-konfigurasi-proyek.png`.
- Preserve the established A4, Times New Roman, 12pt visual direction unless instructed otherwise.
- Prefer small, focused changes to shared template components.
- Do not add packages or external dependencies without explaining why.

## Validation
- After changing Typst source, compile the affected report when the Typst CLI is available.
- Fix syntax and path errors introduced by the changes.
- Inspect page breaks, numbering, figures, tables, and bibliography output.
- If compilation cannot be run, state that clearly and provide the command the user can run.
- Do not claim a PDF was successfully compiled unless compilation was actually performed.

## Output and safety
- Do not modify unrelated meeting folders.
- Do not delete source materials or assets.
- Keep generated PDFs in `output/` or the configured build location.
- Summarize changed files, validation performed, and remaining issues.
