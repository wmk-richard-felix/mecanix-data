IMPORT MecanixLT, ML_Core;

dMyTrainData := MecanixLT.Vibracao.modPrepareData.dMyTrainData;
dMyTestData  := MecanixLT.Vibracao.modPrepareData.dMyTestData;

//Numeric Field Matrix conversion
ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

EXPORT modConvertData := MODULE

  EXPORT dMyIndTrainDataNF := dMyTrainDataNF(number < 8); // Number is the field number
  EXPORT dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 8), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

  EXPORT dMyIndTestDataNF := dMyTestDataNF(number < 8);
  EXPORT dMyDepTestDataNF := PROJECT(dMyTestDataNF(number = 8), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

END;