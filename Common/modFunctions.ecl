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

  EXPORT fIdUnico(INTEGER uCounter) := FUNCTION

    sCounter := (STRING) uCounter;
    sCurrentDate := (STRING) STD.Date.CurrentDate();
    sCurrentTime := (STRING) STD.Date.CurrentTime();

    RETURN (UNSIGNED) (sCurrentDate[3..] + sCurrentTime[1..4] + sCounter);
  END;

END;