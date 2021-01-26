IMPORT MDL, ML_Core;

EXPORT fPrepareData(DATASET(MDL.modBarulhos.lLayoutKey) dMyData, UNSIGNED uDepField) := FUNCTION
  ML_Core.ToField(dMyData, dMyDataNF);
  RETURN dMyDataNF(number < uDepField);
END;
