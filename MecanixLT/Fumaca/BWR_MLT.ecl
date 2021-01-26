IMPORT LearningTrees, MDL, ML_Core, MecanixLT;

OUTPUT(MecanixLT.Fumaca.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.Fumaca.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.Fumaca.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.Fumaca.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.Fumaca.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.Fumaca.modTraining.assessmentC, NAMED('assessmentC'));