# Example for Stan-Ymet-Xnom1grp-Mrobust.R 
#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#------------------------------------------------------------------------------- 
# Load The data file 
myDataFrame = read.csv( file="TwoGroupIQ.csv" )
# For purposes of this one-group example, use data from Smart Drug group:
myData = myDataFrame$Score[myDataFrame$Group=="Smart Drug"]
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Stan-Ymet-Xnom1grp-Mrobust.R")
#------------------------------------------------------------------------------- 
# Optional: Specify filename root and graphical format for saving output.
# Otherwise specify as NULL or leave saveName and saveType arguments 
# out of function calls.
fileNameRoot = "OneGroupIQrobust-Stan-" 
graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
mcmcCoda = genMCMC( data=myData , numSavedSteps=20000 , saveName=fileNameRoot )
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names
for ( parName in parameterNames ) {
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
            saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , 
                        compValMu=100.0 , ropeMu=c(99.0,101.0) ,
                        compValSigma=15.0 , ropeSigma=c(14,16) ,
                        compValEff=0.0 , ropeEff=c(-0.1,0.1) ,
                        saveName=fileNameRoot )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , 
          compValMu=100.0 , ropeMu=c(99.0,101.0) ,
          compValSigma=15.0 , ropeSigma=c(14,16) ,
          compValEff=0.0 , ropeEff=c(-0.1,0.1) ,
          pairsPlot=TRUE , showCurve=FALSE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
