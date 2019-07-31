library("piano")
setwd(dirname(parent.frame(2)$ofile))

genes2geneSets = read.table(file = "GSC-recon.txt", header = F, sep = ' ')
gsc = loadGSC(genes2geneSets)

# val_S_Cales

gss = read.table(file = "GSS-recon.txt", header = T, sep = ' ')
pval = gss$Var3
pval=as.numeric(pval)
names(pval) = gss$Var1

fc = gss$Var2
names(fc) = gss$Var1

gsaRes = runGSA(pval, gsc = gsc, directions = fc, geneSetStat="stouffer")
# save(gsaRes, file = 'gsaRes.RData')

# GSAsummaryTable(gsaRes, save=TRUE, file="gsaResTab.xls")
gsaRes = GSAsummaryTable(gsaRes)
# length(which(gsaRes$`p adj (dist.dir.up)` < 0.05))
# length(which(gsaRes$`p adj (dist.dir.dn)` < 0.05))
# up = gsaRes[which(gsaRes$`p adj (dist.dir.up)` < 0.05),1:7]
# dn = gsaRes[which(gsaRes$`p adj (dist.dir.dn)` < 0.05),1:7]

