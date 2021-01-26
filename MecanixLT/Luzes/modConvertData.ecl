IMPORT MecanixLT, ML_Core;

dMyTrainData := MecanixLT.Luzes.modPrepareData.dMyTrainData;
dMyTestData  := MecanixLT.Luzes.modPrepareData.dMyTestData;

//Numeric Field Matrix conversion
ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

EXPORT modConvertData := MODULE

  EXPORT dMyIndTrainDataNF := dMyTrainDataNF(number < 13); // Number is the field number
  EXPORT dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 13), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

  EXPORT dMyIndTestDataNF := dMyTestDataNF(number < 13);
  EXPORT dMyDepTestDataNF := PROJECT(dMyTestDataNF(number = 13), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

END;