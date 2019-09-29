/*
    Problema de los relojes de arena
    Ivan Prada Cazalla & David Mallasen Quintana
*/


% El reloj de la izquierda sera el de 7 minutos y el de la derecha el de 11

% estado(ArenaIzquierdo,ArenaDerecho)
    % ArenaIzquierdo es la arena que hay en la parte de abajo del reloj izquierdo
    % ArenaDerecho es la arena que hay en la parte de abajo del reloj derecho

% Estado inicial
inicial(estado(7,11)).

%Estados objetivos
objetivo(estado(3,_)). % Conseguimos 3 en la parte inferior del reloj de 7 minutos
objetivo(estado(4,_)). % Conseguimos 3 en la parte superior del reloj de 7 minutos
objetivo(estado(_,3)). % Conseguimos 3 en la parte inferior del reloj de 11 minutos
objetivo(estado(_,8)). % Conseguimos 3 en la parte superior del reloj de 11 minutos

% Operadores
% movimiento(EstadoInicial, EstadoObjetivo, Operador, TiempoQueTarda).
movimiento(estado(I, D), estado(IF, D), girarIzquierda, 0) :- 
    IF is 7 - I.
movimiento(estado(I, D), estado(I, DF), girarDerecha, 0) :- 
    DF is 11 - D.
movimiento(estado(I, D), estado(IF, DF), dejarCaer, Tiempo) :- 
    IF is min(7 - I, 11 - D) + I, 
    DF is min(7 - I, 11 - D) + D,
    Tiempo is min(7 - I, 11 - D).

% Busqueda de la solucion
% puede(Estado, EstadosVisitados, Operadores, TiempoAcumulado).
puede(Estado, _ , [], 0) :- 
    objetivo(Estado).
puede(Estado, Visitados, [Operador|Operadores], Tiempo) :- 
    movimiento(Estado, Estadoi, Operador, T1),
    \+member(Estadoi,Visitados),
    puede(Estadoi, [Estadoi|Visitados], Operadores, T2),
    Tiempo is T1 + T2.

% Consulta
consulta :- 
    inicial(Estado),
    puede(Estado, [Estado], Operadores, Tiempo),
    write('Solucion encontrada sin repeticion de estados: '),
    nl, 
    write(Operadores),
    nl,
    write('Se ha tardado: '),
    write(Tiempo),
    write(' minutos.').