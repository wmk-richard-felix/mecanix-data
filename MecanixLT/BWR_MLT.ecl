IMPORT LearningTrees, MDL, ML_Core, MLT;

OUTPUT(MecanixLT.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.modTraining.assessmentC, NAMED('assessmentC'));