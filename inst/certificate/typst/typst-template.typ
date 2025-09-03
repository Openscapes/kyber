
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let article(
  title: none,
  subtitle: none,
  author: none,
  dates: none,
  abstract: none,
  abstract-title: none,
  lesson-doi: none,
  cohort-website: none,
  cols: 1,
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 2em,
  subtitle-size: 1.5em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set page(
    paper: paper,
    margin: (
      top: 0.5in,
      bottom: 2.5in,
      left: 0.5in,
      right: 2.25in
    ),
    flipped: true,
    background: image("typst/communities-bg.png", width: 100%, height: 100%)
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  if title != none {
    align(center)[#block(inset: (top: 1em, bottom: 2em, left: 2em, right: 2em))[
      #set par(leading: heading-line-height)
      #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
           or heading-color != black or heading-decoration == "underline"
           or heading-background-color != none) {
        set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
        text(size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(size: subtitle-size)[#subtitle]
        }
      } else {
        text(weight: "bold", size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(weight: "bold", size: subtitle-size)[#subtitle]
        }
      }
    ]]
  }

  if dates != none {
    align(center)[#block(inset: (top: 0em, bottom: 0.5em, left: 1em, right: 1em))[
      #dates
    ]]
  }

  if author != none {
    align(center)[#block(inset: (top: 0em, bottom: 1em, left: 1em, right: 1em))[
      #text(weight: "semibold", size: 1.25em)[#author]
    ]]
  }


  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    )
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

  // if lesson-doi != none {
  //   align(center)[#block(inset: (top: 0em, bottom: 1em, left: 1em, right: 1em))[
  //       #text(size: 1.25em)[#lesson-doi]
  //     ]]
  // }

}


#set table(
  inset: 6pt,
  stroke: none
)
