IMPORT MDL, ML_Core;

EXPORT fPrepareData(DATASET(MDL.modLuzes.lLayoutKey) dMyData, UNSIGNED uDepField) := FUNCTION
  ML_Core.ToField(dMyData, dMyDataNF);
  RETURN dMyDataNF(number < uDepField);
END;
