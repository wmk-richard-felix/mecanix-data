IMPORT MecanixLT;
IMPORT ML_Core.Discretize;
IMPORT ML_Core;
IMPORT LearningTrees AS LT;

dMyDepTrainData := MecanixLT.Vibracao.modConvertData.dMyDepTrainDataNF;
dMyDepTestData  := MecanixLT.Vibracao.modConvertData.dMyIndTestDataNF;
dMyIndTrainData := MecanixLT.Vibracao.modConvertData.dMyIndTrainDataNF;
dMyIndTestData  := MecanixLT.Vibracao.modConvertData.dMyIndTestDataNF;
dMyDepTrainDataDF := Discretize.ByRounding(dMyDepTrainData);
dMyDepTestDataDF  := Discretize.ByRounding(dMyDepTestData);

EXPORT modTraining := MODULE

  EXPORT myLearnerC := LT.ClassificationForest(10,,10);
  EXPORT dMyModelC := myLearnerC.GetModel(dMyIndTrainData, dMyDepTrainDataDF); 
  // Notice second param uses the DiscreteField dataset
  EXPORT predictedClasses := myLearnerC.Classify(dMyModelC, dMyIndTestData);
  EXPORT assessmentC := ML_Core.Analysis.Classification.Accuracy(predictedClasses, dMyDepTestDataDF); 

END;