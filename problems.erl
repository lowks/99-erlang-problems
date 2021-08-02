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
