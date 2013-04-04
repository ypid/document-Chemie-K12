include $(HOME)/Skripte/makefiles/latex/Makefile.rules

TEXORGFILE	= Chemie-K12
TEXFILE		= $(TEXORGFILE)
FILE		= $(TEXORGFILE)

#TEXBTFILE	= $(TEXORGFILE)-ly
## Muss in "main" liegen mit ln -s main/doc.tex doc.tex

UPLOADFILE	= $(TEXFILE).pdf
## Dateien werden vor einem Upload nach /tmp Kopiert
UPLOADDIR	= Klasse/12
UPLOAD		?= $(UPLOADCOM) /httpdocs/$(UPLOADDIR) /tmp/$(UPLOADFILE)
## Geht nur bei einer Datei

all: gitstats main upload
	$(CP) /tmp/$(UPLOADFILE) $(TEXFILE)-cp.pdf
#	make FILE="$(TEXBTFILE)"

main: $(TEXFILE).pdf log

.PHONY: files/git/version.tex
files/git/version.tex:
	LaTeX-git-commit-count.sh > files/git/version.tex	## \readgitstat{7}
	LaTeX-git-log.sh |sed 's/rlllrrr/rllp{12cm}rrr/g' > files/git/versions-log.tex
	## Falls die Tabele über den rechten Rand geht: |sed 's/rlllrrr/rllp{12cm}rrr/g'
	LaTeX-gitstats.sh >/dev/null
	## LaTeX-gitstats.sh "Name_für_website" >/dev/null
	$(TPUTDONE)
	$(ECHO) "gitstats done"
	$(TPUTRESET)

include $(HOME)/Skripte/makefiles/latex/Makefile.targets

