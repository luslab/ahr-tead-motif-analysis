#!/bin/bash

# Sort chip peaks
bedtools sort -i source/ahr_chip.bed > ahr_chip.sorted.bed

# Subset ATAC regions from deseq report
awk -v OFS="\t" '(NR>1) {print "chr"$3,$4,$5,$2,$9}' source/AhRKO_DiffvsWT_Diff.deseq2.FDR0.05.results.annotated.txt > ahr_tobais_atac.bed

# Subset ATAC region from deseq with annotation
awk -v OFS="\t" '(NR>1) {print "chr"$3,$4,$5,$2,$9,$30,$(NF-8),$(NF-7),$(NF-6),$(NF-3)}' source/AhRKO_DiffvsWT_Diff.deseq2.FDR0.05.results.annotated.txt > ahr_tobais_atac_annotated.bed

# Intersect ATAC regions with chip peaks
bedtools intersect -wo -a ahr_tobais_atac.bed -b ahr_chip.sorted.bed > ahr_atac_chip_intersect.bed

# Find the opposite ATAC regions with no chip peaks
bedtools intersect -wo -v -a ahr_tobais_atac.bed -b ahr_chip.sorted.bed > ahr_atac_chip_nointersect.bed

# Sort the resulting bed files
bedtools sort -i ahr_atac_chip_intersect.bed > ahr_atac_chip_intersect.sorted.bed
bedtools sort -i ahr_atac_chip_nointersect.bed > ahr_atac_chip_nointersect.sorted.bed

# Subset the tobias motifs for each target motif
awk -v OFS="\t" '(NR>1) {print "chr"$1,$2,$3,"chr"$1":"$2"-"$3,$25}' bindetectPlots/_AhrArnt_MA0006.1/_AhrArnt_MA0006.1_overview.txt > motifs_ahr.bed
awk -v OFS="\t" '(NR>1) {print "chr"$1,$2,$3,"chr"$1":"$2"-"$3,$25}' bindetectPlots/_TEAD1_MA0090.2/_TEAD1_MA0090.2_overview.txt > motifs_tead1.bed
awk -v OFS="\t" '(NR>1) {print "chr"$1,$2,$3,"chr"$1":"$2"-"$3,$25}' bindetectPlots/_TEAD2_MA1121.1/_TEAD2_MA1121.1_overview.txt > motifs_tead2.bed
awk -v OFS="\t" '(NR>1) {print "chr"$1,$2,$3,"chr"$1":"$2"-"$3,$25}' bindetectPlots/_TEAD3_MA0808.1/_TEAD3_MA0808.1_overview.txt > motifs_tead3.bed
awk -v OFS="\t" '(NR>1) {print "chr"$1,$2,$3,"chr"$1":"$2"-"$3,$25}' bindetectPlots/_TEAD4_MA0809.1/_TEAD4_MA0809.1_overview.txt > motifs_tead4.bed

# Intersect with motifs that are 100% within subsetted ATAC regions
bedtools intersect -f 1 -wb -a motifs_ahr.bed -b ahr_atac_chip_intersect.sorted.bed > motif_ahr_atac_intersect.bed
bedtools intersect -f 1 -wb -a motifs_tead1.bed -b ahr_atac_chip_intersect.sorted.bed > motif_tead1_atac_intersect.bed
bedtools intersect -f 1 -wb -a motifs_tead2.bed -b ahr_atac_chip_intersect.sorted.bed > motif_tead2_atac_intersect.bed
bedtools intersect -f 1 -wb -a motifs_tead3.bed -b ahr_atac_chip_intersect.sorted.bed > motif_tead3_atac_intersect.bed
bedtools intersect -f 1 -wb -a motifs_tead4.bed -b ahr_atac_chip_intersect.sorted.bed > motif_tead4_atac_intersect.bed

# Intersect with motifs that are 100% within subsetted ATAC regions with no AHR
bedtools intersect -f 1 -wb -a motifs_ahr.bed -b ahr_atac_chip_nointersect.sorted.bed > motif_ahr_atac_nointersect.bed
bedtools intersect -f 1 -wb -a motifs_tead1.bed -b ahr_atac_chip_nointersect.sorted.bed > motif_tead1_atac_nointersect.bed
bedtools intersect -f 1 -wb -a motifs_tead2.bed -b ahr_atac_chip_nointersect.sorted.bed > motif_tead2_atac_nointersect.bed
bedtools intersect -f 1 -wb -a motifs_tead3.bed -b ahr_atac_chip_nointersect.sorted.bed > motif_tead3_atac_nointersect.bed
bedtools intersect -f 1 -wb -a motifs_tead4.bed -b ahr_atac_chip_nointersect.sorted.bed > motif_tead4_atac_nointersect.bed