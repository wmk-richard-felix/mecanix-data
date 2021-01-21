IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modBarulhos.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.modFunctions.fPrepareData(dInputData, 16);
  myModelC := MecanixLT.modTraining.dMyModelC;
  predictedClasses := MecanixLT.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(codigo = uProblema)[1];

END;