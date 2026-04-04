#import "@preview/finite:0.5.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

= Mateus Ribeiro
== Trabalho sobre cadeias de markov

- A resolução está dividida entre esse documento onde
  se encontram as questões teóricas e os resultados
  das computacionais e um jupyternotebook com os códigos
  necessários.

= 1. Representaçao gráfica da cadeia de Markov

#align(center)[
  #v(30pt)
  #diagram(
    // Nodes
    let (E, R, L, A) = ((0, 1), (0, 3), (3.5, 1), (3.5, 3)),
    node(E, "E", stroke: 1pt, radius: 15pt),
    node(R, "R", stroke: 1pt, radius: 15pt),
    node(L, "L", stroke: 1pt, radius: 15pt),
    node(A, "A", stroke: 1pt, radius: 15pt),

    // Edges
    edge(E, E, "-|>", bend: 135deg),
    edge(E, R, "-|>", bend: 20deg),
    edge(E, L, "-|>", bend: 15deg),
    edge(E, A, "-|>", bend: 10deg),
    edge(R, R, "-|>", bend: -135deg),
    edge(R, E, "-|>", bend: 20deg),
    edge(R, A, "-|>", bend: 15deg),
    edge(R, L, "-|>", bend: 10deg),
    edge(L, L, "-|>", bend: 135deg),
    edge(L, E, "-|>", bend: 15deg),
    edge(L, A, "-|>", bend: 20deg),
    edge(L, R, "-|>", bend: 10deg),
    edge(A, A, "-|>", bend: -135deg),
    edge(A, E, "-|>", bend: 10deg),
    edge(A, R, "-|>", bend: 15deg),
    edge(A, L, "-|>", bend: 20deg),
  )
]
