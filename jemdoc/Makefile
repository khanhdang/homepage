DOCS=index pub  service  teaching rtes grant research research_neuromorphic research_thermal research_mlcad research_ftnoc research_h264 students profile contact fun volunteer news patent
HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix html/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	# insert code for copying to server here.
	@cp html/*.html ../
	@echo ' done.'

html/%.html : %.jemdoc MENU
	./jemdoc -c mysite.conf -o $@ $<

.PHONY : clean
clean :
	-rm -f html/*.html
