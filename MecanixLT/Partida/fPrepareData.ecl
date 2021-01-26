IMPORT MDL, ML_Core;

EXPORT fPrepareData(DATASET(MDL.modPartida.lLayoutKey) dMyData, UNSIGNED uDepField) := FUNCTION
  ML_Core.ToField(dMyData, dMyDataNF);
  RETURN dMyDataNF(number < uDepField);
END;
