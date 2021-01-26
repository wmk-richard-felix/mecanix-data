IMPORT MecanixLT;
IMPORT ML_Core.Discretize;
IMPORT ML_Core;
IMPORT LearningTrees AS LT;

dMyDepTrainData := MecanixLT.Barulhos.modConvertData.dMyDepTrainDataNF;
dMyDepTestData  := MecanixLT.Barulhos.modConvertData.dMyIndTestDataNF;
dMyIndTrainData := MecanixLT.Barulhos.modConvertData.dMyIndTrainDataNF;
dMyIndTestData  := MecanixLT.Barulhos.modConvertData.dMyIndTestDataNF;
dMyDepTrainDataDF := Discretize.ByRounding(dMyDepTrainData);
dMyDepTestDataDF  := Discretize.ByRounding(dMyDepTestData);

EXPORT modTraining := MODULE

  EXPORT myLearnerC := LT.ClassificationForest(10,,10);
  EXPORT dMyModelC := myLearnerC.GetModel(dMyIndTrainData, dMyDepTrainDataDF); 
  // Notice second param uses the DiscreteField dataset
  EXPORT predictedClasses := myLearnerC.Classify(dMyModelC, dMyIndTestData);
  EXPORT assessmentC := ML_Core.Analysis.Classification.Accuracy(predictedClasses, dMyDepTestDataDF); 

END;