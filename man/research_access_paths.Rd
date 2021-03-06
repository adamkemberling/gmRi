% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oisst_mainstays_data_access.R
\name{research_access_paths}
\alias{research_access_paths}
\title{Establish Research Box Paths}
\usage{
research_access_paths(
  os.use = "unix",
  user.name = "not applicable, I use a mac."
)
}
\arguments{
\item{os.use}{String flag indicating what operating system the user is currently using.
Options are "unix" for mac users or "windows".}

\item{user.name}{User name for navigating root directory structure on windows.}
}
\value{
res_paths List containing user-specific paths
}
\description{
Returns list of box resource paths for quick access to commonly accessed
resources. Includes the Mills lab, Res data, knowledge graph data, and oisst mainstays.
}
\examples{
# Not run:
# box_paths <- research_access_paths(os.use = "unix", user.name = "NA, I use a mac")
}
