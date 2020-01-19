
rem C5D1_FixedImb_S 5/4/3/2/1,  old name is C5ImbSudden.arff, new name is C5D1_FixedImb_S.arff, abbreviation name is FI_S.arff
rem *** Sudden Drift with Fixed Imbalance Ratio 5/4/3/2/1
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ImbalancedStream -s (ConceptDriftStreams -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -d (generators.RandomRBFGenerator -c 5 -a 21) -p 50000 -w 1) -c 0.3333;0.2667;0.2;0.1333;0.0667) -f .\C5D1_FixedImb_S.arff -m 100000

rem C5D1_VarImb_S 5/4/3/2/1 -> 5/1/2/2/5,   name is C5D1_VarImb_S.arff, abbreviation name is VI_S.arff
rem *** Sudden Drift with Var Imbalance Ratio 5/4/3/2/1 -> 5/1/2/2/5
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -d (ImbalancedStream -s (generators.RandomRBFGenerator -c 5 -a 21) -c 0.3333;0.0668;0.1333;0.1333;0.3333) -p 50000 -w 1) -f .\C5D1_VarImb_S.arff -m 100000

rem C5D1_FixedImb_G  5/1/2/2/5,   old name is C5ImbGradual.arff, new name is C5D1_FixedImb_G.arff, abbreviation name is FI_G.arff
rem *** Gradual Drift with Fixed Imbalance Ratio 5/1/2/2/5
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ImbalancedStream -s (ConceptDriftStreams -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -d (generators.RandomRBFGenerator -c 5 -a 21) -p 50000 -w 5000) -c 0.3333;0.0668;0.1333;0.1333;0.3333) -f .\C5D1_FixedImb_G.arff -m 100000

rem C5D1_VarImb_G 5/1/2/2/5 -> 5/4/3/2/1,   name is C5D1_VarImb_G.arff, abbreviation name is VI_G.arff
rem *** Gradual Drift with Var Imbalance Ratio 5/1/2/2/5 -> 5/4/3/2/1
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.3333;0.0668;0.1333;0.1333;0.3333) -d (ImbalancedStream -s (generators.RandomRBFGenerator -c 5 -a 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -p 50000 -w 5000) -f .\C5D1_VarImb_G.arff -m 100000


rem C5D1_VarImb_VirS 5/4/3/2/1 -> 1/2/3/4/5, name is C5D1_VarImb_VirS.arff, abbreviation name is VI_VS.arff
rem  *** Virtual Sudden Drift with Var Imbalance Ratio 5/4/3/2/1 -> 1/2/3/4/5
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -d (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.0667;0.1333;0.2;0.2667;0.3333) -p 50000 -w 1) -f .\C5D1_VarImb_VirS.arff -m 100000

rem C5D2_VarImb_S_VirG  5/4/3/2/1 S -> 5/4/3/2/1 VG -> 1/2/3/4/5, old name is C5ImbSGV.arff, new name is C5D2_VarImb_S_VirG.arff, abbreviation name is VI_S_VG.arff
rem  *** Sudden Drift Stream with Fixed Imbalance Ratio 5/4/3/2/1, then Virtual Gradual Drift  5/4/3/2/1 -> 1/2/3/4/5
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomRBFGenerator -c 5 -a 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -d (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -d (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.0667;0.1333;0.2;0.2667;0.3333) -p 33333 -w 3333) -p 33333 -w 1) -f .\C5D2_VarImb_S_VirG.arff -m 100000

rem C5D3_VarImb_SGR 5/4/3/2/1 -> 5/1/2/2/5 -> 1/2/3/4/5 -> 5/1/2/2/5, name is C5D3_VarImb_SGR.arff, abbreviation name is VI_SGR.arff
rem *** Sudden Drift with Var Imbalance Ratio 5/4/3/2/1  -> 5/1/2/2/5,
rem then Gradual Drift with Var Imbalance Ratio  5/1/2/2/5 -> 1/2/3/4/5,
rem last Recurrent Sudden Drift with Var Imbalance Ratio  1/2/3/4/5  -> 5/1/2/2/5
java -cp C:\experiencesLWK\MOA\moa.jar -javaagent:C:\experiencesLWK\MOA\sizeofag-1.0.0.jar moa.DoTask WriteStreamToARFFFile -s (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.3333;0.2667;0.2;0.1333;0.0667) -d (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomRBFGenerator -c 5 -a 21) -c 0.3333;0.0668;0.1333;0.1333;0.3333) -d (ConceptDriftStream -s (ImbalancedStream -s (generators.RandomTreeGenerator -c 5 -o 0 -u 21) -c 0.0667;0.1333;0.2;0.2667;0.3333) -d (ImbalancedStream -s (generators.RandomRBFGenerator -c 5 -a 21) -c 0.3333;0.0668;0.1333;0.1333;0.3333) -p 25000 -w 1) -p 25000 -w 2500) -p 25000 -w 1) -f .\C5D3_VarImb_SGR.arff -m 100000

pause