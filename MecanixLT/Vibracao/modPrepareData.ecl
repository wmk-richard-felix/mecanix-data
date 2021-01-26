IMPORT Common, MDL;

EXPORT modPrepareData := MODULE

  SHARED lMyFormat := MDL.modVibracao.lLayoutKey;
  EXPORT dMyData := MDL.modVibracao.kData_rid;
 
  // Extended data format
  SHARED lMyFormatExt := RECORD(lMyFormat)
    UNSIGNED4 rnd; // A random number
  END;

  // Assign a random number to each record
  EXPORT dMyDataE := PROJECT(dMyData, TRANSFORM(lMyFormatExt, 
      SELF.rnd := RANDOM(), 
      SELF := LEFT
  ));

  // Shuffle your data by sorting on the random field
  EXPORT dMyDataES := SORT(dMyDataE, rnd);

  // Now cut the deck and you have random samples within each set
  // While you're at it, project back to your original format -- we dont need the rnd field anymore
  EXPORT dMyTrainData := PROJECT(dMyDataES[1..450], lMyFormat);
  EXPORT dMyTestData := PROJECT(dMyDataES[451..600], lMyFormat);

END;