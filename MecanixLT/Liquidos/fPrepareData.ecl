IMPORT MDL, ML_Core;

EXPORT fPrepareData(DATASET(MDL.modLiquidos.lLayoutKey) dMyData, UNSIGNED uDepField) := FUNCTION
  ML_Core.ToField(dMyData, dMyDataNF);
  RETURN dMyDataNF(number < uDepField);
END;
