%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Santa's Stable Puzzle
%
%by Jinzhe Li.
%2018/12/02
%
%The goal of this prolog program is that solving
%the Santa's stable puzzle. In this puzzle, there
%are six of the reindeer(Dasher,Prancer, Vixen,
%Comet, Blitzen, and Rudolf), which lives in one
%of the six areas numbered one to six from west
%to east, were taken for a ride by elves(Alabaster
%Snowball, Bushy Evergreen, Pepper Minstix, Shinny
%Upatree, Sugarplum Mary, and Wunorse Openslae).
%Each elf had made a number of toys(15, 14, 12, 10,
% 9, 7).
%
%Eight facts of this puzzle(from eclass):
% 1. Rudolf hangs out two or more areas to the east
%of Wunorse Openslae's reindeer.
% 2. The reindeer of the elf that made nine toys
%lives somewhere to the west of Alabaster Snowballs
%reindeer.
% 3. Three reindeer in consecutive areas, from west
%to east, are Dasher, Alabaster Snowball's reindeer,
%and the reindeer of the elf that made 12 toys.
% 4. The elf who rode Rudolf has made three toys
% more than the one who rode the reindeer in area 4,
%while Pepper Minstix made three toys more than
%Sugarplum Mary. All four elves mentioned here
%are unique.
% 5. Comet's rider made three toys more than Shinny
%Upatree, who in turn made two toys more than the elf
%who rode Vixen. The elf who rode Vixen is Shinny
%Upatree, Sugarplum Mary or Wunorse Onenslae.
% 6. Blitzen lives somewhere to the west of Bushy
%Evergreen's reindeer.
% 7. Alabaster Snowball made exactly one toy more than
%Wunorse Openslae.
% 8. Pepper Minstix didn't ride the reindeer from area 6.
%
%NOTE: The formatted answer to this puzzle is related to the
% font.
%
%
%Predicates:
%solution
%  area, reindeers, elves, toys
%  This is what the solution will be, all atoms here
%  are blank that will be filled in later except area.
%rule0(Solution)
%  Tell prolog Prancer, toys num of 15, 14, 10 and 7
%  exist(9, 12 and all other infomations are mentioned).
%  Note:
%  By read through each rule, one thing can be noticed
%  here is that things above are not mentioned in eight
%  rules. To reduce the run time of this program, this
%  predicate is created to tell prolog that Prancer,
%  some number of toys exists.
%rule1(Solution)
%  Rudolf's area is 2 or more to the east of
%  Wunorse's, which means, Wunorse's area plus 1
%  is still less than Rudolf's(1 to 6 is west to
%  east).
%rule2(Solution)
%  The elf that made 9 toys lives on the west of
%  Alabaster's reindeer.
%  So area of Alabaster's reindeer is greater than
%  area of the elf that made 9 toys.
%rule3(Solution)
%  Dasher, Alabaster's reindeer and reindeer of
%  the elf that made 12 toys are in consecutive
%  areas. So the area of them are n-1, n and n+1.
%rule4(Solution)
%  The elf who rode Rudolf made three more toys
%  than the one who rode the reindeer in area 4.
%  Pepper made three toys more than Sugarplum.
%  All four elves mentioned here are unique, but
%  the answer is correct without considering the
%  case that the elves could be repeated.
%rule5(Solution)
%  1st: The elf who rode Vixen is Shinny.
%  2nd: The elf who rode Vixen is Sugarplum.
%  3rd: The elf who rode Vixen is Wunorse.
%rule5Second(Solution)
%  Comet rider made three toys more than Shinny,
%  Shinny made two toys more than Vixen's rider.
%rule6(Solution)
%  Blitzen lives on the west of Bushy's reindeer.
%rule7(Solution)
%  Alabaster made one more toy than Wunorse.
%rule8(Solution)
%  Pepper's reindeer does not live in area 6.
%writeTitle
%  Print the title of formatted answer.
%writeItFormated([])
%  Print the formatted answer.
%solve
%  Solve the puzzle.
%
%NOTE: In writeTitle and writeItFormated([]),
%      the answer might not be formatted well
%      if the font was changed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%area, reindeers, elves, toys
solution([[1, _, _, _],  %1st area
          [2, _, _, _],  %2nd area
          [3, _, _, _],  %3rd area
          [4, _, _, _],  %4th area
          [5, _, _, _],  %5th area
          [6, _, _, _]]).%6th area

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tell prolog Prancer, toys num of 15, 14, 10
%and 7 exist(9, 12 and all other infomations
%are mentioned).
rule0(Solution) :-
    member([_, 'Prancer', _, _], Solution),
    member([_, _, _, 15], Solution),
    member([_, _, _, 14], Solution),
    member([_, _, _, 10], Solution),
    member([_, _, _, 7], Solution).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rudolf's area is 2 or more to the east of
%Wunorse's, which means, Wunorse's area plus 1
%is still less than Rudolf's(1 to 6 is west to
%east).
rule1(Solution) :-
    member([RudoArea, 'Rudolf', _, _], Solution),
    member([WunReindArea, _, 'Wunorse Openslae', _], Solution),
    RudoArea > WunReindArea + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The elf that made 9 toys lives on the west of
%Alabaster's reindeer.
%So area of Alabaster's reindeer is greater than
%area of the elf that made 9 toys.
rule2(Solution) :-
    member([MadeNineArea, _, _, 9], Solution),
    member([AlaRiderArea, _, 'Alabaster Snowball', _], Solution),
    MadeNineArea < AlaRiderArea.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dasher, Alabaster's reindeer and reindeer of
%the elf that made 12 toys are in consecutive
%areas. So the area of them are n-1, n and n+1.
rule3(Solution) :-
    member([DasherArea, 'Dasher', _, _], Solution),
    member([AlabReindArea, _, 'Alabaster Snowball', _], Solution),
    member([MadeTwelveArea, _, _, 12], Solution),
    DasherArea is AlabReindArea - 1,
    AlabReindArea is MadeTwelveArea - 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The elf who rode Rudolf made three more toys
%than the one who rode the reindeer in area 4.
%Pepper made three toys more than Sugarplum.
%All four elves mentioned here are unique, but
%the answer is correct without considering the
%case that the elves could be repeated.
rule4(Solution) :-
    member([_, 'Rudolf', _, RudoRiderToys], Solution),
    member([4, _, _, AreaFourRiderToys], Solution),
    member([_, _, 'Pepper Minstix', PepperToys], Solution),
    member([_, _, 'Sugarplum Mary', SugarToys], Solution),
    RudoRiderToys is AreaFourRiderToys + 3,
    PepperToys is SugarToys + 3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1st: The elf who rode Vixen is Shinny.
%2nd: The elf who rode Vixen is Sugarplum.
%3rd: The elf who rode Vixen is Wunorse.
rule5(Solution) :-
    member([_, 'Vixen', 'Shinny Upatree', _], Solution),
    rule5Second(Solution).

rule5(Solution) :-
    member([_, 'Vixen', 'Sugarplum Mary', _], Solution),
    rule5Second(Solution).

rule5(Solution) :-
    member([_, 'Vixen', 'Wunorse Openslae', _], Solution),
    rule5Second(Solution).

%Comet rider made three toys more than Shinny,
%Shinny made two toys more than Vixen's rider.
rule5Second(Solution) :-
    member([_, 'Comet', _, ComRiderToys], Solution),
    member([_, _, 'Shinny Upatree', ShinToys], Solution),
    member([_, 'Vixen', _, VixRiderToys], Solution),
    ComRiderToys is ShinToys + 3,
    ShinToys is VixRiderToys + 2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Blitzen lives on the west of Bushy's reindeer.
rule6(Solution) :-
    member([BliLives, 'Blitzen', _, _], Solution),
    member([BusReindLives, _, 'Bushy Evergreen', _], Solution),
    BliLives < BusReindLives.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Alabaster made one more toy than Wunorse.
rule7(Solution) :-
    member([_, _, 'Alabaster Snowball', AlaToys], Solution),
    member([_, _, 'Wunorse Openslae', WunToys], Solution),
    AlaToys is WunToys + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pepper's reindeer does not live in area 6.
rule8(Solution) :-
    member([PepReindLives, _, 'Pepper Minstix', _], Solution),
    PepReindLives \== 6.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Print the title of formatted answer.
writeTitle :-
    writef('%5l %10l %20l %5r', ['Area', 'Reindeer', 'Elf', 'Toys']),
    nl,
    writef('%5l %10l %20l %5r', ['----', '--------', '---', '----']),
    nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Print the formatted answer.
writeItFormated([]).
writeItFormated([First| A]) :-
    writef('%5l %10l %20l %5r', First),
    nl,
    writeItFormated(A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Solve the puzzle.
solve :-
    solution(S),
    rule0(S),
    rule1(S),
    rule2(S),
    rule3(S),
    rule4(S),
    rule5(S),
    rule6(S),
    rule7(S),
    rule8(S),
    writeTitle,
    writeItFormated(S).
