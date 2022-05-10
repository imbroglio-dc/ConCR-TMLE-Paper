try(setwd("~/research/SoftWare/devel-tmle-survival/ConCR-TMLE-Paper/supplement/"), silent = TRUE)
try(setwd("Shared/Projects/ConCR-TMLE-Paper/supplement"), silent = TRUE)
# ---------------------------------------------------------------------
# packages
# ---------------------------------------------------------------------
library(targets)
library(tarchetypes)
thepackages <- c("targets",
                 "future.batchtools",
                 "tarchetypes",
                 "future.callr",
                 "future",
                 "data.table",
                 "riskRegression",
                 "prodlim",
                 "survival",
                 "foreach",
                 "nleqslv",
                 "zoo")
targets::tar_option_set(packages = thepackages)
# ---------------------------------------------------------------------
# R functions
# ---------------------------------------------------------------------
## for(f in list.files("../../ConCR-TMLE/R",".R$",full.names=TRUE)){source(f)}
for(f in list.files("functions",".R$",full.names=TRUE)){source(f)}
# ---------------------------------------------------------------------
# Simulation parameters
# ---------------------------------------------------------------------
# parameters of the simulation setting
data_setting <- tar_target(HYPER,list(
                                     A1_T1 = log(1.5),
                                     A1_T2 = log(1),
                                     A2_T1 = log(0.5),
                                     A2_T2 = log(1),
                                     X1_T1 = log(0.5),
                                     n = 10002,
                                     scale.censored = 1/40,
                                     keep.latent = FALSE))
independent_censoring <- tar_target(INDEPENDENT_CENSORING_SETTING,
                                    list(horizon = 5,
                                         event.times = c("T1","T2"),
                                         treatments = c("A1" = .4,"A2" = .3),
                                         binary.covariates = c("X1" = .1,"X2" = .2,"X3" = .3,"X4" = .4,"X5" = .5),
                                         normal.covariates = paste0("X",6:7),
                                         ## formula.list =  list(T1 ~ f(X1,.3) + f(X2,.7) + f(X3,-.4) + f(X4,.3) + f(X6,-.1),
                                         formula.list =  list(formula(paste("T1 ~ f(X1,",HYPER$X1_T1,") + f(X2,.7) + f(X3,-.4) + f(X4,.3) + f(X6,-.1)")),
                                                              T2  ~ f(X1, -.3)+ f(X2,-.1) + f(X3,.6) + f(X6,.1),
                                                              C ~ f(X1,.3),
                                                              A1 ~ f(X1,.4) + f(X6,.8) + f(X7,.2))))
# ---------------------------------------------------------------------
# testing the lava simulation
# ---------------------------------------------------------------------
test_data <- tar_target(TESTDATA,{
    do.call("simulateData",c(list(setting = INDEPENDENT_CENSORING_SETTING),
                             HYPER))
})
test_fit <- tar_target(FIT,{
    coxph(Surv(time,event == 1)~A1+A2+X1+X2+X3+X4+X6,data = TESTDATA)
})
test_table <- tar_target(TABLE,{
    coef(summary(FIT))
})
compare_test <- tar_target(COMPARISON,{
    cbind(TABLE[,2],c(exp(HYPER$A1_T1),exp(HYPER$A2_T1),exp(HYPER$X1_T1),exp(0),exp(0),exp(0),exp(0)))
})
# ---------------------------------------------------------------------
# the lava simulation
# ---------------------------------------------------------------------
sim_data <- tar_target(SIMDATA,{
    do.call("simulateData",c(list(setting = INDEPENDENT_CENSORING_SETTING),
                             HYPER))},
    pattern = map(REPS)
)
sim_fit <- tar_target(SIMFIT,{
    coxph(Surv(time,event == 1)~A1+A2+X1+X2+X3+X4+X6,data = SIMDATA)},
    iteration = "list",
    pattern = map(SIMDATA))
# ---------------------------------------------------------------------
# target pipe line
# ---------------------------------------------------------------------
list(tar_target(REPS,1:10),
     data_setting,
     independent_censoring,
     test_data,
     test_fit,
     test_table,
     compare_test,
     sim_data,
     sim_fit)
