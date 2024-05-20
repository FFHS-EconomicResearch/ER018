library(tidyverse)
library(tidygraph)
library(ggraph)
library(patchwork)

# Allg. Definitionen ----------
FFHSred <- "#d50006"
FFHSpurp <- "#502479"

ggsave_to_variable <- function(p, width = 10, height = 10, dpi = 300){
  pixel_width  = (width  * dpi) / 2.54
  pixel_height = (height * dpi) / 2.54

  img <- magick::image_graph(pixel_width, pixel_height, res = dpi)

  on.exit(utils::capture.output({
    grDevices::dev.off()}))
  plot(p)

  return(img)
}

# Dyadenzensus ------

## Definitionen -----



knoten <- tibble(name=c("A","B"))
kanten <- tibble(from=c("A"),to=c("B"))

d1 <- tbl_graph(nodes = knoten, edges = kanten, directed = TRUE)


p <- d1 %>% ggraph(layout = "grid") +
                geom_node_point(size=10,color=FFHSred) +
                geom_node_text(aes(label = name,color="white"),
                               show.legend = FALSE) +
                theme(plot.margin = unit(c(3,3,3,3), "lines")) + theme_void() +
                labs(title=expression(paste("Null Dyade, ", D[ij],"=(0,0)",sep="")))
p


p1 <- d1 %>% ggraph(layout = "grid") +
                  geom_node_point(size=10,color=FFHSred) +
                  geom_node_text(aes(label = name,color="white"),
                         show.legend = FALSE) +
                  geom_edge_link(arrow = arrow(),
                         start_cap = ggraph::circle(4,'mm'),
                         end_cap = ggraph::circle(4,'mm'),
                         width=1,color=FFHSpurp) +
                  theme(plot.margin = unit(c(3,3,3,3), "lines")) + theme_void() +
                  labs(title=expression(paste("Asymmetrische Dyade, ", D[ij],"=(1,0)",sep="")))
p1
kanten <- tibble(from=c("B"),to=c("A"))

d1b <- tbl_graph(nodes = knoten, edges = kanten, directed = TRUE)
p2 <- d1b %>% ggraph(layout = "grid") +
                  geom_node_point(size=10,color=FFHSred) +
                  geom_node_text(aes(label = name,color="white"),
                         show.legend = FALSE) +
                  geom_edge_link(arrow = arrow(),
                         start_cap = ggraph::circle(4,'mm'),
                         end_cap = ggraph::circle(4,'mm'),
                         width=1,color=FFHSpurp) +
                  theme(plot.margin = unit(c(3,3,3,3), "lines")) + theme_void() +
                  labs(title=expression(paste("Asymmetrische Dyade, ", D[ij],"=(0,1)",sep="")))
p2

kanten <- tibble(from=c("A","B"),to=c("B","A"))
d2 <- tbl_graph(nodes = knoten, edges = kanten, directed = TRUE)
p3 <- d2 %>% ggraph(layout = "grid") +
                geom_node_point(size=10,color=FFHSred) +
                geom_node_text(aes(label = name,color="white"),
                               show.legend = FALSE) +
                geom_edge_link(strength=1,arrow = arrow(),
                            start_cap = ggraph::circle(4,'mm'),
                            end_cap = ggraph::circle(4,'mm'),
                            width=1,color=FFHSpurp) +
                theme(plot.margin = unit(c(3,3,3,3), "lines")) + theme_void() +
                labs(title=expression(paste("Reziprozität, ", D[ij],"=(1,1)",sep="")))
p3


(p | p2) /
(p1 | p3)

wrap_plots(p, p2, p1, p3)

p1+p2

library(cowplot)
plot_grid(p, p1,p3, p2,ncol=2)

library(magick)
png1 <- ggsave_to_variable(p)
i1 <- image_border(image_background(png1, "#fff"), "#fff", "20x10")
png2 <- ggsave_to_variable(p1)
i2 <- image_border(image_background(png2, "#fff"), "#fff", "20x10")
png3 <- ggsave_to_variable(p3)
i3 <- image_border(image_background(png3, "#fff"), "#fff", "20x10")
png4 <- ggsave_to_variable(p2)
i4 <- image_border(image_background(png4, "#fff"), "#fff", "20x10")

images=c(i1,i2,i3,i4)
dyad_census <- c(i1,i2,i3,i4) %>%
          magick::image_montage(tile = '2')
class(dyad_census)
image_write(dyad_census,xfun::from_root("img","PVA2","dyad_census.svg"),format = "svg")


# Triadenzensus -----


## Definitionen -----

knoten <- tibble(name=c("A","B","C"))
kanten <- tibble(from=c("A","B"),to=c("B","A"))

t1 <- tbl_graph(nodes = knoten, edges = kanten, directed = TRUE)

3 <- d2 %>% ggraph(layout = "grid") +
  geom_node_point(size=10,color=FFHSred) +
  geom_node_text(aes(label = name,color="white"),
                 show.legend = FALSE) +
  geom_edge_arc(strength=1,arrow = arrow(),
                start_cap = ggraph::circle(4,'mm'),
                end_cap = ggraph::circle(4,'mm'),
                width=1,color=FFHSpurp) +
  theme_void() +
  labs(title=expression(paste("Reziprozität, ", D[ij],"=(1,1)",sep="")))
