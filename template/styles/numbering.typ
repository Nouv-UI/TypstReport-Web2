// Hierarchical heading numbering:
// Level 1: Roman numerals (I, II, III)
// Level 2: Uppercase letters (A, B, C)
// Level 3: Arabic numerals (1, 2, 3)
// Level 4: Lowercase letters (a, b, c)

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

#let apply-heading-style() = {
  set heading(numbering: heading-numbering)
  show heading.where(level: 1): set text(size: 12pt, weight: "bold")
  show heading.where(level: 2): set text(size: 12pt, weight: "regular")
  show heading.where(level: 3): set text(size: 12pt, weight: "regular")
  show heading.where(level: 4): set text(size: 12pt, weight: "regular")
}
