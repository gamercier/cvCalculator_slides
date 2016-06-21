---
title: "Cardiovascular Risk Calculator"
subtitle: "10-year risk of heart attack or stroke"
author: "Gustavo Mercier"
date: "2016-06-21"
job: Developing Data Products - Coursera course
mode: selfcontained        # {standalone, draft}
highlighter: highlight.js  # {prettify, highlight}
hitheme: tomorrow          #
framework: io2012          # {html5slides, shower, dzslides, ...}
widgets: [mathjax]         # {quiz, bootstrap}
output:
   ioslides_presentation:
     fig_height: 6
     fig_width: 7
     keep_md: yes
---



## Motivation

* Cardiovascular disease remains the single largest killer in the developed world
* Tools to compute the risk of cardiovascular events help:
    + Physicians risk stratify and manage patients.
    + Educate patients about their risk and what they can do about it.
* A web based calculator of such risk is a most useful tool.
    + This is calculator prototyped using shiny is my project.

---

## Source

* The equation for the calculator is described in the [2013 Guideline on the Assesment of Cardiovascular Risk](http://bit.ly/1Os6cgR) by the American College of Cardiology and the American Heart Association.
* The guidelines also provide extensive details on its justification and how to apply the tool.
* It meets the needs of working healthcare professionals and patients who wish to understand their risk of cardiovascular disease.

---

## Example Input and Output

![](./figures/cvcalc_screen_smaller.png)

(Input panel to large to embed for interactive slide, but output is computed!)

```
## [1] "10-year cardiovascular risk: 2.4% (embedded R code output)"
```

---

## Shiny Implementation

* Shiny allows for a fast implementation of the calculator using R as an engine.
* The speed allows for creation of multiple prototypes.
* The widgets allow for clean input of the necessary parameters such as age and sex.
    + The user interface follows common browser standards so instructions are nearly unnecessary.
* The shiny app protototype is hosted in [cvCalculator](https://gamercier.shinyapps.io/cvCalculator/)
* An example of the end-product from the AHA/ACC, using javascript, is available at [cvriskcalculator](http://www.cvriskcalculator.com/)

Slidy source hosted in [github cvCalculator_slides](https://github.com/gamercier/cvCalculator_slides/tree/gh-pages)

Shiny app source hosted in [github cvCalculator](https://github.com/gamercier/cvCalculator)
