LOCAL fGetErrorMessage( UNSIGNED uErrCode) := CASE( uErrCode,
  5001 => 'Missing or Inexistent Superfile',
  5002 => 'Fail when trying to clean a system superfile',
  'Failed with an invalid error code'
);

EXPORT modErrors := MODULE
  // Function to halt the execution of the work unit with a specific error code and message
  EXPORT fGenerateError(UNSIGNED uErrCode, STRING sOptionalDetails = '') := 
         ERROR(uErrCode, TRIM(fGetErrorMessage(uErrCode), LEFT, RIGHT) + '. ' + sOptionalDetails);

  // Action to halt the execution of the work unit with a specific error code and message
  EXPORT aGenerateFail(UNSIGNED uErrCode, STRING sOptionalDetails = '') := 
         FAIL(uErrCode, TRIM(fGetErrorMessage(uErrCode), LEFT, RIGHT) + '. ' + sOptionalDetails);
END;
