## split data into discrete and continuous tables
SplitColType <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # find indicies for continuous features
  ind <- sapply(data, is.numeric)
  # number of discrete vs. continuous features
  n_continuous <- sum(ind)
  n_discrete <- ncol(data) - n_continuous
  # create object for continuous features
  continuous <- data[, which(ind), with=FALSE]
  # create object for discrete features
  discrete <- data[, which(!ind), with=FALSE]
  return(list("discrete" = discrete, "continuous" = continuous, "num_discrete"=n_discrete, "num_continuous"=n_continuous))
}