library(igraph)
library(tidyverse)
library(tidygraph)




# Abbildung -----


## persönl. Netzwerk ----

knoten <- tibble(name=c("A","B","C","D","E","F","G","H"),type=c("Alter","Alter","Alter","Alter","Alter","Alter","Alter","Ego"))
kanten <- tibble(from=c("H","H","H","H","H","H","H","A","A","A","B","B","B","B","B","C","C","D","E","F","F","F","G","G","G","G"),
                 to=c("A","B","C","D","E","F","G","B","G","H","A","C","F","G","H","B","H","H","H","B","G","H","A","B","F","H")
)
n_ges <- tbl_graph(nodes = knoten, edges = kanten, directed = FALSE)

set.seed(4)
n_ges %>% ggraph(layout = "graphopt") +
  geom_node_point(aes(color=type),size=10,
                  show.legend = FALSE) +
  geom_node_text(aes(label = name),color=FFHSpurp) +
  geom_edge_link(start_cap = ggraph::circle(4,'mm'),
                 end_cap = ggraph::circle(4,'mm'),
                 width=1,color=FFHSpurp) +
  theme_void()

## Nachbildung Egonetzwerk Akabane et al. ----



knoten <- tibble(name=c(0:13),type=c("Ego","Alter","Alter","Alter","Alter",
                                     "Alter","Alter","Alter","Alter",
                                     "Alter","Alter","Alter","Alter",
                                     "Alter"))

kanten <- tibble(from=c(0,0,0,0,0,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,5,5,5,5,5,
                        6,6,7,7,8,9,9,9,10,11,11,12,12,13),
                 to=  c(1,2,3,4,5,0,2,5,6,0,1,3,11,12,0,2,4,5,8,0,3,7,0,1,3,6,7,
                        1,5,4,5,3,3,10,11,9,9,2,2,13,12))
kanten <- kanten %>%
            mutate(from=from+1,to=to+1)

n_ges <- tbl_graph(nodes = knoten, edges = kanten)

n_ges %>% ggraph(layout = "graphopt") +
  geom_node_point(aes(color=type),size=10,
                  show.legend = FALSE) +
  geom_node_text(aes(label = name),color=FFHSpurp) +
  geom_edge_link(start_cap = ggraph::circle(4,'mm'),
                 end_cap = ggraph::circle(4,'mm'),
                 width=1,color=FFHSpurp) +
  theme_void()


n_ges <- n_ges %>%
            activate("edges") %>%
            mutate(dir_ego=(.N()$name[from]=="1" | .N()$name[to]=="1")) %>%
            mutrate(indir_ego=)

n_ges %>% ggraph(layout = "graphopt") +
  geom_node_point(aes(color=type),size=10,
                  show.legend = FALSE) +
  geom_node_text(aes(label = name),color=FFHSpurp) +
  geom_edge_link(aes(edge_color=ego),
                 start_cap = ggraph::circle(4,'mm'),
                 end_cap = ggraph::circle(4,'mm'),
                 width=1) +
  theme_void()


test <- n_ges %>%
   activate(nodes) %>%
         mutate(neighborhood = local_members(mindist = 1))




# get data -----
library(igraphdata)
data(karate)
class(karate)

# convert to tidygraph ----

t_kar <- as_tbl_graph(karate)
class(t_kar)



t_kar %>% ggraph(layout = "graphopt") +
  geom_node_point(size=10,color=FFHSred) +
 # geom_node_text(aes(label = name),color=FFHSpurp) +
  geom_edge_link(start_cap = ggraph::circle(4,'mm'),
                 end_cap = ggraph::circle(4,'mm'),
                 width=1,color=FFHSpurp) +
  theme_void()


sub1 <- ego(karate)
ListOfGraphs = lapply(sub1, function(x) induced_subgraph(karate, x))

ListOfGraphs[[1]]


t_kar %>%
  activate(nodes) %>%
  mutate(neighborhood = local_members(mindist = 1)) %>%
  ggraph(layout = "graphopt") +
  geom_node_point(size=10,color=FFHSred) +
  # geom_node_text(aes(label = name),color=FFHSpurp) +
  geom_edge_link(start_cap = ggraph::circle(4,'mm'),
                 end_cap = ggraph::circle(4,'mm'),
                 width=1,color=FFHSpurp) +
  theme_void()





---
  class: left

```{r}
gr1 <- create_notable('bull') %>%
  mutate(name = letters[1:5])
gr1
```

```{r}
gr1 %>%
  ggraph(layout = 'kk') +
  geom_edge_link() +
  geom_node_point(size = 8, colour = 'steelblue') +
  geom_node_text(aes(label = name), colour = 'white', vjust = 0.4) +
  theme_graph()

```
???

  [tidygraph](https://www.data-imaginist.com/posts/2017-07-07-introducing-tidygraph/)

---
  class: left

```{r}
gr2 <- create_ring(5) %>%
  mutate(name = letters[4:8])

# Plot
gr1 %>% bind_graphs(gr2) %>%
  ggraph(layout = 'kk') +
  geom_edge_link() +
  geom_node_point(size = 8, colour = 'steelblue') +
  geom_node_text(aes(label = name), colour = 'white', vjust = 0.4) +
  ggtitle('Binding graphs') +
  theme_graph()
```
???

  [tidygraph](https://www.data-imaginist.com/posts/2017-07-07-introducing-tidygraph/)
