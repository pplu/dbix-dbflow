dist-runtime:
	cp dist.ini-runtime dist.ini
	carton exec dzil build

dist-devel:
	cp dist.ini-devel dist.ini
	carton exec dzil build
