# st_intersects ----

pts = st_sfc(st_point(c(.5,.5)), st_point(c(1.5, 1.5)), st_point(c(2.5, 2.5)))
pol = st_polygon(list(rbind(c(0,0), c(2,0), c(2,2), c(0,2), c(0,0))))
(lst = st_intersects(pts, pol))

(mat = st_intersects(pts, pol, sparse = FALSE))


plot(pol)
plot(pts)


pts = st_sfc(st_point(c(.5,.5)), st_point(c(1.5, 1.5)),st_point(c(2, 2)), st_point(c(2.5, 2.5)))
(lst2 = st_touches(pts, pol))
(mat = st_touches(pts, pol, sparse = FALSE))



pol2 = st_polygon(list(rbind(c(0,0), c(-2,0), c(-2,-2), c(0,-2), c(0,0))))

(lst2 = st_touches(pol, pol2))
(mat = st_touches(pol, pol2, sparse = FALSE))
