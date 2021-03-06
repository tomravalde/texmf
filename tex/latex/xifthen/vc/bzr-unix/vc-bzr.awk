# This is file 'vc-bzr.awk' from the vc bundle for TeX.
# The original file can be found at CTAN:support/vc.
# This file is Public Domain.
BEGIN {
### Assume clean working copy.
		Clean = "True"
}
/^revision-id:/ { RevisionId = substr($0, 2+match($0, ":")) }
/^date:/ { Date = substr($0, 2+match($0, ":")) }
/^build-date:/ { BuildDate = substr($0, 2+match($0, ":")) }
/^revno:/ { RevNo = substr($0, 2+match($0, ":")) }
/^branch-nick:/ { BranchNick = substr($0, 2+match($0, ":")) }
/^clean:/ { Clean = substr($0, 2+match($0, ":")) }
END {
### Extract relevant information from variables.
		elements = split(RevisionId, elem, "-")
		Author = elem[1]
		for (i=2; i<elements-2; i++) {
				Author = Author "-" elem[i]
		}
    LongDate = substr(Date, 1, 25)
    DateRAW = substr(LongDate, 1, 10)
    DateISO = DateRAW
    DateTEX = DateISO
    gsub("-", "/", DateTEX)
    Time = substr(LongDate, 12, 14)
		if (Clean=="True") {
				modified = 0
		} else {
				modified = 1
		}
### Write file identification to vc.tex.
		print "%%% This file has been generated by the vc bundle for TeX."
		print "%%% Do not edit this file!"
		print "%%%"
### Write Bazaar specific macros.
    print "%%% Define Bazaar specific macros."
    print "\\gdef\\BZRRevisionId{" RevisionId "}%"
    print "\\gdef\\BZRDate{" Date "}%"
    print "\\gdef\\BZRBuildDate{" BuildDate "}%"
    print "\\gdef\\BZRRevNo{" RevNo "}%"
		if (full==1) {
				print "\\gdef\\BZRBranchNick{" BranchNick "}%"
		}
### Write generic version control macros.
    print "%%% Define generic version control macros."
    print "\\gdef\\VCRevision{\\BZRRevNo}%"
    print "\\gdef\\VCAuthor{" Author "}%"
    print "\\gdef\\VCDateRAW{" DateRAW "}%"
    print "\\gdef\\VCDateISO{" DateISO "}%"
    print "\\gdef\\VCDateTEX{" DateTEX "}%"
    print "\\gdef\\VCTime{" Time "}%"
    print "\\gdef\\VCModifiedText{\\textcolor{red}{with local modifications!}}%"
### Is working copy modified?
    print "%%% Is working copy modified?"
    print "\\gdef\\VCModified{" modified "}%"
		if (modified==0) {
				print "\\gdef\\VCRevisionMod{\\VCRevision}%"
		} else {
				print "\\gdef\\VCRevisionMod{\\VCRevision~\\VCModifiedText}%"
		}
}
