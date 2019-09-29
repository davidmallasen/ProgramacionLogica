% Procesamiento de Lenguaje Natural
%
% David Mallasen Quintana & Ivan Prada Cazalla
%
% Usar DCGs en SWI Prolog para convertir frases expresadas en estilo directo a
% estilo indirecto y viceversa. El modulo leera una frase introducida como lista
% de palabras en uno de los dos estilos (que tendra que averiguar), analizara su
% correccion (concordancias de gener, numero y persona) y producira como salida
% la frase equivalente en el estilo contrario. Estara continuamente leyendo
% frases de entrada y produciendo las frases de salida correspondientes hasta
% que lea una frase vacia y entonces parara.
%
% Uso: ?- consulta.

% ========== Ejemplos ==========
/*

?- consulta.
Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [maria, me, dijo, :, '"', juan, es, mi, amigo, '"'].
[maria,me,dijo,que,juan,era,su,amigo]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [maria, me, dijo, que, juan, era, su, amigo].
[maria,me,dijo,:,",juan,es,mi,amigo,"]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [miguel, me, dijo, :, '"', estoy, contento, de, verte, '"'].
[miguel,me,dijo,que,estaba,contento,de,verme]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [miguel, me, dijo, que, estaba, contento, de, verme].
[miguel,me,dijo,:,",estoy,contento,de,verte,"]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [lucia, me, dijo, :, '"', necesito, un, cambio, en, mi, vida, '"'].
[lucia,me,dijo,que,necesitaba,un,cambio,en,su,vida]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [lucia, me, dijo, que, necesitaba, un, cambio, en, su, vida].
[lucia,me,dijo,:,",necesito,un,cambio,en,mi,vida,"]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [luis, me, pregunto, :, '"', '¿', estas, ocupada, esta, noche, '?', '"'].
[luis,me,pregunto,que,si,estaba,ocupada,esa,noche]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [luis, me, pregunto, que, si, estaba, ocupada, esa, noche].
[luis,me,pregunto,:,",¿,estas,ocupada,esta,noche,?,"]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [].
final.
true .


?- consulta.
Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [juan, me, dijo, que, maria, era, su, amiga].
[juan,me,dijo,:,",maria,es,mi,amiga,"]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [miguel, me, pregunto, :, '"', '¿', estas, afortunada, esta, mesa, '?', '"'].
[miguel,me,pregunto,que,si,estaba,afortunada,esa,mesa]

Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [].
final.
true .


?- consulta.
Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [lucia, me, dijo, que, necesitaba, un, cambios, en, su, vida].

false.


?- consulta.
Escribe la frase entre corchetes separando palabras con comas 
o lista vacia para parar 
|: [miguel, me, dijo, :, '"', estamos, contento, de, verte, '"'].

false.


*/
% ========== Gramatica ==========

% Reconocimiento y comprobacion de concordancia de las frases introducidas.
% Se encarga tambien de reconocer si la frase esta en estilo directo/indirecto y afirmativo/interrogativo.
frase(Salida) --> 
    gn(Suj, _, Num, Pers), % Representacion del sujeto e informacion de concordancia
    [me], verbo(Inf, Tiempo, Pers, Num), % Representacion de la raiz, concordancia y tiempo verbal
    [que], subord_sust(SalidaSubSust), % Representacion de la subordinada sustantiva, devuelve por el ultimo parametro la transformada
    {componerFrase(Salida, Suj, Inf, Tiempo, Pers, Num, SalidaSubSust, indirecto, afirmativo)}.

frase(Salida) -->
    gn(Suj, _, Num, Pers),
    [me], verbo(Inf, Tiempo, Pers, Num),
    [:, '"'], subord_sust(SalidaSubSust), ['"'],
    {componerFrase(Salida, Suj, Inf, Tiempo, Pers, Num, SalidaSubSust, directo, afirmativo)}.

frase(Salida) -->
    gn(Suj, _, Num, Pers),
    [me], verbo(Inf, Tiempo, Pers, Num),
    [que, si], subord_sust(SalidaSubSust), 
    {componerFrase(Salida, Suj, Inf, Tiempo, Pers, Num, SalidaSubSust, indirecto, interrogativo)}.

frase(Salida) -->
    gn(Suj, _, Num, Pers),
    [me], verbo(Inf, Tiempo, Pers, Num),
    [:, '"', '¿'], subord_sust(SalidaSubSust), ['?', '"'],
    {componerFrase(Salida, Suj, Inf, Tiempo, Pers, Num, SalidaSubSust, directo, interrogativo)}.


% Reconocimiento y comprobacion de concordancia de las subordinadas sustantivas 
subord_sust(Salida) --> % Ejemplo: Juan era su amigo
    gn(Suj, Gen, Num, PersSuj), 
    verbo(Inf, Tiempo, PersSuj, Num), 
    atributo(SalidaAtr, _, Num, Gen), 
    {componerSubSuj(Salida, Suj, Inf, Tiempo, PersSuj, Num, SalidaAtr)}. 

subord_sust(Salida) --> % Ejemplo: (él) estaba contento de verme
    verbo(Inf, Tiempo, Pers, Num), 
    atributo(SalidaAtr, Pers, Num, _), 
    cc_causa(SalidaCC),
    {componerSubCC(Salida, Inf, Tiempo, Pers, Num, SalidaAtr, SalidaCC)}.

subord_sust(Salida) --> % Ejemplo: (él) necesitaba un cambio en su vida
    verbo(Inf, Tiempo, Pers, Num), 
    compl_directo(SalidaCD), 
    cc_lugar(Pers, Num, SalidaCC), 
    {componerSubCC(Salida, Inf, Tiempo, Pers, Num, SalidaCD, SalidaCC)}.

subord_sust(Salida) --> % Ejemplo: (tú) estás ocupada esta noche
    verbo(Inf, Tiempo, Pers, Num), 
    atributo(SalidaAtr, Pers, Num, _),
    cc_tiempo_dem(GenDem, NumDem, Nivel, Nombre), 
    {componerSubCC2(Salida, Inf, Tiempo, Pers, Num, SalidaAtr, GenDem, NumDem, Nivel, Nombre)}.


% Grupo Nominal
gn([Suj], Gen, s, terc) --> nombre_propio(Suj, Gen).



atributo([DetP, Nombre], Pers, Num, Gen) --> % Ejemplo: su amigo
    determinante_posesivo(Pers, Num, Gen, DetP), 
    nombre(Nombre, Gen, Num).

atributo([Adj], _, _, _) --> adjetivo(Adj, _, _). % Ejemplo: contento, ocupada 


% Complementos
cc_causa([Prep, V]) --> % Ejemplo: de verme
    preposicion(Prep), 
    verbo_compl_ind(V).



compl_directo([Art, Nombre]) --> % Ejemplo: un cambio
    articulo(Gen, Num, Art), 
    nombre(Nombre, Gen, Num). 



cc_lugar(Pers, Num, [en, DetP, Nombre]) --> % Ejemplo: en su vida
    [en], 
    determinante_posesivo(Pers, Num, _, DetP), 
    nombre(Nombre, _, Num). 



cc_tiempo_dem(Gen, Num, Nivel, Nombre) --> % Ejemplo: esa noche
    demostrativo(Gen, Num, Nivel),
    nombre(Nombre, Gen, Num).


% Reconocimiento de palabras atomicas de las frases.
nombre_propio(X, Gen) --> 
    [X], 
    {es_nombre_propio(X, Gen)}.

nombre(X, Gen, Num) --> 
    [X], 
    {es_nombre(X, Gen, Num)}.

verbo(Inf, Tiempo, Pers, Num) --> 
    [X], 
    {es_verbo(X, Inf, Tiempo, Pers, Num)}.

determinante_posesivo(Pers, Num, Gen, Cambio) --> 
    [X], 
    {es_determinante_posesivo(X, Pers, Num, Gen, Cambio)}.

adjetivo(X, Gen, Num) --> 
    [X], 
    {es_adjetivo(X, Gen, Num)}.

articulo(Gen, Num, X) --> 
    [X], 
    {es_articulo(X, Gen, Num)}.

preposicion(X) --> 
    [X], 
    {es_preposicion(X)}.

verbo_compl_ind(Cambio) --> 
    [X], 
    {
        atom_concat(Inf, Term, X),
        es_infinitivo(Inf),
        es_terminacion_compl_ind(Term, prim, Num),
        es_terminacion_compl_ind(TermSal, seg, Num),
        atom_concat(Inf, TermSal, Cambio)
    }.
verbo_compl_ind(Cambio) --> 
    [X], 
    {
        atom_concat(Inf, Term, X),
        es_infinitivo(Inf),
        es_terminacion_compl_ind(Term, seg, Num),
        es_terminacion_compl_ind(TermSal, prim, Num),
        atom_concat(Inf, TermSal, Cambio)
    }.

demostrativo(Gen, Num, Nivel) --> 
    [X], 
    {es_demostrativo(X, Gen, Num, Nivel)}.


% ========== Reglas auxiliares ==========
% Reglas encargadas de componer las frases segun lo analizado por la gramatica.

componerFrase(Salida, GN, Inf, Tiempo, Pers, Num, SalidaSubSust, indirecto, afirmativo) :-
    es_verbo(V, Inf, Tiempo, Pers, Num),
    append([GN, [me, V, :, '"'], SalidaSubSust, ['"']], Salida).

componerFrase(Salida, GN, Inf, Tiempo, Pers, Num, SalidaSubSust, directo, afirmativo) :-
    es_verbo(V, Inf, Tiempo, Pers, Num),
    append([GN, [me, V, que], SalidaSubSust], Salida).

componerFrase(Salida, GN, Inf, Tiempo, Pers, Num, SalidaSubSust, indirecto, interrogativo) :-
    es_verbo(V, Inf, Tiempo, Pers, Num),
    append([GN, [me, V, :, '"', '¿'], SalidaSubSust, ['?', '"']], Salida).

componerFrase(Salida, GN, Inf, Tiempo, Pers, Num, SalidaSubSust, directo, interrogativo) :-
    es_verbo(V, Inf, Tiempo, Pers, Num),
    append([GN, [me, V, que, si], SalidaSubSust], Salida).



componerSubSuj(Salida, GN, Inf, presente, Pers, Num, SalidaAtr) :-
    es_verbo(V, Inf, preterito_imperfecto, Pers, Num),
    append([GN, [V], SalidaAtr], Salida).

componerSubSuj(Salida, GN, Inf, preterito_imperfecto, Pers, Num, SalidaAtr) :-
    es_verbo(V, Inf, presente, Pers, Num),
    append([GN, [V], SalidaAtr], Salida).



componerSubCC(Salida, Inf, presente, prim, Num, Salida2, SalidaCC) :-
    es_verbo(V, Inf, preterito_imperfecto, terc, Num),
    append([[V], Salida2, SalidaCC], Salida).

componerSubCC(Salida, Inf, preterito_imperfecto, terc, Num, Salida2, SalidaCC) :-
    es_verbo(V, Inf, presente, prim, Num),
    append([[V], Salida2, SalidaCC], Salida).

componerSubCC2(Salida, Inf, presente, seg, Num, SalidaAtr, GenDem, NumDem, prim, Nombre) :-
    es_verbo(V, Inf, preterito_imperfecto, prim, Num),
    es_demostrativo(Dem, GenDem, NumDem, seg),
    append([[V], SalidaAtr, [Dem, Nombre]], Salida).

componerSubCC2(Salida, Inf, preterito_imperfecto, prim, Num, SalidaAtr, GenDem, NumDem, seg, Nombre) :-
    es_verbo(V, Inf, presente, seg, Num),
    es_demostrativo(Dem, GenDem, NumDem, prim),
    append([[V], SalidaAtr, [Dem, Nombre]], Salida).

% ========== Diccionario ==========

% Genero: m (masculino), f (femenino)
% Numero: s (singular), p (plural)
% Persona: prim (primera), seg (segunda), terc (tercera)
% Tiempo: presente, preterito_imperfecto, preterito_perfecto_simple
% Conjugacion: prim (primera), seg (segunda), terc (tercera)
% Nivel: prim (primero), seg (segundo), terc (tercero)

% es_nombre_propio(X, Genero).
es_nombre_propio(maria, f).
es_nombre_propio(juan, m).
es_nombre_propio(miguel, m).
es_nombre_propio(lucia, f).
es_nombre_propio(luis, m).
es_nombre_propio(ivan, m).
es_nombre_propio(david, m).


% es_nombre(X, Genero, Numero).
es_nombre(amigo, m, s).
es_nombre(amiga, f, s).
es_nombre(amigos, m, p).
es_nombre(amigas, f, p).
es_nombre(cambio, m, s).
es_nombre(cambios, m, p).
es_nombre(vida, f, s).
es_nombre(vidas, f, p).
es_nombre(noche, f, s).
es_nombre(noches, f, p).
es_nombre(mesa, f, s).
es_nombre(mesas, f, p).
es_nombre(coche, m, s).
es_nombre(coches, m, p).


% es_verbo(X, Infinitivo, Tiempo, Persona, Numero).

% Irregulares
es_verbo(dice, decir, presente, terc, s).
es_verbo(dijo, decir, preterito_perfecto_simple, terc, s).

es_verbo(es, ser, presente, terc, s).
es_verbo(era, ser, preterito_imperfecto, terc, s).

es_verbo(estoy, estar, presente, prim, s).
es_verbo(estas, estar, presente, seg, s).
es_verbo(estaba, estar, preterito_imperfecto, prim, s).
es_verbo(estaba, estar, preterito_imperfecto, terc, s).

% Regulares
es_verbo(V, Inf, Tiempo, Pers, Num) :-
    es_verbo_regular(Inf, Raiz, Conj),
    es_terminacion(Term, Tiempo, Pers, Num, Conj),
    atom_concat(Raiz, Term, V).

% es_verbo_regular(Infinitivo, Raiz, Conjugacion)
es_verbo_regular(necesitar, necesit, prim).
es_verbo_regular(preguntar, pregunt, prim).
es_verbo_regular(arreglar, arregl, prim).
es_verbo_regular(llegar, lleg, prim).

% es_terminacion(X, Tiempo, Persona, Numero, Conjugacion)
es_terminacion(o, presente, prim, s, prim).
es_terminacion(as, presente, seg, s, prim).
es_terminacion(a, presente, terc, s, prim).
es_terminacion(amos, presente, prim, p, prim).
es_terminacion(ais, presente, seg, p, prim).
es_terminacion(an, presente, terc, p, prim).

es_terminacion(aba, preterito_imperfecto, prim, s, prim).
es_terminacion(abas, preterito_imperfecto, seg, s, prim).
es_terminacion(aba, preterito_imperfecto, terc, s, prim).
es_terminacion(abamos, preterito_imperfecto, prim, p, prim).
es_terminacion(abais, preterito_imperfecto, seg, p, prim).
es_terminacion(aban, preterito_imperfecto, terc, p, prim).

es_terminacion(e, preterito_perfecto_simple, prim, s, prim).
es_terminacion(aste, preterito_perfecto_simple, seg, s, prim).
es_terminacion(o, preterito_perfecto_simple, terc, s, prim).
es_terminacion(amos, preterito_perfecto_simple, prim, p, prim).
es_terminacion(asteis, preterito_perfecto_simple, seg, p, prim).
es_terminacion(aron, preterito_perfecto_simple, terc, p, prim).


% es_determinante_posesivo(X, Persona, Numero, Genero, Cambio).
es_determinante_posesivo(mi, prim, s, m, su).
es_determinante_posesivo(mi, prim, s, f, su).
es_determinante_posesivo(su, terc, s, m, mi).
es_determinante_posesivo(su, terc, s, f, mi).



% es_adjetivo(X, Genero, Numero).
es_adjetivo(contento, m, s).
es_adjetivo(contenta, f, s).
es_adjetivo(contentos, m, p).
es_adjetivo(contentas, f, p).
es_adjetivo(ocupado, m, s).
es_adjetivo(ocupada, f, s).
es_adjetivo(ocupados, m, p).
es_adjetivo(ocupadas, f, p).
es_adjetivo(afortunado, m, s).
es_adjetivo(afortunada, f, s).
es_adjetivo(afortunados, m, p).
es_adjetivo(afortunadas, f, p).



% es_articulo(X, Genero, Numero).
es_articulo(un, m, s).
es_articulo(una, f, s).
es_articulo(unos, m, p).
es_articulo(unas, f, p).



% es_preposicion(X).
es_preposicion(a).
es_preposicion(de).



% es_infinitivo(X).
es_infinitivo(ver).



% es_terminacion_compl_ind(X, Persona, Numero).
es_terminacion_compl_ind(me, prim, s).
es_terminacion_compl_ind(te, seg, s).



% es_demostrativo(X, Genero, Numero, Nivel).
es_demostrativo(este, m, s, prim).
es_demostrativo(esta, f, s, prim).
es_demostrativo(estos, m, p, prim).
es_demostrativo(estas, f, p, prim).
es_demostrativo(ese, m, s, seg).
es_demostrativo(esa, f, s, seg).
es_demostrativo(esos, m, p, seg).
es_demostrativo(esas, f, p, seg).
es_demostrativo(aquel, m, s, terc).
es_demostrativo(aquella, f, s, terc).
es_demostrativo(aquellos, m, p, terc).
es_demostrativo(aquellas, f, p, terc).


% ========== Ciclo Continuo ==========

consulta :- write('Escribe la frase entre corchetes separando palabras con comas '), nl,
            write('o lista vacia para parar '), nl,
            read(F),
            trata(F).

trata([]) :- write('final.').
trata(F) :- frase(Salida, F, []), write(Salida), nl, nl, consulta.

% ====================================