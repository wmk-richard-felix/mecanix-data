/*##############################################################################
## HPCC SYSTEMS software Copyright (C) 2017 HPCC Systems®.  All rights reserved.
############################################################################## */
IMPORT Std;
EXPORT Bundle := MODULE(Std.BundleBase)
 EXPORT Name := 'LearningTrees';
 EXPORT Description := 'LearningTrees Bundle for Tree-based Machine Learning';
 EXPORT Authors := ['HPCCSystems'];
 EXPORT License := 'http://www.apache.org/licenses/LICENSE-2.0';
 EXPORT Copyright := 'Copyright (C) 2018 HPCC Systems';
 EXPORT DependsOn := ['ML_Core 3.2.0'];
 EXPORT Version := '1.1.1';
 EXPORT PlatformVersion := '6.4.0';
END;