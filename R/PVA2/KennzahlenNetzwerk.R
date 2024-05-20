# Daten -----------

## Beispiel 1 -----------

### Adjazenzmatrix -----
# Vektoren für Beziehungen der einzelnen Knoten eingeben
A1 <- c(0,0,1,0,0,0,0,0,0)
A2 <- c(0,0,1,1,0,0,0,0,0)
A3 <- c(1,1,0,1,0,0,0,0,0)
A4 <- c(0,1,1,0,1,0,0,0,0)
A5 <- c(0,0,0,1,0,1,0,0,1)
A6 <- c(0,0,0,0,1,0,1,0,0)
A7 <- c(0,0,0,0,0,1,0,1,1)
A8 <- c(0,0,0,0,0,0,1,0,1)
A9 <- c(0,0,0,0,1,0,1,1,0)
# Matrix erzeugen
ad_mat <- rbind(A1, A2, A3, A4, A5, A6, A7, A8, A9)
ad_mat
# Spalten benennen
colnames(ad_mat) <- c("A1","A2","A3","A4","A5","A6","A7","A8","A9")
# Ausgabe
print(ad_mat)

### Inzidenzmatrix -----

# Zahl der Knoten und Kanten ermitteln
num_nodes <- ncol(ad_mat)
num_edges <- sum(ad_mat) / 2  # Für ungerichtete Graphen wird jede Kante zweimal gezählt

# (leere) Inzidenzmatrix initialisieren
inc_mat <- matrix(0, nrow = num_nodes, ncol = num_edges)

# Kanten und Knoten prüfen
edge_index <- 1
for (i in 1:(num_nodes - 1)) {
  for (j in (i + 1):num_nodes) {
    if (ad_mat[i, j] == 1) {
      inc_mat[i, edge_index] <- 1
      inc_mat[j, edge_index] <- 1
      edge_index <- edge_index + 1
    }
  }
}
# Zeilen und Spalten benennen
rownames(inc_mat) <- c("A1","A2","A3","A4","A5","A6","A7","A8","A9")
colnames(inc_mat) <- c("e1","e2","e3","e4","e5","e6","e7","e8","e9","e10","e11")
# Ausgabe
print(inc_mat)

### Netzwerkobjekt erstellen ----

## igraph -----
library(igraph) #ggf. Paket installieren mit install.packages("igraph")
ig1 <- graph_from_adjacency_matrix(ad_mat,mode="undirected")

#### Adjazenzlist (Kanten) ----
igraph::as_adj_edge_list(ig1)


### tidygraph ----
library(tidygraph) #ggf. Paket installieren mit install.packages("igraph")
tg1 <- as_tbl_graph(ig1)
tg1
# Graph ------

### igraph -----
plot(ig1)

### ggraph ----
library(ggraph)
set.seed(31)
tg1 %>% ggraph(layout="graphopt") +
          geom_node_point(size=10) +
          geom_node_text(aes(label = name),color="white") +
          geom_edge_link(width=1.1,
                         start_cap = ggraph::circle(3,'mm'),
                         end_cap = ggraph::circle(3,'mm'))



## Beispiel 2 ----



## Beispiel 3 -----





# Analyse auf Netzwerkebene (Teil 1) -----

## Zahl der Knoten ----

# igraph
gorder(ig1)

# tidygraph
with_graph(tg1, graph_order())





## Zahl der Kanten ----

# igraph
gsize(ig1)

# tidygraph
with_graph(tg1, graph_size())


## Dichte ----

# händisch
(2*gsize(ig1))/(gorder(ig1)*gorder(ig1)-1)




## Degree-Verteilung ----

# igraph
degree_distribution(ig1)
# Interpretation: For degree_distribution() a numeric vector of the same
#length as the maximum degree plus one. The first element is the relative
#frequency zero degree vertices, the second vertices with degree one, etc.

# tidygraph
tg1 %>%
  activate(nodes) %>%
  mutate(degree=centrality_degree()) %>%
  as_tibble() %>%
  janitor::tabyl(degree)




## Durchschnittliche Pfadlänge ---

#igraph
average.path.length(ig1)

#tidygraph
with_graph(tg1, graph_mean_dist())


## Durchmesser ----

# igraph
diameter(ig1)

# tidygraph
with_graph(tg1, graph_diameter())







# Analyse der Knoten -------


## Knoten identifizieren -----

# igraph
V(ig1)

# tidygraph
tg1 %>%
  activate(nodes) %>%
  as_tibble()


## Zentralitätsmaße -----

### Degree-Zentralität ----

# igraph -----
degree(ig1)

which.max(degree(ig1))

# tidygraph ----
tg1 %>%
  activate(nodes) %>%
  mutate(degree=centrality_degree()) %>%
  as_tibble()

tg1 %>%
  activate(nodes) %>%
  mutate(degree=centrality_degree()) %>%
  as_tibble() %>%
  filter(degree==max(degree))

tg1 %>%
  activate(nodes) %>%
  mutate(degree=centrality_degree()) %>%
  as_tibble() %>%
  arrange(desc(degree))


### Closeness-Zentralität ----
tg1 %>%
  activate(nodes) %>%
  mutate(close=(graph_order()-1)*centrality_closeness(),
        close_gen=centrality_closeness_generalised(alpha=1)) %>%
  as_tibble()

?centrality_closeness_gen()


### Betweenness-Zentralität ----
tg1 %>%
  activate(nodes) %>%
  mutate(betw=centrality_betweenness()) %>%
  as_tibble()




### Stärke -----
# für gerichtete Graphen - Summe der Gewichte der vom Knoten ausgehenden Kanten




# Analyse der Kanten ------

## Kanten identifizieren -----

# igraph
E(ig1)

# tidygraph
tg1 %>%
  activate(edges) %>%
  as_tibble()





# Teilgruppen -----




## Komponenten -----


### Bi-Komponenten ----

#Jeder Knoten kann von jedem anderen Knoten über zwei unabhängige Pfade erreicht werden.
#Der Wegfall eines Knotens führt nicht zur Unverbundenheit des Netzwerks


# tidygraph
tg1 %>%
  activate(edges) %>%
  mutate(group=group_biconnected_component()) %>%
  as_tibble()

# igraph
igraph::biconnected_components(ig1)

## Teilgraphen ----



# igraph
cluster_fast_greedy(ig1)

#tidygraph
tg1 %>%
  activate(nodes) %>%
  mutate(group=group_optimal()) %>%
  as_tibble()


### Triadenzensus ----

# igraph
triad.census(ig1)


## Verbundenheit ----


## Cliquen -----


## Positionen und Rollen ----
