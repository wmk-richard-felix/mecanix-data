IMPORT Common, ETL, MDL, STD;

SEQUENTIAL(
  SEQUENTIAL(
    // ETL.modBuild.macBuildWithId('problemas');

    Common.modIdUnico('barulhos').aCreateIDfile;
    ETL.modBuild.macBuild('barulhos');
    
    // Create the indexes
    MDL.modCreateIndexes.aCreateIndexes(TRUE);
  );

);