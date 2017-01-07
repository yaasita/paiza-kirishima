ORIGINAL_CODE = origin.pl
TEISYUTU_CODE = teisyutu.pl

$(TEISYUTU_CODE): $(ORIGINAL_CODE)
	cp $(ORIGINAL_CODE) $@
	perl -i -nle '$$cut = 1 if /^__DATA__/;print if ! $$cut;' $@
	perl -i -ple 's/<DATA>/<STDIN>/' $@
clean:
	rm -f teisyutu.pl
