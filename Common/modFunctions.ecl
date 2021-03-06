IMPORT Common, STD;

EXPORT modFunctions := MODULE

  EXPORT fGetFilename(STRING sSubsystem, STRING sTableName, STRING sSuffix = '') := FUNCTION
    STRING sSystem := IF(sSubsystem <> '',
      sSubsystem + '::',
      ''
    );
    STRING sUdmTable := IF(sTableName <> '',
      IF(sSuffix <> '', sTableName + '::', sTableName),
      ''
    );
    STRING sOutputSuffix := IF(sSuffix <> '' AND sSuffix[1] = '~', 
      sSuffix[2..], sSuffix
    );
    RETURN Common.modConstants.sSystemRoot + sSystem + sUdmTable + sOutputSuffix;
  END;

  // Returns an UNSIGNED8 that represents the current datetime in the format YYYYMMDDHHMMSS
  EXPORT UNSIGNED8 fCurrentDateTime() := FUNCTION
    RETURN (UNSIGNED8) (STD.Date.CurrentDate()*1000000 + STD.Date.CurrentTime());
  END;

END;