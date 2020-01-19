# -*- coding: utf-8 -*-
"""
Created on Sun Aug 11 21:13:06 2019

@author: hadoop
"""

import pandas as pd
import os
from sklearn.metrics import roc_auc_score


ExperimentTimes = 1
head = ['Procesed instances']

filenamelist = []
semisupervisedlinenamelist = []
Outputfile = []
MAUCfile = pd.DataFrame(data=[],index=[])

def readsemisupervised(path3):
    for line in open(path3):
        line = line[0:-1]
        semisupervisedlinenamelist.append(line)


def calculateAUC(df,i,j):
    dftemp = df.copy()
    dftemp = dftemp[(dftemp[dftemp.columns[0]]==i) | (dftemp[dftemp.columns[0]]==j)]
    y_true = dftemp[dftemp.columns[0]]
    y_true = y_true.replace(i,'a')
    y_true = y_true.replace(j,'b')
    y_true = y_true.replace('a',1)
    y_true = y_true.replace('b',0)
    y_scores = dftemp[dftemp.columns[i+1]]
    AUC = roc_auc_score(y_true, y_scores)
    return AUC


semisupervisedpath = "./semi"
readsemisupervised(semisupervisedpath)
filenamelist = os.listdir('C:\\experiencesLWK\\applieddatasets')
listofallname = semisupervisedlinenamelist

for filename in filenamelist:
    filename = filename[0:-5]
    if (filename=='DEMO'):
        continue
    results_folder = "C:\\experiencesLWK\\output\\ResultsAUC\\"+filename+"\\"
    print(results_folder)

    for semisupervised in semisupervisedlinenamelist:
        print(semisupervised)
        sunMAUC = 0
        for i in range(0,ExperimentTimes):
            df = pd.read_csv(results_folder + semisupervised + str(i) +'.csv',error_bad_lines=False)
            numcol = df.columns.size
            numclass = numcol - 2
            for i in range(0,numcol-1):
                df = df.dropna(subset=[df.columns[i]])
            sumvalue = 0
            for i in range(0,numclass):
                for j in range(i+1,numclass):
                    Aij = calculateAUC(df,i,j)
                    Aji = calculateAUC(df,j,i)
                    sumvalue = sumvalue + (Aij+Aji)/2
            MAUC = sumvalue*2/(numclass*(numclass-1))
            Outputfile.append(MAUC)
            #print(MAUC)   
        #sunMAUC = sunMAUC + MAUC
        
    #sunMAUC = sunMAUC/ExperimentTimes
    #Outputfile.append(sunMAUC,ignore_index=True)
    print(sunMAUC)
    #Outputfile.iloc[[2],[0]] = sunMAUC
    MAUCfile.insert(0,'name',listofallname)
    MAUCfile.insert(1,'MAUC',Outputfile)
    
#Outputfile.to_csv('C:\\experiencesLWK\\output\\\Aalyse\\'+filename+'.csv')
            

