RNGkind(sample.kind="Rounding")
library(bhpm)
set.seed(3006)
######################### All events, Severity 1, Model 1a_independent #####################
print("######################### All events, Severity 1, Model 1a_independent #####################")
data(demo.cluster.data)
s.p = bhpm.sim.control.params(demo.cluster.data)
s.p = s.p[s.p$Outcome.Grp == "I00-I99" & s.p$Outcome == "I00-99_Outcome1", ]
s.p$value = 2
s.p$control = 7
raw = bhpm.npm(demo.cluster.data, sim.params = s.p)
conv = bhpm.convergence.diag(raw)
sink("conv.dat")
bhpm.print.convergence.summary(conv)
sink()
rm(conv)
gc()
summ = bhpm.summary.stats(raw)
sink("summary.dat")
bhpm.print.summary.stats(summ)
sink()

print("Removing objects...")
rm(summ)
gc()
ptheta = bhpm.ptheta(raw)
print("Removing objects...")
rm(raw)
gc()
print("Writing the ptheta probabilities....")
write.table(ptheta, "ptheta.dat")
ptheta95 = ptheta[ptheta$ptheta > 0.95,] 
write.table(ptheta95, "ptheta95.dat")
print("Removing objects...")
#rm(conv)
rm(ptheta)
rm(ptheta95)
gc()
print("Finished.")

warnings()
