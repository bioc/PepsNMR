\name{BaselineCorrection}
\alias{BaselineCorrection}
\title{
Set the baseline to a uniform zero signal.
}
\description{
Estimates and remove the smoothed baseline from the spectrum.
}
\usage{BaselineCorrection(RawSpect_data, ptw.bc = TRUE, maxIter = 42,lambda.bc=1e7,
                                    p=0.05, eps=1e-8, returnBaseline=F)}
\arguments{
  \item{RawSpect_data}{Matrix containing the spectra in Hertz, one row per spectrum.}
  \item{ptw.bc}{If \code{TRUE}, calculates the baseline in C using the \code{ptw} library which is a lot faster.
  The R version is only kept because it is easier to understand than C and in case of problems with the installation of \code{ptw}.}
  \item{maxIter}{Maximum of iterations if \code{ptw.bc} is set to \code{FALSE}}
  \item{lambda.bc}{Smoothing parameter (generally 1e5 -- 1e8)}.
  \item{p}{Asymmetry parameter}.
  \item{eps}{Numerical precision for convergence when estimating the baseline}.
  \item{returnBaseline}{If TRUE, will return the estimation of the baseline.}.
}
\details{
After Zero Order Phase Correction, the signal should be an addition of positive peaks which represent metabolites available in the sample.
These peaks are added to the baseline which is a signal representing the absence of any metabolite and should be uniformly zero. For each spectrum,its baseline is thus estimated and removed from it.

Let \eqn{F}{F} be our initial spectrum an \eqn{Z}{Z} be the baseline.
Once \eqn{Z}{Z} is approximated, the corrected spectrum is \eqn{F-Z}{F-Z}.


As explained, a negative signal doesn't make sense and creates problems with the statistical analysis.
That is why \code{\link{NegativeValuesZeroing}} sets the negative values to zeros.
Therefore, we really don't want frequencies where \eqn{F-Z < 0}{F-Z < 0}.
In the objective function to be minimized, we therefore take the squared difference \eqn{F-Z}{F-Z} multiplied by \eqn{p}{p} if \eqn{F-Z > 0}{F-Z > 0} or \eqn{1-p}{1-p} if \eqn{F-Z < 0}{F-Z < 0}.
\eqn{p}{p} is indeed taken very small, \emph{e.g.} \code{0.05}.

With this function to minimize, we would simply have \eqn{F=Z}{F=Z} as a solution which would make \eqn{F-Z}{F-Z} uniformly zero. Therefore, the penalty on roughness on \eqn{Z}{Z} is applied so that it does not match the peaks.
This smoothness constraint is multiplied by \eqn{\lambda}{lambda} and is typically equal to \code{1e7}.


In summary, usefull parameters are:
\describe{
  \item{\code{p}}{The default value is \code{0.05}, the smaller it is, the less \eqn{Z}{Z} will try to follow peaks when it is under the function and the more it will try to be under the function.}
  \item{\code{lambda}}{The default value is \code{1e7}, the larger it is, the smoother \eqn{Z}{Z} will be.
  With \code{lambda=0}, the baseline will be equal to the signal and the corrected signal will be zero.}
}

The algorithm used to find the baseline is iterative. In \code{ptw}, the iteration is done until the baseline is found but if \code{ptw.bc} is set to \code{FALSE}, we give up after \code{maxIter} iterations.

More details and motivations are given in the articles mentionned in the References.

}
\value{
\item{RawSpect_data}{The matrix of spectra with the baseline removed.}
}
\references{
  Rousseau, R. (2011). \emph{Statistical contribution to the analysis of metabonomics data in 1H NMR spectroscopy}
  (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences actuarielles, Université catholique de Louvain, Belgium).

  Eilers, PHC. and Boelens, HFM. (2005). \emph{Baseline correction with asymmetric
least squares smoothing.} Leiden University Medical Centre report,
2005.
}
\author{
Benoît Legat
}
\note{
}

\seealso{
See also \code{\link{SolventSuppression}} which also uses the Whittaker smoother.
}
\examples{
BC.spec <- BaselineCorrection(Data_HS$RawSpectData_HS_5,lambda.bc=5e+06, p=0.05)
#or
BC.res <- BaselineCorrection(Data_HS$RawSpectData_HS_5,lambda.bc=5e+06, p=0.05, returnBaseline=TRUE)
BC.spec = BC.res[["RawSpect_data"]]
plot(BC.res[["baseline"]], type="l")
}
\keyword{ manip }
