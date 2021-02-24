
# LOAD PACKAGES  ----------------------------------------------------------

library(tidyverse)

# SCRIPT ------------------------------------------------------------------

iris <- as_tibble(iris) # so it prints a little nicer

# QUESTION ONE ------------------------------------------------------------

rename(
  iris,
  sepal_length = Sepal.Length,
  sepal_width = Sepal.Width,
  petal_length = Petal.Length,
  petal_width = Petal.Width
)

# QUESTION TWO ------------------------------------------------------------

mutate(
  iris,
  Sepal.Length = Sepal.Length * 10,
  Sepal.Width = Sepal.Width * 10,
  Petal.Length = Petal.Length * 10,
  Petal.Width = Petal.Width * 10
)

# QUESTION THREE ----------------------------------------------------------

iris_area <- 
mutate(iris,
       Sepal_area = Sepal.Length * Sepal.Width,
       petal_area = Petal.Length * Petal.Width)
select(iris_area,Sepal_area,petal_area)

# QUESTION FOUR -----------------------------------------------------------

summarize(
  iris,
  sampl_size = n(),
  max = max(Sepal.Length),
  min = min(Sepal.Length),
  range = max-min,
  median = median(Sepal.Length),
  q1 = quantile(Sepal.Length, probs=0.25),
  q3 = quantile(Sepal.Length, probs=0.75),
  iqr = IQR(Sepal.Length)
)

# QUESTION FIVE -----------------------------------------------------------

iris_grouped <- group_by(iris,Species)
iris_grouped

iris_summarised<-
summarise(
  iris_grouped,
  sample_size = n(),
  mean = mean(Petal.Width),
  sd = sd(Petal.Width),
  var = var(Petal.Width),
  stderr = sd / sqrt(sample_size),
  ci_upper = mean + 2 * stderr,
  ci_lower = mean - 2 * stderr
)
iris_summarised

# QUESTION SIX ------------------------------------------------------------

ggplot(data=iris)+geom_jitter(aes(y=Petal.Length,x=Species))

# QUESTION SEVEN ----------------------------------------------------------

ggplot(data=iris)+geom_jitter(aes(y=Petal.Width,x=Species, color=Species)) +
geom_crossbar(
  data = iris_summarised, 
  mapping = aes(x = Species, y = mean, ymax = ci_upper, 
                ymin = ci_lower),
  color = "red"
)

# QUESTION EIGHT ----------------------------------------------------------

ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Length , y = Petal.Width, color = Species))
