#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/numty:0.1.0" as nt
#import "@preview/nova-pset:0.1.0": *

#let class = "Processos Estocásticos II"
#let assignment = "Trabalho Clustering"
#let author = "Mateus Ribeiro"
// To use a logo, add an image to this folder and replace none:
// #let logo = image("ufc.png", height: 30pt)
 #let logo = none
#let instructor = "Prof. Charles Casimiro"
//#let semester = "Fall 2025"
#let due-time = "Jun 14 2026"

#show: homework.with(
  class: class,
  assignment: assignment,
  author: author,
  logo: logo,
  instructor: instructor,
 // semester: semester,
  due-time: due-time,
  paper-size: "us-letter",
  accent-color: rgb("#1c2b39"),
)

- Obs: A resolução está dividida entre esse documento onde
  se encontram as questões teóricas e os resultados
  das computacionais e um jupyternotebook com os códigos
  necessários, além disso os códigos também estão listados no final do pdf.

#set enum(numbering: "i.")

#q(title: "Questão 1")[
]
