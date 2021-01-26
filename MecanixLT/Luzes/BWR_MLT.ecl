IMPORT LearningTrees, MDL, ML_Core, MecanixLT;

OUTPUT(MecanixLT.Luzes.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.Luzes.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.Luzes.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.Luzes.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.Luzes.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.Luzes.modTraining.assessmentC, NAMED('assessmentC'));