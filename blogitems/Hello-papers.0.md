Title: Unsorted papers
Authors: kakadu <kakadu@protonmail.ch>
Date: 2018-02-24T21:03:00-00:00
ID: c0615a9d-3844-4b56-91cc-4b1968ddd7ab
Topics: papers, unsorted
Categories: listed, published

This note stub will be filled by a list papers that I might find 
interesting but didn't read yet.

---

[CORRECTNESS OF UNIFICATION WITHOUT OCCUR CHECK IN PROLOG](https://www.sciencedirect.com/science/article/pii/0743106694900485) (Journal of Logic Programming, 1994)

Occurs check make unification to work much slowly but without it unification may 
lead to wrong answers. Folks invent a way to preprocess Prolog programs to detect
which terms can be recursive and use occurs-check unification only for this terms.

---

Some prolog [implementations](https://sicstus.sics.se/sicstus/docs/3.12.8/html/sicstus/Occur.html) seems be able to deal with terms with cycles without cyclicing the programm. Some dirty hack probably....

---

## Verification

### Inventing a new language

OCaml with some annotations and Why3 solver under the hood (J.-C. Filliatre et all): [A Toolchain to Produce Correct-by-Construction OCaml Programs](https://hal.inria.fr/hal-01783851/file/main.pdf) 


## Really unsorted

[Code](https://github.com/dboulytchev/coq-supplementary) for Coq course from SPbAU.

Why Elm is [wrong](http://reasonablypolymorphic.com/blog/elm-is-wrong/).

Oleg's [resumable exceptions](http://okmij.org/ftp/ML/#resumable-exn).
Oleg is doing [RTTI using first-class modules](http://okmij.org/ftp/ML/first-class-modules/generics.ml).

Octachron is doing peano arithmetic using types and polymorphic variants in OCaml https://github.com/Octachron/rational_in_types .

[Category Theory for Computing Science](http://www.math.mcgill.ca/triples/Barr-Wells-ctcs.pdf) by Michael Barr & Charles Wells

[Martosz Milewski lectures](https://www.youtube.com/watch?v=I8LbkfSSR58&list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM_) on Category Theory

[Reasonably Programmable Syntax](https://www.cs.cmu.edu/~comar/omar-thesis.pdf) ph.D. thesis from Cyrus Omar

[Set-Theoretic Types for Polymorphic Variants](https://arxiv.org/pdf/1606.01106v1.pdf)

[Kan Extensions for Program Optimisation Or: Art and Dan Explain an Old Trick](https://www.cs.ox.ac.uk/ralf.hinze/Kan.pdf)

[Type-Preserving CPS Translation of Σ and Π Types is Not Not Possible](https://williamjbowman.com/resources/cps-sigma.pdf) from POPL 2018

[A Principled approach to Ornamentation in ML](http://pauillac.inria.fr/~remy/ornaments/mlorn-2017-09.pdf)

[A Categorical View of Computational Effects](https://www.youtube.com/watch?v=6t6bsWVOIzs)

[Explicit Effect Subtyping](https://people.cs.kuleuven.be/%7Etom.schrijvers/Research/papers/esop2018.pdf)


Fokkinga's PhD [Law and Order in Algorithmics](https://pdfs.semanticscholar.org/7ca8/326eb63f32502c0fc2324b6217a7bc7e8af4.pdf)

Ralph Hinze[Kan Extensions for Program Optimisation Or: Art and Dan Explain an Old Trick](https://www.cs.ox.ac.uk/ralf.hinze/Kan.pdf)

