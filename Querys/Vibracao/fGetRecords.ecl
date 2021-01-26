IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modVibracao.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Vibracao.fPrepareData(dInputData, 16);
  myModelC := MecanixLT.Vibracao.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Vibracao.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;