IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modFumaca.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Fumaca.fPrepareData(dInputData, 16);
  myModelC := MecanixLT.Fumaca.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Fumaca.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;