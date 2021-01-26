IMPORT MecanixLT, ML_Core;

dMyTrainData := MecanixLT.Partida.modPrepareData.dMyTrainData;
dMyTestData  := MecanixLT.Partida.modPrepareData.dMyTestData;

//Numeric Field Matrix conversion
ML_Core.ToField(dMyTrainData, dMyTrainDataNF);
ML_Core.ToField(dMyTestData, dMyTestDataNF);

EXPORT modConvertData := MODULE

  EXPORT dMyIndTrainDataNF := dMyTrainDataNF(number < 11); // Number is the field number
  EXPORT dMyDepTrainDataNF := PROJECT(dMyTrainDataNF(number = 11), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

  EXPORT dMyIndTestDataNF := dMyTestDataNF(number < 11);
  EXPORT dMyDepTestDataNF := PROJECT(dMyTestDataNF(number = 11), TRANSFORM(RECORDOF(LEFT), 
      SELF.number := 1;
      SELF := LEFT
  ));

END;