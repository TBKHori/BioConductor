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
# Inherritance works, but depends on the input

# S4
# Positive
# Formal defination of classes
# Bioconductor reusability
# Has validation of types
# Naming conventions
# Example: mydescriptor <- new("GenomeDescription")

# Negative
# Complex structure compared to S3

# Is it S4 or not?
# Ask if an object is S4
isS4(mydescriptor)
# Result: TRUE

str of S4 objects start with Formal classes

str(mydescriptor)
# Result: Formal class 'GenomeDescription' [package "GemeInfoDb"] with 7 slots
...

# S4 class definition
# A class describes a representation

# name
# solts (methods/fields)
# contains (inheritance definiton)

MyEpicProject <- setClass(# Define class name with UpperCamelCase
                        "MyEpicProject",
                        # Define slots, helpful for validation
                        solts c(ini = "Date",
                                end = "Date"
                                milestone = "character"),
                        # Define inheritance
                        contains = "MyProject")

.s4methods(class= "GenomeDescription")
# [1] commonName organism provider providerVersion releaseDate releaseName seqinfo
# [8] seqnames show toString bsgenomeName

showMethods(classes = "GenomicDescription", where = search())

# Object summary
show(myDescriptor)

# Result:
# | organism: ()
# | provide:
# | provider version:
# | release date:
# | release name:
# | ---
# | seqlenghts:


#Ex3
showClass("BSgenome")
# Result:
Class "BSgenome" [package "BSgenome"]

Slots:
                                                                     
Name:               pkgname     single_sequences   multiple_sequences
Class:            character OnDiskNamedSequences        RdaCollection
                                                                     
Name:            source_url        user_seqnames   injectSNPs_handler
Class:            character            character    InjectSNPsHandler
                                                                     
Name:           .seqs_cache         .link_counts        nmask_per_seq
Class:          environment          environment              integer
                                                                     
Name:                 masks             organism          common_name
Class:        RdaCollection            character            character
                                                                     
Name:              provider     provider_version         release_date
Class:            character            character            character
                                                
Name:          release_name              seqinfo
Class:            character              Seqinfo

Extends: "GenomeDescription"

Known Subclasses: "MaskedBSgenome"

# Ex4
# Investigate the a_genome using show()
show(a_genome)

# Result:
Yeast genome:
# organism: Saccharomyces cerevisiae (Yeast)
# provider: UCSC
# provider version: sacCer3
# release date: April 2011
# release name: SGD April 2011 sequence
# 17 sequences:
#   chrI    chrII   chrIII  chrIV   chrV    chrVI   chrVII  chrVIII chrIX  
#   chrX    chrXI   chrXII  chrXIII chrXIV  chrXV   chrXVI  chrM           
# (use 'seqnames()' to see all the sequence names, use the '$' or '[[' operator
# to access a given sequence)

# Investigate some other accesors
organism(a_genome)
# Result:
"Saccharomyces cerevisiae"

provider(a_genome)
#Result:
"UCSC"

seqinfo(a_genome)
# Result:
Seqinfo object with 17 sequences (1 circular) from sacCer3 genome:
  seqnames seqlengths isCircular  genome
  chrI         230218      FALSE sacCer3
  chrII        813184      FALSE sacCer3
  chrIII       316620      FALSE sacCer3
  chrIV       1531933      FALSE sacCer3
  chrV         576874      FALSE sacCer3
  ...             ...        ...     ...
  chrXIII      924431      FALSE sacCer3
  chrXIV       784333      FALSE sacCer3
  chrXV       1091291      FALSE sacCer3
  chrXVI       948066      FALSE sacCer3
  chrM          85779       TRUE sacCer3

  # Sample Guide
  Genome elements
# Genetic information DNA alphabet
# A set of chromosomes(highly variable number)
# Genes(carry heredity instructions)
#   * coding and non-coding
# Proteins(responsible for specific functions)
#   *  DNA-to-RNA(transcription)
#   *  RNA-to-protein(translation)

BSgenome annotation package

# load the package and store data into yeast
library(BSgenome.Scerevisiae.UCSC.sacCer3)
yeast <- BSgenome.Scerevisiae.UCSC.sacCer3
#intrested in other genomes?
available.genomes()

Using accessors

# Chromosome number
length(yeast)
# Chromosome names
names(yeast)
# Sequence lengths
seqlengths(yeast)

Get sequences

S4 method for BSgenome

# S4 method getSeq() requires a BSgenome object
getSeq(yeast)
# Select chrome sequence by name, one or many
getSeq(yeast, "chrM")
# Select start, end and or width
# end = 10, selects first 10 base pairs of each chromosome
getSeq(yeast, end = 10)

# Ex5 a)
# Load the yeast genome
library(BSgenome.Scerevisiae.UCSC.sacCer3)

# Result:
Loading required package: BSgenome
Loading required package: BiocGenerics
Loading required package: parallel

Attaching package: 'BiocGenerics'
The following objects are masked from 'package:parallel':

    clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    clusterExport, clusterMap, parApply, parCapply, parLapply,
    parLapplyLB, parRapply, parSapply, parSapplyLB
The following objects are masked from 'package:stats':

    IQR, mad, sd, var, xtabs
The following objects are masked from 'package:base':

    Filter, Find, Map, Position, Reduce, anyDuplicated, append,
    as.data.frame, cbind, colMeans, colSums, colnames, do.call,
    duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
    lapply, lengths, mapply, match, mget, order, paste, pmax, pmax.int,
    pmin, pmin.int, rank, rbind, rowMeans, rowSums, rownames, sapply,
    setdiff, sort, table, tapply, union, unique, unsplit, which,
    which.max, which.min
Loading required package: S4Vectors
Loading required package: stats4

Attaching package: 'S4Vectors'
The following object is masked from 'package:base':

    expand.grid
Loading required package: IRanges
Loading required package: GenomeInfoDb
Loading required package: GenomicRanges
Loading required package: Biostrings
Loading required package: XVector

Attaching package: 'Biostrings'
The following object is masked from 'package:base':

    strsplit
Loading required package: rtracklayer

# Assign data to the yeastGenome object
yeastGenome <- BSgenome.Scerevisiae.UCSC.sacCer3

# Ex5 b)
# Load the yeast genome
library(BSgenome.Scerevisiae.UCSC.sacCer3)

# Assign data to the yeastGenome object
yeastGenome <- BSgenome.Scerevisiae.UCSC.sacCer3

# Get the head of seqnames and tail of seqlengths for yeastGenome
head(seqnames(yeastGenome))

# Result:
[1] "chrI"   "chrII"  "chrIII" "chrIV"  "chrV"   "chrVI"

tail(seqlengths(yeastGenome))
# Result:
chrXII chrXIII  chrXIV   chrXV  chrXVI    chrM 
1078177  924431  784333 1091291  948066   85779 

# Ex5 c)
# Load the yeast genome
library(BSgenome.Scerevisiae.UCSC.sacCer3)

# Assign data to the yeastGenome object
yeastGenome <- BSgenome.Scerevisiae.UCSC.sacCer3

# Get the head of seqnames and tail of seqlengths for yeastGenome
head(seqnames(yeastGenome))
tail(seqlengths(yeastGenome))

# Print chromosome M, alias chrM
print (yeastGenome$chrM)

# Result:
85779-letter "DNAString" instance
seq: TTCATAATTAATTTTTTATATATATATTATATTATA...TACAGAAATATGCTTAATTATAATATAATATCCATA

# Count characters of the chrM sequence
nchar(yeastGenome$chrM)

# Result:
85779

# Ex 6
# Load the yeast genome
library(BSgenome.Scerevisiae.UCSC.sacCer3)

# Assign data to the yeastGenome object
yeastGenome <- BSgenome.Scerevisiae.UCSC.sacCer3

# Get the first 30 bases of each chromosome
getSeq(yeastGenome, end = 30)

# Result
  A DNAStringSet instance of length 17
     width seq                                              names               
 [1]    30 CCACACCACACCCACACACCCACACACCAC                   chrI
 [2]    30 AAATAGCCCTCATGTACGTCTCCTCCAAGC                   chrII
 [3]    30 CCCACACACCACACCCACACCACACCCACA                   chrIII
 [4]    30 ACACCACACCCACACCACACCCACACACAC                   chrIV
 [5]    30 CGTCTCCTCCAAGCCCTGTTGTCTCTTACC                   chrV
 ...   ... ...
[13]    30 CCACACACACACCACACCCACACCACACCC                   chrXIII
[14]    30 CCGGCTTTCTGACCGAAATTAAAAAAAAAA                   chrXIV
[15]    30 ACACCACACCCACACCACACCCACACCCAC                   chrXV
[16]    30 AAATAGCCCTCATGTACGTCTCCTCCAAGC                   chrXVI
[17]    30 TTCATAATTAATTTTTTATATATATATTAT                   chrM
>