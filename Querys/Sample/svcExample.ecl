EXPORT svcExample := MACRO
IMPORT Querys;
/*--INFO-- Simple Service Example
<p>Search for a person based on last name</p>
*/
  STRING sFirstName:='':STORED('first_name');
  STRING sLastName:='':STORED('last_name');
  
  OUTPUT(Querys.Sample.modQueryExample.dGetPersonByName(sLastName,sFirstName),NAMED('TheResults'));
ENDMACRO;