EXPORT macLoopFunctions(ssFilename, functionCall) := FUNCTIONMACRO
  uSize := COUNT(ssFilename);
  
  #UNIQUENAME(cont);
  #SET(cont, 1);
  
  #UNIQUENAME(sCall);
  #SET(sCall, 'SEQUENTIAL(');
  
  #LOOP
    #IF(%cont% > uSize)
      #BREAK;
    #ELSE
      #APPEND(sCall, #TEXT(functionCall) + '(' + #TEXT(ssFilename) + '[' + %cont% + ']);');
      #SET(cont, %cont% + 1);
    #END
  #END
  
  #APPEND(sCall, ')');
  
  RETURN %'sCall'%;
ENDMACRO;