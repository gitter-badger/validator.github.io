HTML2MARKDOWN=html2text
PERL=perl
PERLFLAGS=
FMT=fmt
FMTFLAGS=-80
EXPAND=expand
EXPANDFLAGS=
BUILDSTATUS=\[\!\[Build Status\]\(http://goo.gl/b6xEQs\)\]\(http://goo.gl/ehNisw)

all: README.md

README.md: index.html
	$(HTML2MARKDOWN) $(HTML2MARKDOWNFLAGS) $< \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/;s/Usage · Options\n//' \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/; s/(\s+\n)+/\n\n/g' \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/; s/(\n\n\n)+/\n/g' \
	    | $(FMT) $(FMTFLAGS) \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/; s/(\[[0-9]+\]) [*] /$$1\n\n  * /g' \
	    | $(FMT) $(FMTFLAGS) \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/; s/ +(\[[0-9]+\]:)\s+/\n   $$1 /g' \
	    | $(PERL) $(PERLFLAGS) -pe 'undef $$/; s/(\n\n\n)+/\n\n/g' \
	    | $(PERL) $(PERLFLAGS) -pe 's|(# The Nu Markup Checker \(v.Nu\))|$$1 $(BUILDSTATUS)|g' \
	    | $(EXPAND) $(EXPANDFLAGS) > $@
