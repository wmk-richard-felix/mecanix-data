IMPORT LearningTrees, MDL, ML_Core, MecanixLT;

OUTPUT(MecanixLT.Sample.modConvertData.dMyIndTrainDataNF, NAMED('dMyIndTrainDataNF'));
OUTPUT(MecanixLT.Sample.modConvertData.dMyDepTrainDataNF, NAMED('dMyDepTrainDataNF'));

OUTPUT(MecanixLT.Sample.modConvertData.dMyIndTestDataNF, NAMED('dMyIndTestDataNF'));
OUTPUT(MecanixLT.Sample.modConvertData.dMyDepTestDataNF, NAMED('dMyDepTestDataNF'));

OUTPUT(MecanixLT.Sample.modTraining.predictedClasses, NAMED('predictedClasses'));
OUTPUT(MecanixLT.Sample.modTraining.assessmentC, NAMED('assessmentC'));