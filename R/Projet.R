#######################################################################
#############      PROJET APPENDICULARIA        #######################
#######################################################################

appendiculaire <- read.csv("appendicularia.csv")
set.seed(2)

#### Exploration des donnees
hist(appendiculaire$appendicularia, breaks=20,
xlab = "Abondance d'Appendiculaires" ,
ylab = "Frequence",
main = "Histogramme des Appendiculaires")

sqrt_app <- sqrt(appendiculaire$appendicularia)
hist(sqrt_app, breaks=20,
     xlab = "Abondance d'Appendiculaires" ,
     ylab = "Frequence",
     main = "Histogramme des Appendiculaires")

log_app <- log(appendiculaire$appendicularia)
hist(log_app, breaks=20,
     xlab = "Abondance d'Appendiculaires" ,
     ylab = "Frequence",
     main = "Histogramme des Appendiculaires")

log10_app <- log10(appendiculaire$appendicularia)
hist(log10_app, breaks=20,
     xlab = "Abondance d'Appendiculaires" ,
     ylab = "Frequence",
     main = "Histogramme des Appendiculaires")

app <- appendiculaire
app$appendicularia <- log10_app



#### ACP
env <- subset(appendiculaire, select=-appendicularia)
# perform the PCA on the scaled data (because the variables have different units and are not comparable as such)
env_pca <- prcomp(env, scale=TRUE)
summary(env_pca)
plot(env_pca)
biplot(env_pca)



#### ARBRE
library("gbm")

mg <- gbm(appendicularia ~ ., data=app, distribution="gaussian",
          cv.folds=5, n.cores=1)
gbm.perf(mg)

mg <- gbm(appendicularia ~ ., data=app, distribution="gaussian",
          cv.folds=5, n.trees=5000, shrinkage=0.01,
          interaction.depth=4, bag.fraction=0.5,
          n.cores=1)

best <- gbm.perf(mg) # On garde nombre d'arbre a 400
best

summary(mg, n.trees=best)
# -> The most influential variables are fluorimetry, distance, temperature and chloroMax.

plot(mg, i.var="fluorimetry", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="distance", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="temperature", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="chloroMax", n.trees=best, ylab = "Abondance d'Appendiculaires")

plot(appendicularia ~ fluorimetry, data=app)
g1 <- plot(mg, i.var="fluorimetry", n.trees=best, return.grid=TRUE)
lines(y ~ fluorimetry, data=g1, col="red", lwd=2)

plot(appendicularia ~ distance, data=app)
g2 <- plot(mg, i.var="distance", n.trees=best, return.grid=TRUE)
lines(y ~ distance, data=g2, col="red", lwd=2)

plot(appendicularia ~ temperature, data=app)
g3 <- plot(mg, i.var="temperature", n.trees=best, return.grid=TRUE)
lines(y ~ temperature, data=g3, col="red", lwd=2)

plot(appendicularia ~ chloroMax, data=app)
g4 <- plot(mg, i.var="chloroMax", n.trees=best, return.grid=TRUE)
lines(y ~ chloroMax, data=g4, col="red", lwd=2)

# predict fitted values
app_pred_gbm <- predict(mg, n.trees=best)

# compare the two graphically
plot(x=app$appendicularia, y=app_pred_gbm, asp=1, xlab = "Donnees", ylab = "Predictions")
abline(a=0, b=1, col="red")

# evaluate performance
library(MLmetrics)
MSE(app_pred_gbm, app$appendicularia)           #0.02009255
RMSE(app_pred_gbm, app$appendicularia)          #0.1417482
MAE(app_pred_gbm, app$appendicularia)           #0.1152549
R2_Score(app_pred_gbm, app$appendicularia)      #0.7479362

# 2D Dependance partial plot
library(pdp)
pd <- partial(mg, n.trees=best, pred.var = c("fluorimetry", "distance"))
pdp1 <- plotPartial(pd)
pdp1

#### Selection des donnees correlees
library(corrplot)
cor_appendiculaire <- cor(appendiculaire)
corrplot(cor_appendiculaire , method="circle")

library(dplyr)
app_reduite <- select(app, c(appendicularia, thermocline, chloroMax, temperature,
                                density, fluorimetry, distance, currentSpeed))
env_reduite <- subset(app_reduite, select=-appendicularia)



#### ACP
# perform the PCA on the scaled data (because the variables have different units and are not comparable as such)
app_reduite_pca <- prcomp(env_reduite, scale=TRUE)
summary(app_reduite_pca)
plot(app_reduite_pca)
biplot(app_reduite_pca)


#### Arbre
set.seed(2)
mg <- gbm(appendicularia ~ ., data=app_reduite, distribution="gaussian",
          cv.folds=5, n.cores=1)
gbm.perf(mg)

mg <- gbm(appendicularia ~ ., data=app_reduite, distribution="gaussian",
          cv.folds=5, n.trees=10000, shrinkage=0.01,
          interaction.depth=4, bag.fraction=0.5,
          n.cores=1)

best <- gbm.perf(mg) # On garde nombre d'arbre a 283
best

summary(mg, n.trees=best)
# -> The most influential variables are fluorimetry, distance, temperature and chloroMax.

plot(mg, i.var="fluorimetry", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="distance", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="temperature", n.trees=best, ylab = "Abondance d'Appendiculaires")
plot(mg, i.var="chloroMax", n.trees=best, ylab = "Abondance d'Appendiculaires")


# predict fitted values
app_pred_gbm <- predict(mg, n.trees=best)

# compare the two graphically
plot(x=app$appendicularia, y=app_pred_gbm, asp=1, xlab = "Donnees", ylab = "Predictions")
abline(a=0, b=1, col="red")

# evaluate performance
MSE(app_pred_gbm, app$appendicularia)           #0.03818792
RMSE(app_pred_gbm, app$appendicularia)          #0.1954173
MAE(app_pred_gbm, app$appendicularia)           #0.1550477
R2_Score(app_pred_gbm, app$appendicularia)      #0.5209273

