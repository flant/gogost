redo-ifchange gogost.go
perl -ne 'print $1 if /Version.*"(.*)"$/' < gogost.go
