# map_conservation_score

## Scripts to map conservation scores (phylop/phastcons) to the region of your interest

The scores can be mapped using bash (by bedops) or by using Annotation Packages in R .


### I. Using bedops

The conservation scores can be mapped to the regions of interest in 2 ways:
(1) (i) convert bigWigfix files to compressed bed form called 'starch' using wig2starch
    (ii) map the score per chromosome using bedmap 
To map the phastcons/phylop score to the region of interest with bedops, the wigFix (the fixed width wig files from UCSC) need to be converted to a bed format. starch is compressed form of bed.
    
(2) (i) Chop the regions of interest (from bed file) into 1bp interval using bedops with -chop 1 option. 
    (ii) Extracting the phastcon scores corresponding to the regions using ex (extract) command of bwtool from the corresponding bigWig files.

The second method is detailed in https://github.com/shraddhapuntambekar/learning_conservation_analysis_using_phylop/blob/master/2_mapping_scores_on_features_using_bedops.sh.

The following steps illustrate the first method of mapping scores from the downloaded wigFix files directly to roi. 
1. The first step is to convert Wigfix files to a compressed bed form called 'starch' using wig2starch (a bedops function).
		Run convert_wigFix_to_starch.sh script only once

2. In the next step the scores are mapped to the region of interest using bedmap. The scores are mapped over all the chromosomes (scaffolds) in the bed file. The unmapped bases are skipped for calulcating the mean and standard devaition of the score over the region of interest. The per chromosome files are aggregated to give a final file with mean and stddev score.
		Run map_conservation_scores.sh on the bed files which have your regions of interest.
    

### II. Rscript



## Links to download the conservation scores for hg38 

- From UCSC: https://hgdownload.cse.ucsc.edu/goldenpath/hg38/
		- Phastcons - 100 way: https://hgdownload.cse.ucsc.edu/goldenpath/hg38/phastCons100way/
		- Phylop - 100 way:    http://hgdownload.cse.ucsc.edu/goldenPath/hg38/phyloP100way/
- From Bioconductor
		- https://bioconductor.org/packages/3.19/data/annotation/html/phastCons100way.UCSC.hg38.html
		
		
## Installation of required tools

(1) bedops : Ref: https://bedops.readthedocs.io/en/latest/content/installation.html#linux

		wget https://github.com/bedops/bedops/releases/download/v2.4.41/bedops_linux_x86_64-v2.4.41.tar.bz2
		tar jxvf bedops_linux_x86_64-v2.4.41.tar.bz2	
		mkdir bedops
		mv bin bedops/bin
		sudo cp bedops/bin/* /usr/local/bin

In case you do not have root access, copy the files to your environment's path. 
You can check your path variable using echo $PATH.

		
