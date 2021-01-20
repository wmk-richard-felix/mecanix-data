IMPORT Common, ETL, STD;

SEQUENTIAL(
  SEQUENTIAL(
    // Common.modIdUnico('problemas').aCreateIDfile;
    // ETL.modBuild.macBuild('problemas');

    Common.modIdUnico('barulhos').aCreateIDfile;
    ETL.modBuild.macBuild('barulhos');
  );

);