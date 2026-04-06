#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/numty:0.1.0" as nt
#import "@preview/nova-pset:0.1.0": *

#let class = "Processos Estocásticos II"
#let assignment = "Trabalho Cadeias de Markov"
#let author = "Mateus Ribeiro"
// To use a logo, add an image to this folder and replace none:
// #let logo = image("your-logo.png", height: 25pt)
#let logo = none
#let instructor = "Prof. Charles"
//#let semester = "Fall 2025"
#let due-time = "Apr 15 2026"

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
  necessários.

#set enum(numbering: "i.")

#q(title: "Questão 1")[
  Mostre a representação gráfica dos estados da cadeia de Markov e suas transições possíveis 
]

Dada a matriz de probabilidade de transição de um passo do sistema, temos que
sua representação gráfica é dada por:
#align(center)[
  #v(30pt)
  #diagram(
    // Nodes
    let (E, R, L, A) = ((0, 1), (0, 3), (3.5, 1), (3.5, 3)),
    node(E, "E", stroke: 0.5pt, radius: 20pt),
    node(R, "R", stroke: 0.5pt, radius: 20pt),
    node(L, "L", stroke: 0.5pt, radius: 20pt),
    node(A, "A", stroke: 0.5pt, radius: 20pt),

    // Edges
    edge(E, E, "-|>", label: $0.3$, label-side: auto, bend: 130deg, label-size: 9pt),
    edge(E, R, "-|>", label: $0.2$, label-side: right, bend: 20deg, label-size: 9pt),
    edge(E, L, "-|>", label: $0.25$, label-side: auto, bend: 15deg, label-size: 9pt),
    edge(E, A, "-|>", label: $0.25$, label-pos:0.15 , label-sep: -2pt,label-side: auto, bend: 10deg, label-size: 8pt),
    edge(R, R, "-|>", label: $0.4$, label-side: auto, bend: -130deg, label-size: 9pt),
    edge(R, E, "-|>", label: $0.3$, label-side: auto, bend: 20deg, label-size: 9pt),
    edge(R, A, "-|>", label: $0.15$, label-side: right, bend: 15deg, label-size: 9pt),
    edge(R, L, "-|>", label: $0.15$, label-side: auto, label-pos: 0.15,label-sep: -2pt,bend: 10deg, label-size: 8pt),
    edge(L, L, "-|>", label: $0.5$, label-side: auto, bend: 130deg, label-size: 9pt),
    edge(L, E, "-|>", label: $0.1$, label-side: right, bend: 15deg, label-size: 9pt),
    edge(L, A, "-|>", label: $0.2$, label-side: auto, bend: 20deg, label-size: 9pt),
    edge(L, R, "-|>", label: $0.2$, label-side: auto, label-pos: 0.15,label-sep: -2pt, bend: 10deg, label-size: 9pt),
    edge(A, A, "-|>", label: $0.7$, label-side: auto, bend: -130deg, label-size: 9pt),
    edge(A, E, "-|>", label: $0.1$, label-side: auto, label-pos: 0.15,label-sep: -2pt, bend: 10deg, label-size: 8pt),
    edge(A, R, "-|>", label: $0.1$, label-side: auto, bend: 15deg, label-size: 9pt),
    edge(A, L, "-|>", label: $0.1$, label-side: right, bend: 20deg, label-size: 9pt),
  )
]

#q(title: "Questão 2")[
    Faça um código, em qualquer linguagem da sua escolha, que faça as seguintes
  avaliações sobre o processo modelado pela cadeia de Markov descrito,
  assumindo a ordem dos estados como E, R, L, A
  + Mostre o valor da matriz de transição de $n$ passos, $P(n)$, para $n = 1, 2, 5, 10, 20, 50, 100$.

  + Mostre que a matriz de probabilidades de transição aponta para convergência ao longo das iterações.

  + Para $n = 1, 2, 5, 10, 20, 50, 100$, calcular a probabilidade de estar em cada estado após $n$ passos,
    começando de cada estado inicial arbitrário (de sua escolha).

  + Qual estado tem maior probabilidade estacionária? Ilustre os valores do vetor de probabilidades estacionárias.

  + Se o sistema for iniciado com as seguintes probabilidades iniciais dos estados
    $p(0) = [0.3, 0.2, 0.1, 0.4]$ (novamente assumindo a ordem E, R, L, A),
    verifique quão rápido o sistema "esquece o estado inicial"? Ou seja, a partir
    de que momento o sistema aproxima das probabilidades estacionárias? Mostre os gráficos
    que lhe permitiram concluir esse ponto.

]

+ 

  Sabemos que, de acordo com a equação de Chapman-Kolmogorov, conseguimos obter a matriz de transição de $n$ passos através da seguinte relação:

  $
  p_(i j) (m+n) = sum_k p_(i k) (m) dot p_(k j) (n)\
  $

  De acordo com a equação acima, temos que: 

  $
  P(n+m) = {p_(i j)(n+m)}\
  => P(n+m) = P(n) dot P(m)\
  => P(n) = P^n = product_(i=1)^n P\
  $
  onde $P$ é a matriz de transição de um passo.

  Com o seguinte código em python, conseguimos realizar essas operações
  matriciais e obter os resultados.
  ```python
  # Definindo a matriz de transição de 1 passo
  P = np.array([[0.3, 0.2, 0.25, 0.25],
                [0.3, 0.4, 0.15, 0.15],
                [0.1, 0.2, 0.5, 0.2], 
                [0.1, 0.1, 0.1, 0.7]])

  # Definindo uma lista para os valores desejados de "n"
  ns = [1, 2, 5, 10, 20, 50, 100]
  Ps = [np.linalg.matrix_power(P, n) for n in ns]
  ```


  #let show-mat(data) = math.mat(
  ..data.map(row => row.map(n => calc.round(n, digits:3)))
)

  #let P = (
  (0.3, 0.2, 0.25, 0.25),
  (0.3, 0.4, 0.15, 0.15),
  (0.1, 0.2, 0.5, 0.2),
  (0.1, 0.1, 0.1, 0.7),
  )
  $ P^1 = #show-mat(P) $

  #let mat-pow(P, n) = {
    let result = P 
    for _ in range(n - 1){
      result = nt.matmul(result, P)
    }
    result
  }

  #let P2 = mat-pow(P, 2)
  #let P5 = mat-pow(P, 5)
  #let P10 = mat-pow(P, 10)
  #let P20 = mat-pow(P, 20)
  #let P50 = mat-pow(P, 50)
  #let P100 = mat-pow(P, 100)

  #grid(
    columns: (1fr, 1fr),
    gutter: 2em,
    $ P^(2) = #show-mat(P2) $,
    $ P^(5) = #show-mat(P5) $,
    $ P^(10) = #show-mat(P10) $,
    $ P^(20) = #show-mat(P20) $,
    $ P^(50) = #show-mat(P50) $,
    $ P^(100) = #show-mat(P100) $,
  )

+
  Para demonstrar a convergência da matriz de transição ao longo das
  iterações, calcularemos a soma dos quadrados das diferenças entre os
  elementos das matrizes nos passos sucessivos da nossa amostra (por exemplo,
  a diferença entre a matriz no passo 100 e a do passo 50).


  #let example(body) = {
    text(style: "italic")[Ex.:]
    body
  }

  #example[
    $
    sum_i sum_j (p_(i j) (100) - p_(i j) (50))^2\
    $
  ]

