IMPORT Common, ETL, MDL, STD;

ssFilename := [
  'barulhos',
  'fumaca',
  'liquidos',
  'luzes',
  'partida',
  'vibracao'
];

SEQUENTIAL(
  SEQUENTIAL(
    // ETL.modBuild.macBuildWithId('problemas');

    // Run the first build
    #EXPAND(Common.macLoopFunctions(ssFilename, Common.modIdUnico().aCreateIDfile));
    #EXPAND(Common.macLoopFunctions(ssFilename, ETL.modBuild.macBuild));
    
    // Create the indexes
    MDL.modCreateIndexes.aCreateIndexes(TRUE);
  );

);