\name{NegativeValuesZeroing}
\alias{NegativeValuesZeroing}
\title{
Zeroing of negative values.
}
\description{
Sets negative intensities to zero.
}
\usage{
NegativeValuesZeroing(RawSpect_data)
}
\arguments{
  \item{RawSpect_data}{Matrix containing the spectra in Hertz, one row per spectrum..}
}
\value{
\item{RawSpect_data}{The matrix of spectrums with the negative values set to zero.}
}
\details{
As explained in \code{\link{BaselineCorrection}},
negative values does not make sense and can have bad impacts on our statistical analyses.
\code{\link{BaselineCorrection}} do its best to remove negative values but there might be some remaining.

This filter simply sets them to zero.
After the \code{\link{BaselineCorrection}} they should be close to zero anyway because of the high
\eqn{1-p}{1-p} penalty given to the value of the signal after the correction if it is negative.
}
\references{
  Rousseau, R. (2011). \emph{Statistical contribution to the analysis of metabonomics data in 1H NMR spectroscopy}
  (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences actuarielles, Université catholique de Louvain, Belgium).
}
\author{
Benoît Legat
}
\examples{
Nvz.spec <- NegativeValuesZeroing(Data_HS$RawSpectData_HS_6)
}
\keyword{ manip }
