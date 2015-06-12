# erl_protobuffs
An implementation of Google's Protocol Buffers for Erlang, based on [basho/erlang_protobuffs](https://github.com/basho/erlang_protobuffs).

This module is a composite of other open source modules and original code to make interfacing with the Protocol Buffers protocol easy.

## Using .proto Files
The main objective of this module is to allow developers to use .proto files easily. This module provides very basic functionality to do so.

For example, test.proto
```proto
message Person {  
  required bool marriage = 1[default=true];  
  required string name = 2;  
}  
  
message Family {  
  repeated Person person = 1;  
}  
```
From that file we can create an Erlang module that can encode and decode the Person message into records.
```plain
1> protobuffs_compile:scan_file("test.proto").
ok
2> rr("test_pb.hrl").
[family,person]
3> Person = #person{marriage=true, name="John"}, test_pb:encode_person(Person).
<<8,1,18,4,74,111,104,110>>
4> test_pb:decode_person(<<8,1,18,4,74,111,104,110>>).
#person{marriage = true,name = "John"}
5> test_pb:encode(Person).
<<8,1,18,4,74,111,104,110>>
6> test_pb:decode(person, <<8,1,18,4,74,111,104,110>>).
#person{marriage = true,name = "John"}
```

