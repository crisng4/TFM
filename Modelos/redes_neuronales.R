library(sas7bdat)
library(dummies)
library(MASS)
library(reshape)
library(caret)
library(dplyr)
library(pROC)
library(readr)
library(haven)
library(stringr)
install.packages('readr', dependencies = TRUE)
install.packages("e1071")

file<-read.sas7bdat("c:/Users/cris/Documents/TFM/variables_transformadas_train.sas7bdat")

#####REDES NEURONALES

listamodelos_rn<-NULL
listamodelos2_rn<-NULL
listam_rn<-NULL
tabla_modelos_rn<-data.frame() 

i<-1
size_<-c(5,10,15,20)
decay_<-c(0.001,0.01,0.1)
for (s in size_){
  for (d in decay_){
    modelo<-cruzadaavnnet(data=file,vardep=vardep,listconti=conti,
                          listclass=categor,
                          grupos=grupos,sinicio=sinicio,repe=repe,
                          size=s,decay=d,repeticiones=10,itera=100)
    listamodelos_rn<-paste(c(listamodelos_rn,paste0("modelo_rn",i)), collapse =",")
    listamodelos2_rn<-paste(c(listamodelos2_rn,paste0("modelo_rn",i,"bis")), collapse =",")
    assign(paste0("modelo_rn",i,"bis"),modelo)
    listam_rn<-c(listam_rn,paste0("modelo",i))
    eval(parse(text=paste0("modelo_rn", i, "bis <- as.data.frame(modelo[1])")))
    eval(parse(text=paste0("modelo_rn", i, "bis$modelo <- i")))
    eval(parse(text=paste0("tabla_modelos_rn[",i,",1] <- s")))
    eval(parse(text=paste0("tabla_modelos_rn[",i,",2] <- d")))
    i<-i+1
    print(i)
    modelo<-NULL
  }
}

listam_rn
listamodelos2_rn
tabla_modelos_rn
row.names(tabla_modelos_rn)<-listam_rn
names(tabla_modelos_rn)<-c('Nodos', 'Decay')
tabla_modelos_rn
eval(parse(text=paste0("union_rn <- rbind(",listamodelos2_rn,")")))
union_rn$modelo <- with(union_rn,
                        reorder(modelo,error, mean))
par(cex.axis=0.5)
boxplot(data=union_rn,error~modelo,main="MSE Redes neuronales")


i<-1
for (k in listamodels){
  parametros<-paste0(tabla_modelos_rn[i,1],"_",tabla_modelos_rn[i,2])
  print(parametros)
  eval(parse(text=paste0(k,"$modelo <- parametros")))
  print(k)
  print(i)
  i<-i+1
}


par(cex.axis=0.5)
boxplot(data=union_rn2,error~modelo,main="MSE Redes neuronales menos MSE")

par(cex.axis=0.5)
boxplot(data=union_rn3,error~modelo,main="MSE Redes neuronales")

listamodelos2_rn2<-c("modelo_rn4bis,modelo_rn5bis,modelo_rn6bis,modelo_rn7bis,modelo_rn8bis,modelo_rn9bis")
eval(parse(text=paste0("union_rn2 <- rbind(",listamodelos2_rn2,")")))