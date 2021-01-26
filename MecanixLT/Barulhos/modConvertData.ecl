IMPORT MecanixLT, ML_Core;

dMyTrainData := MecanixLT.Barulhos.modPrepareData.dMyTrainData;
dMyTestData  := MecanixLT.Barulhos.modPrepareData.dMyTestData;

//Numeric Field Matrix conversion
ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

EXPORT modConvertData := MODULE

  EXPORT dMyIndTrainDataNF := dMyTrainDataNF(number < 16); // Number is the field number
  EXPORT dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 16), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

  EXPORT dMyIndTestDataNF := dMyTestDataNF(number < 16);
  EXPORT dMyDepTestDataNF := PROJECT(dMyTestDataNF(number = 16), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

END;