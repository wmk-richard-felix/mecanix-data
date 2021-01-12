/*##############################################################################
## HPCC SYSTEMS software Copyright (C) 2017 HPCC Systems®.  All rights reserved.
############################################################################## */
/**
  * Use the Cover Type database of Rocky Mountain Forest plots.
  * Perform a regression to predict the elevation given the other features.
  * Do not be confused by the fact that we are using Random Forests to analyze
  * tree species in an actual forest :)
  * @see test/datasets/CovTypeDS.ecl
  */
IMPORT $.datasets.CovTypeDS;
IMPORT $.^ AS LT;
IMPORT LT.LT_Types;
IMPORT ML_Core;
IMPORT ML_Core.Types;

numTrees := 400;
maxDepth := 255;
//maxDepth := 255;
numFeatures := 0; // Zero is automatic choice
nonSequentialIds := FALSE; // True to renumber ids, numbers and work-items to test
                            // support for non-sequentiality
numWIs := 1;     // The number of independent work-items to create
maxRecs := 500; // Note that this has to be less than or equal to the number of records
                    // in CovTypeDS (currently 5000)
maxTestRecs := 100;
t_Discrete := Types.t_Discrete;
t_FieldReal := Types.t_FieldReal;
DiscreteField := Types.DiscreteField;
NumericField := Types.NumericField;
trainDat := CovTypeDS.trainRecs;
testDat := CovTypeDS.testRecs;
ctRec := CovTypeDS.covTypeRec;
nominalFields := CovTypeDS.nominalCols;
numCols := CovTypeDS.numCols;

ML_Core.ToField(trainDat, trainNF);
ML_Core.ToField(testDat, testNF);
// Take out the first field from training set (Elevation) to use as the target value.  Re-number the other fields
// to fill the gap
X0 := PROJECT(trainNF(number != 1 AND id <= maxRecs), TRANSFORM(NumericField,
        SELF.number := IF(nonSequentialIds, (5*LEFT.number -1), LEFT.number -1),
        SELF.id := IF(nonSequentialIds, 5*LEFT.id, LEFT.id),
        SELF := LEFT));
Y0 := PROJECT(trainNF(number = 1 AND id <= maxRecs), TRANSFORM(NumericField,
        SELF.number := 1,
        SELF.id := IF(nonSequentialIds, 5*LEFT.id, LEFT.id),
        SELF := LEFT));
// Generate multiple work items
X := NORMALIZE(X0, numWIs, TRANSFORM(RECORDOF(LEFT),
          SELF.wi := IF(nonSequentialIds, 5*COUNTER, COUNTER),
          SELF := LEFT));
Y := NORMALIZE(Y0, numWIs, TRANSFORM(RECORDOF(LEFT),
          SELF.wi := IF(nonSequentialIds, 5*COUNTER, COUNTER),
          SELF := LEFT));

IMPORT Python;
SET OF UNSIGNED incrementSet(SET OF UNSIGNED s, INTEGER increment) := EMBED(Python)
  outSet = []
  for i in range(len(s)):
    outSet.append(s[i] + increment)
  return outSet
ENDEMBED;
// Fixup IDs of nominal fields to match
nomFields := incrementSet(nominalFields, -1);
card0 := SORT(X, number, value);
card1 := TABLE(card0, {number, value, valCnt := COUNT(GROUP)}, number, value);
card2 := TABLE(card1, {number, featureVals := COUNT(GROUP)}, number);
card := TABLE(card2, {cardinality := SUM(GROUP, featureVals)}, ALL);
OUTPUT(card, NAMED('X_Cardinality'));
F := LT.RegressionForest(numTrees:=numTrees, featuresPerNode:=numFeatures, maxDepth:=maxDepth, nominalFields:=nominalFields);
mod := F.GetModel(X, Y);
OUTPUT(Y, NAMED('Ytrain'));
Y_S := SORT(Y, value);
classCounts0 := TABLE(Y, {wi, class := value, cnt := COUNT(GROUP)}, wi, value);
classCounts := TABLE(classCounts0, {wi, classes := COUNT(GROUP)}, wi);

OUTPUT(mod, NAMED('Model'));
nodes := SORT(F.Model2Nodes(mod), wi, treeId, level, nodeId);
//OUTPUT(nodes, {wi, treeId, level, nodeId, parentId, isLeft, number, value, depend, support, ir}, NAMED('TreeNodes'));
OUTPUT(nodes, {id,wi, treeId, level, nodeId, parentId, isLeft, number, value, depend, support, ir}, NAMED('TreeNodes'));
modStats := F.GetModelStats(mod);
OUTPUT(modStats, NAMED('ModelStatistics'));
maxTestId := MIN(testNF, id) + maxTestRecs;
testNF2 := testNF(id < maxTestId);
Xtest0 := PROJECT(testNF2(number != 1), TRANSFORM(NumericField,
                    SELF.number := IF(nonSequentialIds, (5*LEFT.number -1), LEFT.number -1),
                    SELF.id := IF(nonSequentialIds, 5*LEFT.id, LEFT.id),
                    SELF := LEFT));
Ycmp0 := PROJECT(testNF2(number = 1), TRANSFORM(NumericField,
                    SELF.number := 1,
                    SELF.id := IF(nonSequentialIds, 5*LEFT.id, LEFT.id),
                    SELF := LEFT));
// Generate multiple work items
Xtest := NORMALIZE(Xtest0, numWIs, TRANSFORM(RECORDOF(LEFT),
          SELF.wi := IF(nonSequentialIds, 5*COUNTER, COUNTER),
          SELF := LEFT));
Ycmp := NORMALIZE(Ycmp0, numWIs, TRANSFORM(RECORDOF(LEFT),
          SELF.wi := IF(nonSequentialIds, 5*COUNTER, COUNTER),
          SELF := LEFT));
Yhat := F.Predict(mod, Xtest);

cmp := JOIN(Yhat, Ycmp, LEFT.wi = RIGHT.wi AND LEFT.id = RIGHT.id, TRANSFORM({UNSIGNED wi, UNSIGNED id, REAL y, REAL yhat, REAL err, REAL err2},
                  SELF.y := RIGHT.value, SELF.yhat := LEFT.value, SELF.err2 := POWER(LEFT.value - RIGHT.value, 2),
                  SELF.err := ABS(LEFT.value - RIGHT.value), SELF := LEFT));

OUTPUT(cmp, ALL, NAMED('Details'));

//Yvar := VARIANCE(Ycmp, value);
//rsq := F.Rsquared(Xtest, Ycmp, mod);
//MSE := TABLE(cmp, {wi, mse := AVE(GROUP, err2), rmse := SQRT(AVE(GROUP, err2)), stdevY := SQRT(VARIANCE(GROUP, y))}, wi);
//ErrStats := JOIN(MSE, rsq, LEFT.wi = RIGHT.wi, TRANSFORM({mse, REAL R2}, SELF.R2 := RIGHT.R2, SELF := LEFT));
accuracy :=F.Accuracy(mod, Ycmp, Xtest);
OUTPUT(accuracy, NAMED('Accuracy'));

fi := F.FeatureImportance(mod);
OUTPUT(fi, NAMED('FeatureImportance'));
