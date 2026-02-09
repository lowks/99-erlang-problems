-module(problems).
-export([my_last/1, penultimate/1, kth/2, len/1, reverse/1, is_palindrome/1,
         flatten/1, compress/1, pack/1, encode/1, encodeModified/1,
         decode/1, encodeDirect/1, duplicate/1, duplicateN/2, drop/2,
         split/2, slice/3, rotate/2, removeAt/2, insertAt/3, range/2,
         randomSelect/2, lotto/2, randomPermute/1, combinations/2]).

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

 penultimate([H, _T]) ->
  H;
 penultimate([_H|T]) ->
  penultimate(T).

%% > p03:kth([0, 1, 2, 3], 2).
%% 1

 kth([], _L) -> 
   nil;
 kth([H|_T], 1) ->
   H;
 kth([_H|T], L) ->
   kth(T, L - 1). 

%% > p04:len([1,2,3]).
%% 3

 len(L) -> length(L).

%% > p05:reverse([1,2,3,4,5]).
%% 5

  reverse([]) ->
    [];
  reverse(L) ->
    reverse_impl(L, []).
  reverse_impl([H|T], L2) ->
    reverse_impl(T, [H|L2]);
  reverse_impl([], L2) ->
    L2.

%% > p06:is_palindrome([1,2,3,2,1]).
%% true

  is_palindrome([]) ->
     true;
  is_palindrome(L) ->
     reverse(L) == L. 

%% > p07:flatten([1,2,[3,[4,[5,6]]]]).
%% [1,2,3,4,5,6]

  flatten(L) ->
    reverse(impl_flatten(L, [])).
  impl_flatten([], Acc) ->
    Acc;
  impl_flatten([H|T], Acc) when is_list(H) ->
    impl_flatten(T, impl_flatten(H, Acc));
  impl_flatten([H|T], Acc) ->
    impl_flatten(T, [H|Acc]).

%% > p08:compress([1,1,1,1,2,2,2,3,3,3,3,]).
%% [1,2,3]

   compress([]) ->
     [];
   compress([H|T]) ->
     reverse(impl_compress(T, H, [H])).
   impl_compress([], _, Acc) ->
     Acc;
   impl_compress([H|T], H, Acc) ->
     impl_compress(T, H, Acc);
   impl_compress([H|T], _, Acc) ->
     impl_compress(T, H, [H|Acc]).
   
%% > p09:pack(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%%  [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

   pack([]) ->
     [];
   pack([H|T]) ->
     reverse(impl_pack(T, [H], [])).
   impl_pack([], Current, Acc) ->
     [Current|Acc];
   impl_pack([H|T], [H|_] = Current, Acc) ->
     impl_pack(T, [H|Current], Acc);
   impl_pack([H|T], Current, Acc) ->
     impl_pack(T, [H], [Current|Acc]).

%% > p10:encode(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%%    [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

   encode(L) ->
     reverse(impl_encode(pack(L), [])).
   impl_encode([], Acc) ->
     Acc;
   impl_encode([H|T], Acc) ->
     impl_encode(T, [{length(H), hd(H)} | Acc]).

%% > p11:encodeModified(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]

   encodeModified(L) ->
     reverse(impl_encodeModified(encode(L), [])).
   impl_encodeModified([], Acc) ->
     Acc;
   impl_encodeModified([{1, E}| T], Acc) ->
     impl_encodeModified(T, [E|Acc]);
   impl_encodeModified([{N, E}| T], Acc) ->
     impl_encodeModified(T, [{N, E}|Acc]).

%% > p12:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%%    [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

   decode(L) ->
     impl_decode(L, []).
   impl_decode([], Acc) ->
     reverse(Acc);
   impl_decode([{0, _} | T], Acc) ->
     impl_decode(T, Acc);
   impl_decode([{N, E} | T], Acc) ->
     impl_decode([{N - 1, E} | T], [E|Acc]).

%% > p13:encodeDirect(['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']).
%% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

   encodeDirect([]) ->
     [];
   encodeDirect([H|T]) ->
     reverse(impl_encodeDirect(T, {1, H}, [])).
   impl_encodeDirect([], {Count, Element}, Acc) ->
     [{Count, Element} | Acc];
   impl_encodeDirect([H|T], {Count, H}, Acc) ->
     impl_encodeDirect(T, {Count + 1, H}, Acc);
   impl_encodeDirect([H|T], Last, Acc) ->
     impl_encodeDirect(T, {1, H}, [Last | Acc]).





%% > p14:duplicate([1,2,3,4]).   
%%  [1,1,2,2,3,3,4,4]

   duplicate(L) ->
     reverse(impl_duplicate(L, [])).
   impl_duplicate([], Acc) ->
     Acc;
   impl_duplicate([H|T], Acc) ->
     impl_duplicate(T, [H, H | Acc]).

%% > p15:duplicateN(3, ['a','b','c']).
%%    [a,a,a,b,b,b,c,c,c]

   duplicateN(N, L) ->
     reverse(impl_duplicateN(N, L, [])).
   impl_duplicateN(_, [], Acc) ->
     Acc;
   impl_duplicateN(N, [H|T], Acc) ->
     impl_duplicateN(N, T, impl_duplicateN_add(N, H, Acc)).

   impl_duplicateN_add(0, _, Acc) ->
     Acc;
   impl_duplicateN_add(N, H, Acc) ->
     impl_duplicateN_add(N - 1, H, [H | Acc]).

%% > p16:drop(3, [1,2,3,4,5,6,7,8]).
%% [1,2,4,5,7,8]

   drop(N, L) ->
     reverse(impl_drop(L, N, 1, [])).
   impl_drop([], _, _, Acc) ->
     Acc;
   impl_drop([_H|T], N, N, Acc) ->
     impl_drop(T, N, 1, Acc);
   impl_drop([H|T], N, K, Acc) ->
     impl_drop(T, N, K + 1, [H | Acc]).

%% > p17:split(3, [1,2,3,4,5,6,7]).
%% [[1,2,3],[4,5,6,7]]     

   split(N, L) ->
     impl_split(L, N, []).
   impl_split(T, 0, Acc) ->
     [reverse(Acc), T];
   impl_split([H|T], N, Acc) when N > 0 ->
     impl_split(T, N - 1, [H | Acc]);
   impl_split(L, _, Acc) ->
     [reverse(Acc), L].

%% > p18:slice(3,7, [1,2,3,4,5,6,7,8,9,10]).
%%    [3,4,5,6,7]

   slice(L, I, K) ->
     reverse(impl_slice(L, I, K, 1, [])).
   impl_slice([], _, _, _, Acc) ->
     Acc;
   impl_slice([H|T], I, K, Curr, Acc) when Curr >= I, Curr =< K ->
     impl_slice(T, I, K, Curr + 1, [H | Acc]);
   impl_slice([_H|T], I, K, Curr, Acc) when Curr < I ->
     impl_slice(T, I, K, Curr + 1, Acc);
   impl_slice(_, _, _, _, Acc) ->
     Acc.


%% >p19:rotate(3, [1,2,3,4,5,6,7]). 
%% [4,5,6,7,1,2,3]
%%    > p19:rotate(-3, [1,2,3,4,5,6,7]).
%%    [5,6,7,1,2,3,4]

   rotate(N, L) ->
     Len = length(L),
     case Len of
       0 -> [];
       _ ->
         N1 = N rem Len,
         N2 = if N1 < 0 -> N1 + Len; true -> N1 end,
         [L1, L2] = split(N2, L),
         L2 ++ L1
     end.

%% > p20:removeAt(3, [1,2,3,4,5,6]).
%%    {[1,2,4,5,6],3}

   removeAt(N, L) ->
     impl_removeAt(L, N, []).
   impl_removeAt([H|T], 1, Acc) ->
     {reverse(Acc) ++ T, H};
   impl_removeAt([H|T], N, Acc) when N > 1 ->
     impl_removeAt(T, N - 1, [H | Acc]);
   impl_removeAt(L, _, Acc) ->
     {reverse(Acc) ++ L, nil}.

%% > p21:insertAt(3, 2, [1,2,4,5,6]).
%% [1,2,3,4,5,6]

   insertAt(E, N, L) ->
     impl_insertAt(L, N, E, []).
   impl_insertAt(L, 1, E, Acc) ->
     reverse(Acc) ++ [E | L];
   impl_insertAt([H|T], N, E, Acc) when N > 1 ->
     impl_insertAt(T, N - 1, E, [H | Acc]);
   impl_insertAt([], _, E, Acc) ->
     reverse([E | Acc]).

%% > p22:range(3, 7).
%%    [3,4,5,6,7]

   range(I, K) when I =< K ->
     impl_range(I, K, []);
   range(I, K) ->
     reverse(impl_range(K, I, [])).

   impl_range(K, K, Acc) ->
     reverse([K | Acc]);
   impl_range(I, K, Acc) ->
     impl_range(I + 1, K, [I | Acc]).


%% > p23:randomSelect(3, [1,2,3,4,5,6,7,8]).
%% [3,6,2]

   randomSelect(N, L) ->
     impl_randomSelect(N, L, []).
   impl_randomSelect(0, _, Acc) ->
     Acc;
   impl_randomSelect(N, L, Acc) ->
     Len = length(L),
     case Len of
       0 -> Acc;
       _ ->
         {L1, E} = removeAt(rand:uniform(Len), L),
         impl_randomSelect(N - 1, L1, [E | Acc])
     end.


%% > p24:lotto(3, 49).
%%    [38,43,20]

    lotto(_, 0) ->
      [];
    
    lotto(Number, Totalnumber) ->
      randomSelect(Number, range(1, Totalnumber)).

%% > p25:randomPermute([1,2,3,4,5,6,7]).
%%    [3,1,5,4,6,7,2]

    randomPermute([]) ->
      [];
    randomPermute(L) ->
      randomSelect(length(L), L).

%% > p26:combinations(2, [1,2,3,4]).                           
%%    [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]

    combinations(0, _) ->
      [[]];
    combinations(_, []) ->
      [];
    combinations(N, [H|T]) ->
      [[H | C] || C <- combinations(N - 1, T)] ++ combinations(N, T).

    
    
