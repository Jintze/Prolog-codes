%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The Rock, Paper, Scissors Game.
%
%by Jinzhe Li.
%2018/11/22
%
%A rock, paper, scissors game, which has two players.
%The game have a total of 10 rounds.
%One of the player is user, the other player is computer.
%
%Enter "play." to start the game.
%Firstly prompt the welcome message, then
%computer will make its random choice.
%Then prompt round message and get user inputs,
%if the first letter is r, p or s, which corresponding
%to rock, paper and scissors, then the input is valid.
%
%NOTE: inputs must end with a dot: ".". e.g.: rock.
%NOTE: if inputs start with an upper case, then this
%      input must be in the double quote. e.g.: "Rock".
%
%Each round the program will prompt the result of game:
%user wins, computer wins, or tie game.
%When player finish a total of 10 rounds,
%this program tells the user wins how many times,
%lose how many times, and how many times the game ties.
%Who wins more round is the winner, if the number of two
%wins the same number of round, print winner is nobody.
%
%Predicates:
%play
%    start the game
%play(N, W, L, T, _)
%    play N rounds
%prevChoice(N)
%    Tracks the previous choice
%printWelcomeMsg
%    Print the welcome message for playing the game
%printRoundMsg
%    Print message for every round
%getInput
%    Get user's input and get the first letter from list
%    which made by getFirst.
%getFirst
%    Make the list.
%invalidPrompt
%    Decide if the input is valid.
%whoWins
%    Decide who is the winner.
%winPlus
%losePlus
%tiePlus
%    Count who wins how many times.
%playOrNot
%    Decide if the game continues.
%winnerIs
%    Prompt who wins how many times and who is the
%    final winner.

:- dynamic(prevChoice/2).

choice([114, 112, 115]). %rock, paper, scissors in ASCII
upperCaseChoice([82, 80, 83]). %Rock, Paper, Scissors in ASCII

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize and start game play.
play :-
    printWelcomeMsg,
    play(1, 0, 0, 0, _). %set the number of round, user wins,
                         %computer wins and tie game

play(N, W, L, T, _) :-
    getRandom,
    printRoundMsg,
    getInput(N, W, L, T, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get computer's random choice
%Note: the code in getRandom is from simpleGame by J. Mohr
%and adaptions by R. Heise
getRandom :-
    retractall(prevChoice(_)),
    RandNum is random(3), %pick rock, paper or scissors
    choice(Letters),
    nth0(RandNum, Letters, RandomChoice),
    assert(prevChoice(RandomChoice)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print the welcome message for playing the game.
printWelcomeMsg :-
    nl,
    write('Welcome to ROCK PAPER SCISSORS game'),
    nl,
    write('-----------------------------------'),
    nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Print the input instruction of every rounds for playing the game.
printRoundMsg :-
    nl,
    write('Please enter your choice: "Rock", "Paper", or "Scissors"  ').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Get user's input, convert it to list(getFirst)
%and get the first letter from list.

getInput(N, W, L, T, Char) :-
	read(Char),
	string_to_list(Char, B),
        getFirst(B, First),
        invalidPrompt(N, W, L, T, First).

getFirst([A| _], A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1st: if the first element in list is lower
%case letter, call whoWins
%2nd: if the first element in list is upper
%case letter, call whoWins
%3rd: if the first element in list is not a
%valid input, prompt to input again.
invalidPrompt(N, W, L, T, First) :-
    choice(Letters),
    member(First, Letters),
    whoWins(N, W, L, T, First).

invalidPrompt(N, W, L, T, First) :-
    upperCaseChoice(Letters),
    member(First, Letters),
    First2 is First,
    First1 is First2 + 32, %by adding 32, uppercase becomes lower case in ASCII
    whoWins(N, W, L, T, First1).

invalidPrompt(N, W, L, T, _) :-
    write('Not sure of your selection. Try again.'),
    play(N, W, L, T, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1st: user inputs rock and it is a tie game
%2nd: user inputs paper and it is a tie game
%3rd: user inputs scissors and it is a tie game
%4th: user inputs rock and user wins
%5th: user inputs paper and user wins
%6th: user inputs scissors and user wins
%7th: user inputs scissors and computer wins
%8th: user inputs rock and computer wins
%9th: user inputs paper and computer wins

whoWins(N, W, L, T, First) :-
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    First == 114,
    First == ComputerChoice,
    write('You entered ROCK Computer chose ROCK  '),
    write('  TIE'),
    nl,
    tiePlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    First == 112,
    First == ComputerChoice,
    write('You entered PAPER Computer chose PAPER  '),
    write('  TIE'),
    nl,
    tiePlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    First == 115,
    First == ComputerChoice,
    write('You entered SCISSORS Computer chose SCISSORS  '),
    write('  TIE'),
    nl,
    tiePlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    First == 114,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 115,
    write('You entered ROCK Computer chose SCISSORS  '),
    write('  Winner is YOU'),
    nl,
    winPlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    First == 112,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 114,
    write('You entered PAPER Computer chose ROCK  '),
    write('  Winner is YOU'),
    nl,
    winPlus(N, W, L, T, _).


whoWins(N, W, L, T, First) :-
    First == 115,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 112,
    write('You entered SCISSORS Computer chose PAPER  '),
    write('  Winner is YOU'),
    nl,
    winPlus(N, W, L, T, _).


whoWins(N, W, L, T, First) :-
    First == 115,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 114,
    write('You entered SCISSORS Computer chose ROCK  '),
    write('  Winner is COMPUTER'),
    nl,
    losePlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    First == 114,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 112,
    write('You entered ROCK Computer chose PAPER  '),
    write('  Winner is COMPUTER'),
    nl,
    losePlus(N, W, L, T, _).

whoWins(N, W, L, T, First) :-
    First == 112,
    prevChoice(RandomChoice),
    ComputerChoice is RandomChoice,
    ComputerChoice == 115,
    write('You entered PAPER Computer chose SCISSORS  '),
    write('  Winner is COMPUTER'),
    nl,
    losePlus(N, W, L, T, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%after the winner is determined, add 1 to the
%count of user's win times, lose times and tie
%times, which is W for win, L for lose, T for tie
%1st: times of user's win + 1
%2nd: times of user's lose + 1
%3rd: times of tie games + 1
winPlus(N, W, L, T, _) :-
    W1 is W + 1,
    playOrNot(N, W1, L, T, _).

losePlus(N, W, L, T, _) :-
    L1 is L + 1,
    playOrNot(N, W, L1, T, _).

tiePlus(N, W, L, T, _) :-
    T1 is T + 1,
    playOrNot(N, W, L, T1, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Decide if the game has meet the goal of 10 rounds
%1st: if the game is done, indicate it and give
%a tally of who won how many rounds.
%2nd: the game is not done, play next round.
playOrNot(N, W, L, T, _) :-
    N == 10,
    nl,
    write('Game Over! You won '),
    write(W),
    write(' rounds, computer won '),
    write(L),
    write(' rounds, tied '),
    write(T),
    write(' rounds'),
    nl,
    winnerIs(W, L).

playOrNot(N, W, L, T, _) :-
    N \== 10,
    N1 is N + 1,
    play(N1, W, L, T, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%State who is the final winner.
%1st: computer is winner.
%2nd: user is winner.
%3rd: tie game, nobody is winner.
winnerIs(W, L) :-
    W < L,
    write('Champion: COMPUTER').

winnerIs(W, L) :-
    W > L,
    write('Champion: YOU').

winnerIs(W, L) :-
    W == L,
    write('Champion: NOBODY').
