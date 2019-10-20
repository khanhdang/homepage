DOCS=index pub teaching rtes service proj profile 

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
