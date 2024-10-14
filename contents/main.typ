#import "../template.typ": *

#show: template.with(
  title: [ Numerical Linear Algebra ],
  date: datetime(year: 2024, month: 9, day: 16),
  authors: (
    (
      name: "Rao",
      github: "https://github.com/Raopend",
      homepage: "https://github.com/Raopend",
    ),
  ),
  affiliations: (
    (
      id: "1",
      name: "Politecnico di Milano",
    ),
  ),
  // cover-image: "./figures/polimi_logo.png",
  background-color: "#FAF9DE",
)
#set math.mat(delim: "[")
#set math.vec(delim: "[")
#set math.equation(supplement: [Eq.])
#include "chapter0.typ"
#include "chapter1.typ"
#include "chapter2.typ"
#include "chapter3.typ"