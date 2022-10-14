(TeX-add-style-hook
 "RJournal"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("helvet" "scaled=0.92") ("inconsolata" "scaled=1.02") ("fontenc" "T1") ("url" "hyphens") ("hyperref" "pagebackref") ("titlesec" "medium") ("natbib" "sectionbib" "round") ("caption" "font=small" "labelfont=bf")))
   (add-to-list 'LaTeX-verbatim-environments-local "alltt")
   (add-to-list 'LaTeX-verbatim-environments-local "VerbatimOut")
   (add-to-list 'LaTeX-verbatim-environments-local "SaveVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "LVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "BVerbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim*")
   (add-to-list 'LaTeX-verbatim-environments-local "Verbatim")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb*")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "Verb")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "tikz"
    "geometry"
    "fancyhdr"
    "microtype"
    "helvet"
    "palatino"
    "mathpazo"
    "inconsolata"
    "fontenc"
    "url"
    "hyperref"
    "color"
    "setspace"
    "titlesec"
    "titletoc"
    "placeins"
    "natbib"
    "fancyvrb"
    "alltt"
    "amsfonts"
    "caption"
    "environ")
   (TeX-add-symbols
    '("operatorname" 1)
    '("BIOpkg" 1)
    '("ctv" 1)
    '("CRANpkg" 1)
    '("strong" 1)
    '("acronym" 1)
    '("dfn" 1)
    '("file" 1)
    '("var" 1)
    '("key" 1)
    '("kbd" 1)
    '("email" 1)
    '("address" 1)
    '("review" 1)
    '("volnumber" 1)
    '("volume" 1)
    "nohyphens"
    "RJ"
    "R"
    "code"
    "samp"
    "E"
    "VAR"
    "COV"
    "COR"
    "env"
    "command"
    "option"
    "pkg"
    "cpkg")
   (LaTeX-add-environments
    '("widetable" LaTeX-env-args ["argument"] 0)
    '("widefigure" LaTeX-env-args ["argument"] 0)
    "article"
    "Schunk")
   (LaTeX-add-color-definecolors
    "link")
   (LaTeX-add-fancyvrb-environments
    '("example" "Verbatim")
    '("Sinput" "Verbatim")
    '("Soutput" "Verbatim")
    '("Scode" "Verbatim")
    '("Sin" "Verbatim")
    '("Sout" "Verbatim")))
 :latex)

