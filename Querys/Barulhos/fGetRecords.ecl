IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modBarulhos.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Barulhos.fPrepareData(dInputData, 16);
  myModelC := MecanixLT.Barulhos.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Barulhos.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;