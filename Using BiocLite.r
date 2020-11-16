# Sample Guide

# Bioconductor has its own repository, way to install packaages, and each release is designed to work with a specific version of R.

# Bioconductor version 3.7 or ealier uses BiocLte:
source("https://bioconductor.org/biocLite.R")
biocLite("packageName")

Bioconductor version 3.8 and later uses BiocManager:

if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install()

# Check Bioconductor version (For versions <= 3.7)
BioInstaller::bioVersion()
# or
bioVersion()
# Load a package
library(packageName)
#Check versions for reproducibility
sessionInfo()
# or
packageVersion("packageName")
# Check package update (Bioconductor version <=3.7)
BioInstaller::bioValid()
# or
bioValid()

# Ex1
# Load the BiocInstaller package
library(BiocInstaller)

# Check R version
version

# Explicit syntax to check the Bioconductor version
BiocInstaller::biocVersion()

# Ex2
# Load the BSgenome package
library(BSgenome)

# Check the version of the BSgenome package
packageVersion("BSgenome")

# Sample Guide

# The role of S4 in Bioconductor

# S3
# Positive
# CRAN, simple but powerful 
# Flexible and interactive
# Uses a generic function 
# Functionality dependson the first argument
# Example:plot() and methods(plot)

# Negative
# Bad at validating types and naming conventions