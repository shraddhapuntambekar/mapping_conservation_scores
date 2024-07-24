#!/bin/sh

## map_conservation_scores.sh - Code to map Phastcon/Phylop scores to the regions of interest  
## 
## USAGE: sh map_phastcons.sh /input/bed/file /path/to/out/folder  /path/to/starch/files 
##        sh map_phastcons.sh /home/shraddha/TF/TF1.homer.peak.bed  /home/shraddha/TF/scores/phastCons  /home/shraddha/scoreStarch/phastCons/hg38
##
## OUTPUT: bed file having mean and SD scores per peak region.

inputbedwithpath="$1"    # input bed file
outpath="$2"     # folder location to save the output
scoresfolder="$3" #folder with the phastcons starch files

#sample=$(basename -s -idrconspeaks.200bpSummit.hg38.bed "$inputbedwithpath")
sample=$(basename "$inputbedwithpath")

cd $outpath
mkdir ${outpath}/out_${sample}
mkdir ${outpath}/out_${sample}/perchr

# Mapping the (phastcon/phylops) scores from per chromosome starch files to the regions of interest using bedmap
sort-bed $inputbedwithpath > ${outpath}/out_${sample}/sorted_${sample}

for i in `awk -F "\t" '{print $1}' $inputbedwithpath | sort | uniq | tr "\n" "\t"` ;
do
	echo "mapping signal for ${i}";
	conFile="${scoresfolder}/${i}.phastCons100way.starch";       
	bedmap --skip-unmapped --echo --mean --stdev --chrom $i ${outpath}/out_${sample}/sorted_${sample} $conFile > ${outpath}/out_${sample}/perchr/mean_sd_phastcon.${i}.${sample};
done

# Aggregating the per-chromosome maps to a single file
bedops --everything  ${outpath}/out_${sample}/perchr/mean_sd_phastcon.* > ${outpath}/out_${sample}/mean_sd_phastcon_${sample}

