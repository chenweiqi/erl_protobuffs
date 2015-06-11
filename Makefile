SHELL := /bin/bash
.PHONY: help all test proto clean
.DEFAULT_GOAL := help
FILES=`cd proto && ls *.proto`
ERL := erl

help:
	@echo help
	
all:
	@echo "compile protobuffs"
	@$(ERL) -make
	@for file in $(FILES); do \
		( echo "compile: $$file" && $(ERL) -pa ebin -noshell -s protobuffs_compile scan_file_src proto/$$file -s erlang halt ) \
	done;
	

test:all
	$(ERL) -compile test/test.erl
	$(ERL) -compile test_pb.erl
	mv test.beam ebin/
	mv test_pb.beam ebin/
	$(ERL) -pa ebin -s test test -s erlang halt
	@echo test done!
	$(ERL) -pa ebin

clean:
	rm -rf ebin/*
	@for file in $(FILES); do \
		( rm -rf `echo $$file | sed 's/\(.*\)\..*/\1/g' `_pb.* ) \
	done;