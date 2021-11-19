import csv
import re
import pandas as pd
import numpy as np

kernels = ["CalcKinematicsForElems","CalcPressureForElems", "CalcEnergyForElems", "EvalEOSForElems", "CalcMonotonicQRegionForElems", "CalcHourglassControlForElems",  "CalcHydroConstraintForElems", "CalcFBHourglassForceForElems", "CalcCourantConstraintForElems", "CalcSoundSpeedForElems", "EvalEOSForElemsEP6Domain", "IntegrateStressForElems", "UpdateVolumesForElems", "CalcMonotonicQGradientsForElems","CalcQForElemsEP6Domain", "InitStressTermsForElems" ,"CalcForceForNodesEP6Domain", "CalcVelocityForNodesEP6Domain","CalcLagrangeElements", "ApplyMaterialPropertiesForElems" ,"CalcVolumeForceForElems","CalcAccelerationForNodes", "CalcPositionForNodes", "ApplyAccelerationBoundaryConditionsForNodes" ]

df1 = pd.read_csv("./kernel-level-measurement/lassen-log/kernel-data-best.csv")
df2 = pd.read_csv("./mergedDataSet.csv")

df2['label'] = "" 

for index, row in df2.iterrows():
    kernel = row['Kernel']
    InputData = row['InputData']
    Data = row['Data'] 
    DataID = row['DataID'] 
    #print(kernel, InputData, Data, DataID)
    for p in kernels:
      if re.search(p,kernel):
        bestData = df1[(df1['kernel'] == p) & (df1['InputData'] == InputData)]
        advise = 'advise'+str(DataID)  
        #print(advise, bestData[advise].values[0])
        df2.iloc[index,df2.columns.get_loc('label')] = bestData[advise].values[0]
        df2.iloc[index,df2.columns.get_loc('Kernel')] = p
df3 = df2
df3.to_csv("labelledData.csv",index=False)
