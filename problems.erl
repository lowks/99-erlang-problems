-module('problems').
-compile(export_all).

%% 1> p1to19_lists:my_last([1,2,3,4]).
%% 4

 my_last([]) ->
   nil;
 my_last([H])  ->
   H;
 my_last([_H|T]) ->
   my_last(T).

%% > p02:penultimate(List(1, 1, 2, 3, 5, 8))
%% 5

 penultimate([]) ->
  nil;
 penultimate([H|T]) when length(T) == 1 -> 
  H; 
 penultimate([_H|T]) -> 
  penultimate(T).

%% > p03:kth([0, 1, 2, 3], 2).
%% 2

 kth([], _L) -> 
   nil;
 kth([H|_T], 1) ->
   H;
 kth([_H|T], L) ->
   kth(T, L - 1). 

%% > p04:len([1,2,3]).
%% 3

  len([]) ->
    0;
  len(L) ->
    len_impl(L, 0).
  len_impl([_H|T], C) ->
    len_impl(T, C+1); 
  len_impl([], C) ->
    C.

%% > p05:reverse([1,2,3,4,5]).
%% 5

  reverse([]) ->
    [];
  reverse(L) ->
    reverse_impl(L, []).
  reverse_impl([H|T], L2) ->
    reverse_impl(T, [H] ++ L2);
  reverse_impl([], L2) ->
    L2.

%% > p06:is_palindrome([1,2,3,2,1]).
%% true

  is_palindrome([]) ->
     [];
  is_palindrome(L) ->
     reverse(L) == L. 

%% > p07:flatten([1,2,[3,[4,[5,6]]]]).
%% [1,2,3,4,5,6]

  flatten([]) ->
    [];
  flatten(L) ->
    impl_flatten(L, []).
  impl_flatten([H|T], L2) when is_list(H) ->
    impl_flatten(H ++ T, L2);
  impl_flatten([H|T], L2) ->
    impl_flatten(T, L2 ++ [H]); 
  impl_flatten([], L2) ->
    L2.

%% > p08:compress([1,1,1,1,2,2,2,3,3,3,3,]).
%% [1,2,3]

   compress([]) ->
     [];
   compress(L) ->
     impl_compress(L, []).
   impl_compress([], R1) ->
     R1;
   impl_compress([H], R1) ->
     impl_compress([], R1 ++ [H]); 
   impl_compress([H1|[H1|T]], R1) ->
     impl_compress([H1|T], R1);
   impl_compress([H1|[H2|T]], R1) ->
     impl_compress([H2|T], R1 ++ [H1]).
   
%% > p09:pack(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%%  [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

   pack([]) ->
     [];
   pack(L) ->
     impl_pack(L, [], []).
   impl_pack([], _, R) ->
     R;
   impl_pack([H1|[H1|T]], L, R) ->
    impl_pack([H1|T], L ++ [H1], R); 
   impl_pack([H1], L, R) ->
    impl_pack([], [], R ++ [L ++ [H1]]); 
   impl_pack([H1|[H2|T]], L, R) ->
    impl_pack([H2|T], [], R ++ [L ++ [H1]]).

%% > p10:encode(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%%    [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

   encode([]) ->
     [];
   encode(L) ->
     impl_encode(pack(L), []).
   impl_encode([[Head|Tail] | Taillist ], Result) ->
     impl_encode(Taillist, Result ++ [{Head, length([Head|Tail])}]);
   impl_encode([], Result) ->
     Result.

%% > p11:encodeModified(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]

   encodeModified([]) ->
     [];
   encodeModified(L) ->
     impl_encodeModified(encode(L), []).
   impl_encodeModified([], Result) ->
     Result;
   impl_encodeModified([{Alphabet, Frequency}| T], Result) ->
     case Frequency =:= 1 of
        true -> 
         impl_encodeModified(T, Result  ++ [Alphabet]);
        false ->
         impl_encodeModified(T, Result  ++ [{Frequency, Alphabet}])
     end.

%% > p12:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%%    [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

   decode([]) ->
     [];
   decode(L) ->
     impl_decode(L, []).
   impl_decode([], Result) ->
     Result;
   impl_decode([{Count, Alphabet} | T ], Result) ->
     case Count =:= 0 of
       true -> 
         impl_decode(T, Result);
       false ->
         impl_decode([{Count - 1, Alphabet} | T], Result ++ [Alphabet])
      end.

