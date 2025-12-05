% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Benjamin Wong
%
% Documentation: none
%

% Query: ?- solve.

cadet(smith).
cadet(garcia).
cadet(jones).
cadet(chen).

sighting(cloud).
sighting(balloon).
sighting(kite).
sighting(fighter).

day(tues).
day(wed).
day(thurs).
day(fri).

notMember(_, []).
notMember(X, [H|T]) :-
    X \= H,
    notMember(X, T).

different([]).
different([H|T]) :-
    notMember(H, T),
    different(T).



solve :-

    cadet(TuesCadet),
    cadet(WedCadet),
    cadet(ThursCadet),
    cadet(FriCadet),
    different([TuesCadet, WedCadet, ThursCadet, FriCadet]),

    sighting(TuesObj),
    sighting(WedObj),
    sighting(ThursObj),
    sighting(FriObj),
    different([TuesObj, WedObj, ThursObj, FriObj]),

    Triples = [
        [tues,  TuesCadet,  TuesObj],
        [wed,   WedCadet,   WedObj],
        [thurs, ThursCadet, ThursObj],
        [fri,   FriCadet,   FriObj]
    ],

    % Smith did not see balloon or kite
    member([_, smith, SmithObj], Triples),
    SmithObj \= balloon,
    SmithObj \= kite,

    % kite was not seen by Garcia
    member([_, KiteCadet, kite], Triples),
    KiteCadet \= garcia,

    % fri sighting was chen or fighter
    member([fri, FriCadet, FriObj], Triples),
    (FriCadet = chen ; FriObj = fighter),

    % kite not on tues
    TuesObj \= kite,

    % Garcia and jones did not see balloon
    member([_, garcia, GarciaObj], Triples),
    GarciaObj \= balloon,
    member([_, jones, JonesObj], Triples),
    JonesObj \= balloon,

    % Jones did not make tues sighting
    TuesCadet \= jones,

    % Smith saw a cloud
    member([_, smith, cloud], Triples),

    % fighter was fri
    FriObj = fighter,

    % balloon wasnt wed
    WedObj \= balloon,

    % PRINT SOLUTION
    write('Tuesday:   '), write(TuesCadet), write(' saw '), write(TuesObj), nl,
    write('Wednesday: '), write(WedCadet), write(' saw '), write(WedObj), nl,
    write('Thursday:  '), write(ThursCadet), write(' saw '), write(ThursObj), nl,
    write('Friday:    '), write(FriCadet), write(' saw '), write(FriObj), nl, nl,

    fail.

solve.
