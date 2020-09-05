redo-ifchange gogost.go
perl -ne 'print "$1\n" if /Version.*"(.*)"$/' < gogost.go
