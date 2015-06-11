@echo off
call script/build
erl -compile test/test.erl
erl -compile test_pb.erl
move test.beam ebin/ >nul
move test_pb.beam ebin/ >nul
erl -pa ebin -s test test -s erlang halt
echo test done!
erl -pa ebin