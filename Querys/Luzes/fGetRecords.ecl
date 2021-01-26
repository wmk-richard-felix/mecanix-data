IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modLuzes.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Luzes.fPrepareData(dInputData, 13);
  myModelC := MecanixLT.Luzes.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Luzes.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;