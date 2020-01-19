# -*- coding: utf-8 -*-
"""
Created on Sun Aug 11 21:13:06 2019

@author: hadoop
"""

import pandas as pd
import os
from sklearn.metrics import roc_auc_score


path="C:\\\experiencesLWK\\output\\avgMAUC"
path=path.strip()
isExists=os.path.exists(path)
if not isExists:
   os.makedirs(path) 

ExperimentTimes = 10
head = ['Procesed instances']

filenamelist = []
semisupervisedlinenamelist = []
Outputfile = []



def readsemisupervised(path3):
    for line in open(path3):
        line=line.strip()
        if len(line):
            #line = line[0:-1]
            semisupervisedlinenamelist.append(line)

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass

    return False
            
def strTofloat(strE):
    '''
    if is_number(strE):
        return float(strE)
    else:
        return 0.0
    '''
    try:
        return float(strE)         
    except ValueError:
        pass
    return 0.0


def calculateAUC(df,i,j):
    dftemp = df.copy()
    dftemp = dftemp[(dftemp[dftemp.columns[0]]==i) | (dftemp[dftemp.columns[0]]==j)]
    y_true = dftemp[dftemp.columns[0]]
    y_true = y_true.replace(i,'a')
    y_true = y_true.replace(j,'b')
    y_true = y_true.replace('a',1)
    y_true = y_true.replace('b',0)
    y_scores = dftemp[dftemp.columns[i+1]].apply(strTofloat)
    
#    y_scores = y_scores.replace({'E-':'-'},regex=True)
#    y_scores.to_csv('.\y_scores.csv')
    ilen=len(dftemp[(dftemp[dftemp.columns[0]]==i)])
    AUC=0
 #   print('ilen = '+ str(ilen)+ '; numY = ' + str(len(y_true)))

    if ilen == len(y_true) :
        AUC = 1
#        print('AUC = 1')
    elif ilen ==0:
#        print('AUC = 0')
        AUC = 0
    else :
        AUC = roc_auc_score(y_true, y_scores)
#        print(AUC)
    return AUC


semisupervisedpath = "./ExperimentalSetting.ini"
readsemisupervised(semisupervisedpath)

#listofallname = semisupervisedlinenamelist


filenamelist = os.listdir('C:\\experiencesLWK\\applieddatasets')

for filename in filenamelist:
    filename = filename[0:-5]
    if (filename=='DEMO'):
        continue
    results_folder = "C:\\experiencesLWK\\output\\ResultsAUC\\"+filename+"\\"
    print(results_folder)
    dlapplied = os.listdir(results_folder)
    if( len(dlapplied)==0):
        continue
    
    Outputfile = []
    for semisupervised in semisupervisedlinenamelist:
        print(semisupervised)
        sumMAUC = 0
        numExp=0
        for i in range(1,ExperimentTimes+1):
            df = pd.read_csv(results_folder + semisupervised +'s'+ str(i) +'.csv',error_bad_lines=False)
            numcol = df.columns.size
            numclass = numcol - 1
            df = df.replace('Infinity','NaN')
            #for i in range(0,numcol-1):
            #    df = df.dropna(subset=[df.columns[i]])
            df = df.dropna()
            numrow=len(df)
            if(numrow==0):
                continue
            numExp = numExp+1
            
            sumvalue = 0
            for i in range(0,numclass):
                for j in range(i+1,numclass):
                    Aij = calculateAUC(df,i,j)
                    Aji = calculateAUC(df,j,i)
                    sumvalue = sumvalue + (Aij+Aji)/2
            MAUC = sumvalue*2/(numclass*(numclass-1))
            #print(MAUC)   
            sumMAUC = sumMAUC + MAUC
        if(numExp):
            sumMAUC = sumMAUC/numExp*100
        else:
            sumMAUC=0
        Outputfile.append(sumMAUC)
    
    MAUCfile = pd.DataFrame(data=[],index=[])
    MAUCfile.insert(0,'name',semisupervisedlinenamelist)
    MAUCfile.insert(1,'avgMAUC',Outputfile)
    
    MAUCfile.to_csv('C:\\experiencesLWK\\output\\avgMAUC\\'+filename+'.csv')
            

