#!/bin/sh

## convert_wigFix_to_starch.sh - Code to convert wigFix files to starch files using wig2starch function from bedops.
## Run the code only once on Phastcons/Phylops wigFix files. 
## Make sure all the bedops binaries are available from your environment PATH \. 
## Ref for bedops/wig2starch: https://bedops.readthedocs.io/en/latest/content/reference/file-management/conversion/wig2bed.html?highlight=wig2starch
##
## Usage: sh convert_wigFix_to_starch.sh /path/to/folder/with/wigFix/files /path/to/folder/to/savethe/starchFiles  nG
##    eg: sh convert_wigFix_to_starch.sh /data/hg19/hg19.100way.phastCons /home/shraddha/scoreStarch/phastCons/hg19 8G   
#         sh convert_wigFix_to_starch.sh /data/shraddha/phastcons/hg38/phastCons100way/hg38.100way.phastCons /data/shraddha/phastcons/hg38/phastCons100wayStarch 8G
## 

infolder="$1"  # Folder location having wigFix files
outpath="$2"   # Folder location where you want to store the starch files
maxmem="$3"    # option to limiting the memory usage for sorting 

cd $infolder

for i in `ls ${infolder}/*.wigFix.gz`
do
echo "mapping signal for ${i}";
fname=`basename -s .wigFix.gz $i`
gzip -c -d $i > ${infolder}/${fname}.wigFix
wig2starch --max-mem $maxmem < ${infolder}/${fname}.wigFix  > ${outpath}/${fname}.starch
rm ${infolder}/${fname}.wigFix
done



