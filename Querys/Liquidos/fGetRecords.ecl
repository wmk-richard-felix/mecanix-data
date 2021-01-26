IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modLiquidos.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Liquidos.fPrepareData(dInputData, 16);
  myModelC := MecanixLT.Liquidos.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Liquidos.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;