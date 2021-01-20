IMPORT MDL;

EXPORT modPrepareData := MODULE

  SHARED dMyData := MDL.modBarulhos.dMIAData();
  SHARED lMyFormat := MDL.modBarulhos.lMiaLayout;

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
  EXPORT dMyTrainData := PROJECT(dMyDataES[1..750], lMyFormat):PERSIST('~mecanix::barulhos::Train');
  EXPORT dMyTestData := PROJECT(dMyDataES[751..1000], lMyFormat):PERSIST('~mecanix::barulhos::Test');

END;