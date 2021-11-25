dist-runtime:
	cp dist.ini-runtime dist.ini
	cpanm -n -l dzil-local Dist::Zilla
	PATH=$(PATH):dzil-local/bin PERL5LIB=dzil-local/lib/perl5 dzil authordeps --missing | cpanm -n -l dzil-local/
	PATH=$(PATH):dzil-local/bin PERL5LIB=dzil-local/lib/perl5 dzil build

dist-devel: readme
	cp dist.ini-devel dist.ini
	cpanm -n -l dzil-local Dist::Zilla
	PATH=$(PATH):dzil-local/bin PERL5LIB=dzil-local/lib/perl5 dzil authordeps --missing | cpanm -n -l dzil-local/
	PATH=$(PATH):dzil-local/bin PERL5LIB=dzil-local/lib/perl5 dzil build

readme:
	cpanm -l dzil-local -n Pod::Markdown
	perl -I dzil-local/lib/perl5/ dzil-local/bin/pod2markdown lib/DBIx/DBFlow.pm > README.md
