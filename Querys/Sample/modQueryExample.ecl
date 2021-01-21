EXPORT modQueryExample := MODULE
  IMPORT Std;

  //---------------------------------------------------------------------------
  // Test Dataset Creation
  // fGetPerson([number of rows],[random small unsigned seed],[offset (to avoid overlapping ids)]);
  //---------------------------------------------------------------------------
  SHARED ssMNames:=['ALEXANDER','CALLUM','CHARLES','CHARLIE','CONNOR','DAMIAN','DANIEL','DAVID','ETHAN','GEORGE','HARRY','JACK','JACOB','JAKE','JAMES','JOE','JOHN','JOSEPH','KYLE','LIAM','MASON','MICHAEL','NOAH','OLIVER','OSCAR','REECE','RHYS','RICHARD','ROBERT','THOMAS','WILLIAM'];
  SHARED ssFNames:=['ABIGAIL','AMELIA','AVA','BARBARA','BETHANY','CHARLOTTE','ELIZABETH','EMILY','EMMA','ISABELLA','ISLA','JENNIFER','JESSICA','JOANNE','LAUREN','LILY','LINDA','MADISON','MARGARET','MARY','MEGAN','MIA','MICHELLE','OLIVIA','PATRICIA','POPPY','SAMANTHA','SARAH','SOPHIA','SOPHIE','SUSAN','TRACY','VICTORIA'];
  SHARED ssLNames:=['ANDERSON','BROWN','BYRNE','DAVIES','DAVIS','EVANS','GAGNON','GARCIA','GELBERO','JOHNSON','JONES','LAM','LEE','LI','MARTIN','MILLER','MORTON','MURPHY','ROBERTS','RODRIGUEZ','ROY','SINGH','SMITH','TAYLOR','THOMAS','TREMBLAY','WALSH','WANG','WHITE','WILLIAMS','WILSON'];
  SHARED ssEyeColors:=['BLUE','BROWN','GREEN','HAZEL','PURPLE','ORANGE'];

  EXPORT lPerson:=RECORD
    UNSIGNED person_id;
    STRING30 name_first;
    STRING30 name_last;
    STRING8 date_of_birth;
    STRING10 eye_color;
    STRING1 gender;
  END;

  EXPORT fGetPerson(UNSIGNED iRecordCount,REAL iSeed,UNSIGNED iOffset=0):=DATASET(iRecordCount,TRANSFORM(lPerson,
    SELF.person_id:=COUNTER+iOffset;
    SELF.gender:=IF((POWER(COUNTER+1,4.1+(iSeed/10.0))%2)=0,'M','F');
    ssNameFirst:=IF(SELF.gender='M',ssMNames,ssFNames);
    SELF.name_first:=ssNameFirst[(POWER(COUNTER+1,4.2+(iSeed/10.0))%COUNT(ssNameFirst))+1];
    SELF.name_last:=ssLNames[(POWER(COUNTER+1,4.4+(iSeed/10.0))%COUNT(ssLNames))+1];
    SELF.date_of_birth:=(STRING) Std.Date.AdjustCalendar(Std.Date.CurrentDate(),-((POWER(COUNTER+1,4.6+(iSeed/10.0))%50)+20),,-(POWER(COUNTER+1,4.8+(iSeed/10.0))%300));
    SELF.eye_color:=ssEyeColors[(POWER(COUNTER+1,5.0+(iSeed/10.0))%COUNT(ssEyeColors))+1];
  ));

  //---------------------------------------------------------------------------
  // Index definitions for key files.  Logical EXPORTS are to create a logical
  // index based on an input dataset and unique file ID.  Other EXPORT is to
  // reference the superfile the logical files are placed within.
  //---------------------------------------------------------------------------
  EXPORT kPersonByID_Logical(DATASET(lPerson) dDataToIndex=DATASET([],lPerson),STRING sVersion='superfile'):=INDEX(dDataToIndex,{person_id},{dDataToIndex},'~key::person_by_id::'+sVersion);
  EXPORT kPersonByID:=INDEX(kPersonByID_Logical(),'~key::person_by_id::superfile');
  
  EXPORT kPersonByName_Logical(DATASET(lPerson) dDataToIndex=DATASET([],lPerson),STRING sVersion='superfile'):=INDEX(dDataToIndex,{name_last,name_first},{person_id},'~key::person_by_name::'+sVersion);
  EXPORT kPersonByName:=INDEX(kPersonByName_Logical(),'~key::person_by_name::superfile');

  //---------------------------------------------------------------------------
  // Build process -- If user specifies the new keys replace the files already
  // in the superfiles, the superfiles are cleared.  Then new keys are generated
  // and placed into the superfiles.
  //---------------------------------------------------------------------------
  EXPORT aBuild(DATASET(lPerson) dDataToIndex,STRING sVersion,BOOLEAN bReplace=FALSE):=SEQUENTIAL(
    IF(bReplace,PARALLEL(
      IF(Std.File.SuperfileExists('~key::person_by_id::superfile'),Std.File.ClearSuperfile('~key::person_by_id::superfile')),
      IF(Std.File.SuperfileExists('~key::person_by_name::superfile'),Std.File.ClearSuperfile('~key::person_by_name::superfile'))
    )),
    BUILDINDEX(kPersonByID_Logical(dDataToIndex,sVersion),OVERWRITE),
    BUILDINDEX(kPersonByName_Logical(dDataToIndex,sVersion),OVERWRITE),
    Std.File.AddSuperfile('~key::person_by_id::superfile','~key::person_by_id::'+sVersion),
    Std.File.AddSuperfile('~key::person_by_name::superfile','~key::person_by_name::'+sVersion)
  );
  
  EXPORT dGetPersonByName(STRING sLName,STRING sFName=''):=JOIN(kPersonByName(name_last=sLName AND (sFName='' OR name_first=sFName)),kPersonByID,LEFT.person_id=RIGHT.person_id,TRANSFORM(RIGHT));

END;


/*

// _Reference.modQueryExample.aBuild(_Reference.modQueryExample.fGetPerson(10000,5),'20180130');
// _Reference.modQueryExample.aBuild(_Reference.modQueryExample.fGetPerson(10000,7,20000),'20180131');


<RoxiePackages>
  <Package id="svcExample">
    <Base id="svcExampleKeys"/>
  </Package>
  <Package id="svcExampleKeys">
    <SuperFile id="~key::person_by_id::superfile">
      <SubFile id="~key::person_by_id::20180130"/>
      <SubFile id="~key::person_by_id::20180131"/>
    </SuperFile>
    <SuperFile id="~key::person_by_name::superfile">
      <SubFile id="~key::person_by_name::20180130"/>
      <SubFile id="~key::person_by_name::20180131"/>
    </SuperFile>
  </Package>
</RoxiePackages>

// From the commmand prompt:
ecl packagemap add -A -O -s=10.240.32.125 -u=****** -pw=****** roxie svcExample.pkg

// where:
//   -A means "Activate"
//   -O means "Overwrite"
//   -s points to the server to publish to
//   -u is your username
//   -pw is your password
//   roxie is the cluster to publish to
//   svcExample.pkg is the package file to activate


*/