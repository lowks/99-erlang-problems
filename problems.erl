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

%% > p13:encodeDirect(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]



%% > p14:duplicate([1,2,3,4]).   
%%  [1,1,2,2,3,3,4,4]

   duplicate([]) ->
     [];
   duplicate(L) ->
     impl_duplicate(L, []).
   impl_duplicate([], R) ->
     R;
   impl_duplicate([H|T], R) ->
     impl_duplicate(T, R ++ [H, H]).

%% > p15:duplicateN(3, ['a','b','c']).
%%    [a,a,a,b,b,b,c,c,c]

   duplicateN(_N, []) ->
     [];
   duplicateN(N, L) ->
     impl_duplicateN(N, L,[]).
   impl_duplicateN(_,[],R) ->
     R;
   impl_duplicateN(N, [H|T], R) ->
     impl_duplicateN(N, T, R++lists:flatten(lists:duplicate(N,[H]))).

%% > p16:drop(3, [1,2,3,4,5,6,7,8]).
%% [1,2,4,5,7,8]

   drop(_, []) ->
     [];
   drop(N, L) ->
     impl_drop(N, L, []).
   impl_drop(_, [], R) ->
     R;
   impl_drop(N, [N|T], R) ->
     impl_drop(N, T, R);
   impl_drop(N, [M|T], R) ->
     impl_drop(N, T, R ++ [M]).

%% > p17:split(3, [1,2,3,4,5,6,7]).
%% [[1,2,3],[4,5,6,7]]     

   split(_N, []) ->
     [];
   split(N, L) ->
     impl_split(N, L, []).
   impl_split(0, T, R) ->
     [R]++[T];
   impl_split(N, [H|T], R) ->
     impl_split(N-1, T, R++[H]).

%% > p18:slice(3,7, [1,2,3,4,5,6,7,8,9,10]).
%%    [4,5,6,7]

%% > p18:slice(3,7, [1,2,3,4]).    
%% [4]

   slice(_S, _F, []) ->
     [];
   slice(S, F, L) ->
     impl_slice(S, F, L, []).
   impl_slice(0, 0, _L, R) ->
     R;
   impl_slice(_, _, [], R) ->
     R;
   impl_slice(S, F, [_H|T], R) when S > 0  ->
     impl_slice(S - 1, F, T, R);
   impl_slice(0, F, [H|T], R) ->
     impl_slice(0, F - 1, T, R++[H]).


%% >p19:rotate(3, [1,2,3,4,5,6,7]). 
%% [4,5,6,7,1,2,3]
%%    > p19:rotate(-3, [1,2,3,4,5,6,7]).
%%    [5,6,7,1,2,3,4]

   rotate(_N, []) ->
     [];
   rotate(N, L) ->
     impl_rotate(N, L, []).

   impl_rotate(0, _ ,R) ->
     R;
   
   %% impl_rotate(-1 ,_L , R) ->
   %%  R;

   impl_rotate(N, [H|T], _R) when N > 0 ->
     impl_rotate(N - 1, T ++[H], T++[H]);
   
   impl_rotate(N, [H|T], _) when N < 0 ->
     Last = lists:last([H|T]),
     Remainder = [H|T] -- [Last],
     impl_rotate(N+1, [Last]++Remainder, [Last]++Remainder). 

%% > p20:removeAt(3, [1,2,3,4,5,6]).
%%    {[1,2,3,5,6],4}

   removeAt(_N, []) ->
     [];
   removeAt(N, L) ->
     impl_removeAt(N, L, {[],0}).
   
   impl_removeAt(0, [H|T], {L,_}) ->
     {L++T, H};
   
   impl_removeAt(N, [H|T], {L,_}) ->
     impl_removeAt(N-1, T, {L++[H],0}).

%% > p21:insertAt(3, 2, [1,2,4,5,6]).
%% [1,2,3,4,5,6]

   insertAt(_, _, []) ->
    [];

   insertAt(Number, Position, List) ->
    impl_insertAt(Number, Position, List, []).

   impl_insertAt(Number, 0, List, Result) ->
     Result ++ [Number] ++ List;

   impl_insertAt(Number, Position, [Head|Tail], Result) ->
     impl_insertAt(Number, Position-1, Tail, Result ++ [Head]).
