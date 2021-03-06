EXPORT modConstants := MODULE

  EXPORT sSystemRoot := '~';
  EXPORT sMecanixSubSystem := 'mecanix';
  EXPORT sRawSubSystem := 'rawfiles::mecanix';
  EXPORT sIdUnicoFilename := '~mecanix::id::'; 
  EXPORT sMecanixLTScope := sSystemRoot + sMecanixSubSystem + '::model::';
  EXPORT sModelBarulhosFilename := sMecanixLTScope + 'barulhos';
  
END;