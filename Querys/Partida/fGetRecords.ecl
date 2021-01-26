IMPORT MDL, MecanixLT;

EXPORT fGetRecords(DATASET(MDL.modPartida.lLayoutKey) dInputData) := FUNCTION

  dPrepData := MecanixLT.Partida.fPrepareData(dInputData, 11);
  myModelC := MecanixLT.Partida.modTraining.dMyModelC;
  predictedClasses := MecanixLT.Partida.modTraining.myLearnerC.Classify(myModelC, dPrepData);
  uProblema := predictedClasses[1].value;

  RETURN MDL.modProblemas.dData()(rid = uProblema)[1];

END;