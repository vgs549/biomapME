\name{phylogenetic.endemism}
\alias{phylogenetic.endemism}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Phylogenetic Range-rarity & Georeferenced Phylogenetic Endemism
%%  ~~function to do ... ~~
}
\description{Calculates phylogenetic endemism (Faith's phylogenetic diversity inversely weighted by the spatial range of particular branch lengths) or alternatively (unweighted) phylogenetic diversity across gridded maps using individual or site-based point records.
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
phylogenetic.endemism(species_records, records = "single", site.coords, species = "SPECIES", longitude = "LONGITUDE", latitude = "LATITUDE", sep.comm.spp = " ", phylo.tree, sep.phylo.spp = "_", frame.raster, deg.resolution = c(0.25, 0.25), extent.vector, pe.type = "weighted", plot.raster = TRUE, weight.type = "cell", outlier_pct = 95, own.weights, own.grid.matrix, own.phylo.cell.matrix, own.phyloMatrix)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{species_records}{A data.frame, either with: <b>a)</<b> rows as individual species records, and columns that include fields for species name, longitude and latitude (see ‘species’, ‘longitude’, ‘latitude’ below); or <b>b)</b> rows as sites and columns as species, in which case ‘site.coords’ (below) must also be supplied.
%%     ~~Describe \code{species_records} here~~
}
  \item{records}{Are the species_records in single/long format (the default, records="single") or in site-based/short format (records="site").
%%     ~~Describe \code{records} here~~
}
  \item{site.coords}{For site-based data (records="site"), a data.frame with rows as sites (/field plots) (names match the. row names of species_records) and their geographic (longlat) coordinates: first column must be x/longitude, second column y/latitude
%%     ~~Describe \code{site.coords} here~~
}
  \item{species}{For records="single" (i.e. individual occurrence data); what colname in the supplied species_records contains species names?
%%     ~~Describe \code{species} here~~
}
  \item{longitude}{for records="single"; what colname in the supplied species_records contains longitude values?
%%     ~~Describe \code{longitude} here~~
}
  \item{latitude}{For records="single"; what colname in the supplied species_records contains latitude values?
%%     ~~Describe \code{latitude} here~~
}
  \item{sep.comm.spp}{The genus_species separating character in the community data. If there is none (i.e. taxon names represented by a single 'word'), argument should be set to sep.comm.spp=“none". The purpose of this argument is that it is common for separators to differ between community data and phylogenetic trees due to the different processing functions applied, and to avoid having to reformat the data, this argument allows them to be matched within the function. Default is a space.
%%     ~~Describe \code{sep.comm.spp} here~~
}
  \item{phylo.tree}{A phylogenetic tree of class 'phylo' containing species in the occurrence data. Must have branch lengths.
%%     ~~Describe \code{phylo.tree} here~~
}
  \item{sep.phylo.spp}{The genus_species separating character in the phylo.tree (tip.labels). If there is none (i.e. taxon names represented by a single 'word'), argument should be set to sep.phylo.spp=“none". See sep.comm.spp argument for purpose. Default for phylo.tree is an underscore, as this is a common format in community ecology using e.g. phylomatic trees.
%%     ~~Describe \code{sep.phylo.spp} here~~
}
  \item{frame.raster}{An existing rasterLayer object. User can elect to supply a raster as the frame for calculations and mapping. If not specified, the function will generate a raster based on default or specified extent and resolution.
%%     ~~Describe \code{frame.raster} here~~
}
  \item{deg.resolution}{Argument specifying the map resolution in degrees the user wishes the calculations and mapping to use. If none are specified, default resolution (0.25) is used. If a frame.raster is specified, these arguments are ignored (function bases mapping on the supplied raster).
%%     ~~Describe \code{deg.resolution} here~~
}
  \item{extent.vector}{Arguments specifying the map extent in degrees the user wishes the calculations and mapping to use. If none are specified, default extent (data extent) is used. If a frame.raster is specified, these arguments are ignored (function bases mapping on the supplied raster).
%%     ~~Describe \code{extent.vector} here~~
}
  \item{pe.type}{Either "weighted" (default; = phylogenetic endemism), or "unweighted" (= phylogenetic diversity).
%%     ~~Describe \code{pe.type} here~~
}
  \item{plot.raster}{Whether or not to plot the output raster of endemism scores. Whether plotted or not, a raster object is stored in the returned output.
%%     ~~Describe \code{plot.raster} here~~
}
  \item{weight.type}{Range wieght type for calculation of phylogenetic endemism. Default is "cell" (grid cell-based range weights:: phylogenetic range rarity), while "geo" will calculate georeferenced range 'span' weights (georeferenced phylogenetic endemism). Argument is ignored if pe.type="unweighted" or if own.weights are provided.
%%     ~~Describe \code{weight.type} here~~
}
  \item{outlier_pct}{For the calculation of range 'span' via convex polygons, this argument can be used to remove outliers on a percentage basis via the 'mcp' function in package adehabitat, i.e. 95 (default) means 5 percent most outlying points are removed.
%%     ~~Describe \code{outlier_pct} here~~
}
  \item{own.weights}{An optional user-supplied numeric vector of branch length weights for calculating phylogenetic endemism. This argument is intended mainly so that time consuming calculation of georeferenced weights can be done once and the result stored and used for subsequent re-runs. Alternatively, user-calculated weights can be used in subsequent runs. The weights must be matched to a matrix representation of phylo.tree (see below).
%%     ~~Describe \code{own.weights} here~~
}
  \item{own.grid.matrix}{Optional user supplied binary matrix of species against grid cell numbers, rather than this being generated within the function. The purpose of this argument is to save time for repeat runs, given the step can be time consuming for large datasets. Must be provided if own.phylo.cell.matrix is supplied-- although the function no longer requires the grid.matrix, it is still needed for inclusion in the outputs, so that they can be subsequently fed into the pe.null.test function (which does requires the grid.matrix...). If supplied, a frame.raster must also be supplied that has cell numbers which match the row.names of the own.grid.matrix. Assumes that genus/species words are separated by the sep.phylo.spp, as this is how the grid.matrix is returned from the function originally.
%%     ~~Describe \code{own.grid.matrix} here~~
}
  \item{own.phylo.cell.matrix}{User can supply the matrix representing occurrences of phylogenetic branches in map grid cells from previous runs to save computation time (i.e. $phylo.cell.matrix of a previous phylogenetic.endemism output). A matching 'frame.raster' must also be supplied.
%%     ~~Describe \code{own.phylo.cell.matrix} here~~
}
  \item{own.phyloMatrix}{If user provides the above own.phylo.cell.matrix in a repeat run of the function, this must also be supplied, as the function still defaults to returning 'phylo.matrix' even though the function now skips its generation. e.g. $phyloMatrix of an previous phylogenetic.endemism.R run).
%%     ~~Describe \code{own.phyloMatrix} here~~
}
}
\details{This implementation of phylogenetic endemism allows alternative calculation of weights for branch length ranges. Weights can be calculated based on the frequency of occurrence in grid cells, or alternatively by the georeferenced span of the range. Unweighted phylogenetic diversity can also be selected.
%%  ~~ If necessary, more details than the description above ~~
}
\value{Returns a list of length 3 (for pe.type="unweighted" = phylogenetic diversity/PD) or length 7 (for pe.type="weighted" = phylogenetic endemism/PE). For both PD and PE:
  \item{$PD }{Vector of phylogenetic diversity/endemism scores. }
  \item{$PD_raster }{Raster map with phylogenetic diversity/endemism scores.}
    \item{$grid.matrix }{A binary data.frame of species against grid cell numbers used in the function which is returned so that it can be re-used to save computation time, and because it is required in the downstream pe.null.test.R function to calculated species sample probabilities. Note that this only includes species that are found in the phylo.tree.}
    \item{$PD }{Vector of phylogenetic diversity/endemism scores. }
For PE only:
  \item{$ranges }{A named numeric vector of weights used to calculate endemism (equivalent to range size in metres if weight.type="geo", range size in cells if weight.type="cell" (default), or the user supplied weights if own.weights was supplied) (skipped if pe.type="unweighted"). }
  \item{$phyloMatrix }{A binary matrix representation of the phylo.tree, returned mainly for convenience for downstream use (skipped if pe.type="unweighted"). }
  \item{$phylo.cell.matrix }{A binary matrix recording the presence of particular phylogenetic branches in map grid cells used in the function, which is returned for re-use in subsequent runs for efficiency (e.g. with different weights), (skipped if pe.type="unweighted"). }
  \item{$edge.lengths }{A numeric vector of edge lengths from the phylo.tree }
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{Guerin, G.R. and Lowe, A.J. (submitted) Mapping phylogenetic endemism in R using georeferenced branch extents.
Rosauer, D., Laffan, S. W., Crisp, M. D., Donnellan, S. C. & Cook, L. G. (2009) Phylogenetic endemism: a new approach for identifying geographical concentrations of evolutionary history. Molecular Ecology, 18(19), 4061-4072.
%% ~put references to the literature/web site here ~
}
\author{Greg R. Guerin
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{\code{\link{pe.null.test}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
data(mite)
data(mite.xy)
mite.tree <- rtree(n=ncol(mite), tip.label=colnames(mite)) #for this example, generate a phylogenetic tree of the species in the mite dataset with random relationships and branch lengths
mite.PE <- phylogenetic.endemism(mite, records="site", site.coords=mite.xy, sep.comm.spp="none", phylo.tree=mite.tree, sep.phylo.spp="none", weight.type="cell")
mite.PE
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line