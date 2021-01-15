IMPORT Common, ETL, STD;

SEQUENTIAL(
  // ETL.modBuild.macBuildProblemas('problemas');
  SEQUENTIAL(
    Common.modIdUnico('barulhos').aCreateIDfile;
    ETL.modBuild.macBuild('barulhos');
  );

);