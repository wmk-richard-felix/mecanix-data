IMPORT LearningTrees, MDL, ML_Core, MecanixLT;

OUTPUT(MecanixLT.Barulhos.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.Barulhos.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.Barulhos.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.Barulhos.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.Barulhos.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.Barulhos.modTraining.assessmentC, NAMED('assessmentC'));