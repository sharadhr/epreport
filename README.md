# A LaTeX Document Class for Typesetting Experimental Physics Reports

This LaTeX document class, `epreport.cls` is aimed at (under)graduate physics students who are taking experimental physics classes and need accurate, powerful typesetting of physics reports.

- [Intermediate Typesetting](#intermediate-typesetting)
- [Software](#software)
	- [Mathematical and Scientific Typesetting](#mathematical-and-scientific-typesetting)
		- [Multivariable and Vector Calculus](#multivariable-and-vector-calculus)
	- [Figures, Graphs, Images, and Tables](#figures-graphs-images-and-tables)
- [Implementation](#implementation)
	- [Packages Imported](#packages-imported)

## Intermediate Typesetting

A complete, from-scratch LaTeX tutorial is quite out of the scope of this document. Instead, there exist better materials for the absolute LaTeX novice:

* [Overleaf: Learn LaTeX in 30 Minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes)
* [`lshort`, or *The Not So Short
Introduction to LATEX 2ε*](https://download.nus.edu.sg/mirror/ctan/info/lshort/english/lshort.pdf)

A quick Google search should turn up far more documents, videos, and other resources. Instead, this guide is aimed at users who already have *some* experience typesetting with LaTeX, and who wish to improve the quality of their report output, or to reduce the workload needed in typesetting high-quality reports, by providing some starter documentation (what you are reading now), as well as a list of pre-imported packages.

## Software

Many occasional users of LaTeX choose Overleaf to typeset their documents.
Overleaf is admittedly handy for the novice user, but for any measure of speed improvement, a local TeX distribution and a powerful text editor is almost mandatory.
Even so, many users tend to use dedicated 'TeX IDEs' like TeXStudio or TeXMaker, rather than general-purpose text editors.

As a couple of steps up, I suggest using [Visual Studio Code](http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/physics/physics.pdf) (VS Code in short) with the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension.
Notwithstanding the neat integration with VS Code, it is also noticeably faster when compiling than TeXStudio, as well as already providing a built-in method (specifically, `latexmk`) for automatic re-compiling.
Furthermore, VS Code provides some extremely handy Vim-esque shortcuts that expand to environments, maths code, or other complex macros: this can add up to a very large amount of time saved when typesetting complex formulae.

A full list of the snippets is [here](https://github.com/James-Yu/LaTeX-Workshop/wiki/Snippets); some examples are provided below.

| Snippet typed                                                           | Tab-expansion                        | Remarks                                                                                                                   |
| ----------------------------------------------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| `@a`                                                                    | `\alpha`                             | Greek alphabet: use the first letter.                                                                                     |
| `@D`                                                                    | `\Delta`                             | Capital Greek alphabet: capitalise.                                                                                       |
| `@vs`                                                                   | `\varsigma`                          | V for var.                                                                                                                |
| `@/`, `@%`                                                              | `\frac{}{}`                          | Two placeholders that can be navigated forward with <kbd>Tab</kbd>,  and backward with <kbd>Shift</kbd> + <kbd>Tab</kbd>. |
| `@I`                                                                    | `\int_{}^{}`                         | Integral. Again with navigable placeholders, as above.                                                                    |
| `@8`                                                                    | `\infty`                             | Infinity symbol: looks like an '8' on its side.                                                                           |
| `@F`                                                                    | `\Phi`                               | Phi is pronounced 'Fye', hence F.                                                                                         |
| `BEQ`                                                                   | `\begin{equation}  \end{equation}`   | **B**egin **Eq**uation.                                                                                                   |
| `BEN`                                                                   | `\begin{enumerate}  \end{enumerate}` | Same as above.                                                                                                            |
| `SSE`                                                                   | `\section{}`                         | Start Section                                                                                                             |
| `FBF`                                                                   | `\textbf{}`                          | Font BF. Cursor is set to be within the braces.                                                                           |
| <kbd>Ctrl</kbd> + <kbd>L</kbd>, then <kbd>Ctrl</kbd> + <kbd>Enter</kbd> | Newline, and then `\item`.           | Useful for lists and enumerated lists.                                                                                    |

Users who are further still familiar with the command line may choose `vim` or `emacs` with the VimTeX, or AUCTeX extensions respectively.

### Mathematical and Scientific Typesetting

#### Multivariable and Vector Calculus

`epreport.cls` imports the powerful [`physics`](http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/physics/physics.pdf) package, which provides *dozens* of convenient macros for physics typesetting, from (partial, complete) differentials, bold-roman vectors and matrices, Dirac bra-ket notation, and matrix shortcuts, as well as macros to avoid excessive `\left` and `\right` strings in your source code. There is little point in merely repeating the documentation (hyperlinked above) here, as it is relatively short and concise. That said, a quick example will serve to demonstrate the sheer simplicity and readability of the source code for a (fairly) complicated expression:

```LaTeX
\oint_\mathcal{C} \vb{B}(\vb{r}, t)\cdot \dd{\vb*{\ell}} &= \mu_0\iint_\mathcal{S} \vb{J}(\vb{r}, t) \cdot \dd{\vb{a}} + \mu_0\varepsilon_0 \dv{t} \iint_\mathcal{S}\vb{E}(\vb{r}, t)\cdot \dd{\vb{a}}
```

### Figures, Graphs, Images, and Tables


## Implementation

`epreport.cls` was built on the already-existing `article.cls`, as nearly all other LaTeX documents are. A large list of packages are used to improve the quality of life while typesetting. A complete list is reproduced below, along with links to the packages' documentation.

### Packages Imported
