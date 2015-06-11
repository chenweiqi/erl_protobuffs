-module(test).  
  
-compile([export_all]).  
  
-include("test_pb.hrl").  
  
encode() ->  
    Person = #person{age=true, name="John"},  
    test_pb:encode_person(Person).  
  
decode() ->  
    Data = encode(),  
    test_pb:decode_person(Data).  
  
encode_repeat() ->  
    RepeatData =  
    [  
        #person{age=true, name="John"},  
        #person{age=true, name="Lucy"},  
        #person{age=false, name="Tony"}  
    ],  
    Family = #family{person=RepeatData},  
    test_pb:encode_family(Family).  
      
decode_repeat() ->  
    Data = encode_repeat(),  
    test_pb:decode_family(Data). 

test() ->
	io:format("encode ~p~n", [encode()]),
	io:format("decode ~p~n", [decode()]),
	io:format("encode_repeat ~p~n", [encode_repeat()]),
	io:format("decode_repeat ~p~n", [decode_repeat()]),
	ok.