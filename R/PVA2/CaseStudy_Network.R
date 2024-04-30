#https://app.datacamp.com/learn/courses/case-studies-network-analysis-in-r
library(igraph)
g_amzn <- read.graph(xfun::from_root("data","tidy","amzn_g.gml"),format=c("gml"))

