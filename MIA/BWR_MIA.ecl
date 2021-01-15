IMPORT LearningTrees, MDL, ML_Core;

lMyFormat := MDL.modBarulhos.lMiaLayout;
// Extended data format
lMyFormatExt := RECORD(lMyFormat)
  UNSIGNED4 rnd; // A random number
END;

// Assign a random number to each record
dMyData := MDL.modBarulhos.dMIAData();
dMyDataE := PROJECT(dMyData, TRANSFORM(lMyFormatExt, 
  SELF.rnd := RANDOM(), 
  SELF := LEFT
));

// Shuffle your data by sorting on the random field
dMyDataES := SORT(dMyDataE, rnd);

// Now cut the deck and you have random samples within each set
// While you're at it, project back to your original format -- we dont need the rnd field anymore
dMyTrainData := PROJECT(dMyDataES[1..14], lMyFormat);
dMyTestData := PROJECT(dMyDataES[15..], lMyFormat);

ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

dMyIndTrainDataNF := dMyTrainDataNF(number < 16); // Number is the field number
dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 16), TRANSFORM(RECORDOF(LEFT), 
  SELF.number := 1;
  SELF := LEFT
));

dMyIndTestData := dMyTestDataNF(number < 16);
dMyDepTestData := PROJECT(dMyTestDataNF(number = 16), TRANSFORM(RECORDOF(LEFT), 
  SELF.number := 1;
  SELF := LEFT
));

dMyDepTrainDataDF := ML_Core.Discretize.ByRounding(dMyDepTrainDataNF);
dmyDepTestDataDF := ML_Core.Discretize.ByRounding(dMyDepTestData);

modMyLearnerC := LearningTrees.ClassificationForest();
myModelC := modMyLearnerC.GetModel(dMyIndTrainDataNF, dMyDepTrainDataDF); // Notice second param uses the DiscreteField dataset

predictedClasses := modMyLearnerC.Classify(myModelC, dMyIndTestData);
assessmentC := ML_Core.Analysis.Classification.Accuracy(predictedClasses, dMyDepTestDataDF); // Both params are DF dataset

myNewIndData := dMyTestDataNF(id = 17);
predictedClassesIn := modMyLearnerC.Classify(myModelC, myNewIndData);
predictedClassesIn;