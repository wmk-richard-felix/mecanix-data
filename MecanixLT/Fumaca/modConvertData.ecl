IMPORT MecanixLT, ML_Core;

dMyTrainData := MecanixLT.Fumaca.modPrepareData.dMyTrainData;
dMyTestData  := MecanixLT.Fumaca.modPrepareData.dMyTestData;

//Numeric Field Matrix conversion
ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

EXPORT modConvertData := MODULE

  EXPORT dMyIndTrainDataNF := dMyTrainDataNF(number < 10); // Number is the field number
  EXPORT dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 10), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

  EXPORT dMyIndTestDataNF := dMyTestDataNF(number < 10);
  EXPORT dMyDepTestDataNF := PROJECT(dMyTestDataNF(number = 10), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

END;