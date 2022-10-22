
:-dynamic fichasPozo/1.
:-dynamic fichasMias/1.
:-dynamic fichasTablero/1.
:-dynamic contadorRival/1.
:-dynamic tablero/1.

%ficha(Id,Num,Estado).

limpiar_juego:-
    retract(fichasPozo(_)),
    retract(fichasMias(_)),
    retract(fichasTablero(_)),
    retract(contadorRival(_)),
    retract(tablero(_)),
    fail.
limpiar_juego.

contarFichasMias(X):-
    aggregate_all(count,fichasMias(ficha(_,[_|_])),X).

contarFichasRival(X):-
    aggregate_all(count,contadorRival(_),X).

iniciarTren():-
    asserta(tablero([])).

revolverFichas:- %este metodo va poner todas las fichas en fichasPozo
 asserta(fichasPozo(ficha(1,[0,0]))),
 asserta(fichasPozo(ficha(2,[0,1]))),
 asserta(fichasPozo(ficha(3,[0,2]))),
 asserta(fichasPozo(ficha(4,[0,3]))),
 asserta(fichasPozo(ficha(5,[0,4]))),
 asserta(fichasPozo(ficha(6,[0,5]))),
 asserta(fichasPozo(ficha(7,[0,6]))),
 asserta(fichasPozo(ficha(8,[1,1]))),
 asserta(fichasPozo(ficha(9,[1,2]))),
 asserta(fichasPozo(ficha(10,[1,3]))),
 asserta(fichasPozo(ficha(11,[1,4]))),
 asserta(fichasPozo(ficha(12,[1,5]))),
 asserta(fichasPozo(ficha(13,[1,6]))),
 asserta(fichasPozo(ficha(14,[2,2]))),
 asserta(fichasPozo(ficha(15,[2,3]))),
 asserta(fichasPozo(ficha(16,[2,4]))),
 asserta(fichasPozo(ficha(17,[2,5]))),
 asserta(fichasPozo(ficha(18,[2,6]))),
 asserta(fichasPozo(ficha(19,[3,3]))),
 asserta(fichasPozo(ficha(20,[3,4]))),
 asserta(fichasPozo(ficha(21,[3,5]))),
 asserta(fichasPozo(ficha(22,[3,6]))),
 asserta(fichasPozo(ficha(23,[4,4]))),
 asserta(fichasPozo(ficha(24,[4,5]))),
 asserta(fichasPozo(ficha(25,[4,6]))),
 asserta(fichasPozo(ficha(26,[5,5]))),
 asserta(fichasPozo(ficha(27,[5,6]))),
 asserta(fichasPozo(ficha(28,[6,6]))).

%inserta ficha en fichasMias y la quita de fichasPozo
robaFicha(Id):-
    asserta(fichasMias(ficha(Id,_))),
    retract(fichasPozo(ficha(Id,_))).

comparaTablero(Id):-
    fichasMias(ficha(Id,[N1|N2])),
    tablero([X|Y]),
    N1=:=X,
    retract(tablero(ficha(Id,[X|Y]))),
    asserta(tablero(ficha(Id,[N2|Y]))).
comparaTablero(Id):-
    fichasMias(ficha(Id,[N1|N2])),
    tablero([X|Y]),
    N1=:=Y,
    retract(tablero(lista([X|Y]))),
    asserta(tablero(lista([X|N2]))).
comparaTablero(Id):-
    fichasMias(ficha(Id,[N1|N2])),
    tablero(lista([X|Y])),
    N2=:=X,
    retract(tablero(lista([X|Y]))),
    asserta(tablero(lista([N1|Y]))).
comparaTablero(Id):-
    fichasMias(ficha(Id,[N1|N2])),
    tablero(lista([X|Y])),
    N2=:=Y,
    retract(tablero(lista([X|Y]))),
    asserta(tablero(lista([X|N1]))).

heuristica(X,Y,Val):-
    contarFichasMias(X),
    contarFichasRival(Y),
    N is X,
    M is Y,
    Val is 1-N/(N+M).

%pendiente los pon Ficha
ponFicha(Id):-
    asserta(fichasTablero(ficha(Id,_))),
    retract(fichasMias(ficha(Id,_))).
    %comparaTablero(Id).

%no toma parametros porque solo queremos que actualice un contador
robaRival():-
    asserta(contadorRival(1)).

juegaRival(Id):-
    asserta(fichasTablero(ficha(Id,_))),
    %comparaTablero(Id),
    retract(fichasPozo(ficha(Id,_))),
    retract(contadorRival(1)).

%este metodo inicia el juego, es la asignacion inicial de fichas
fichasIniciales:-
    write('Dime id ficha 1'),
    write('\n'),
    read(Id1),
    robaFicha(Id1),
    write('Dime id ficha 2'),
    write('\n'),
    read(Id2),
    robaFicha(Id2),
    write('Dime id ficha 3'),
    write('\n'),
    read(Id3),
    robaFicha(Id3),
    write('Dime id ficha 4'),
    write('\n'),
    read(Id4),
    robaFicha(Id4),
    write('Dime id ficha 5'),
    write('\n'),
    read(Id5),
    robaFicha(Id5),
    write('Dime id ficha 6'),
    read(Id6),
    write('\n'),
    robaFicha(Id6),
    write('Dime id ficha 7'),
    read(Id7),
    write('\n'),
    robaFicha(Id7),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)),
    asserta(contadorRival(1)).

main:-
   iniciarTren(),
   revolverFichas,
   fichasIniciales.









