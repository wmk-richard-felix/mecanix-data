IMPORT MDL, MecanixLT;

dInputTest := MDL.modBarulhos.kData_rid(rid=129);
dPrepData := MecanixLT.modFunctions.fPrepareData(dInputTest, 16);
myModelC := MecanixLT.modTraining.dMyModelC;
predictedClasses := MecanixLT.modTraining.myLearnerC.Classify(myModelC, dPrepData);
uProblema := predictedClasses[1].value;

MDL.modProblemas.dData()(codigo = uProblema)[1];