IMPORT Common, ETL, STD;

// ETL.modBuild.macBuildProblemas('problemas');
// ETL.modBuild.macBuildProblemas('barulhos');


// IF(NOT STD.File.FileExists(Common.modConstants.sIdUnicoFilename),
//   OUTPUT(DATASET([{1}], {UNSIGNED id}),,Common.modConstants.sIdUnicoFilename)
// );

// dTest := DATASET(Common.modConstants.sIdUnicoFilename, {UNSIGNED id}, THOR).id;

// dTest;

Common.modIdUnico.aCreateIDfile;