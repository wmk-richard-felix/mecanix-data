IMPORT LearningTrees, MDL, ML_Core, MecanixLT;

OUTPUT(MecanixLT.Partida.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.Partida.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.Partida.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.Partida.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.Partida.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.Partida.modTraining.assessmentC, NAMED('assessmentC'));