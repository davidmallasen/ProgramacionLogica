/*
    Sistema interactivo de diagnostico medico y prescripcion
    Ivan Prada Cazalla & David Mallasen Quintana
*/

% ---- Hechos disponibles ----

%esUnComponente(X, Y) <-> X es un componenteQuimico de tipoComponente Y
esUnComponente(triprolidina, antihistaminico).
esUnComponente(ebastina, antihistaminico).
esUnComponente(amoxicilina, antibiotico).
esUnComponente(ampicilina, antibiotico).
esUnComponente(paracetamol, analgesico).
esUnComponente(metoclopramida, antiemetico).
esUnComponente(acido_acetilsalicilico, analgesico).

% contiene(X, Y) <-> X es un medicamento que contiene el componenteQuimico Y
contiene(aspirina, acido_acetilsalicilico).
contiene(iniston, triprolidina).
contiene(clamoxil, amoxicilina).
contiene(gelocatil, paracetamol).
contiene(ebastel, ebastina).
contiene(britapen, ampicilina).
contiene(primperan, metoclopramida).

% esUnEnfermedad(X, Y) <-> X es una enfermedad de tipoEnfermedad Y
esUnEnfermedad(rinitis_alergica, alergica).
esUnEnfermedad(faringitis_bacteriana, infecciosa_bacteriana).
esUnEnfermedad(meningitis_bacteriana, infecciosa_bacteriana).

% ---- Reglas ----

% Diagnostica la enfermedad que tiene el paciente en funcion de sus sintomas
diagnostico(meningitis_bacteriana) :- 
    sintoma(fiebre), 
    sintoma(dolor_cabeza), 
    sintoma(rigidez_nuca), 
    sintoma(nauseas).
diagnostico(meningitis_bacteriana) :- 
    sintoma(fiebre), 
    sintoma(dolor_cabeza), 
    sintoma(rigidez_nuca), 
    sintoma(vomitos).
diagnostico(faringitis_bacteriana) :-
    sintoma(dolor_garganta),
    sintoma(fiebre),
    sintoma(malestar_general).
diagnostico(rinitis_alergica) :-
    sintoma(picor_nariz),
    sintoma(congestion_nasal),
    sintoma(congestion_ocular).

% Tipo de componente que se debe tomar el paciente en funcion del tipo de su enfermedad
tomarParaEnfermedad(antihistaminico) :- tipoEnfermedad(alergica).
tomarParaEnfermedad(antibiotico) :- tipoEnfermedad(infecciosa_bacteriana).

% Tipo de la enfermedad diagnosticada al paciente
tipoEnfermedad(TEnf) :- 
    esUnEnfermedad(Enf, TEnf),
    diagnostico(Enf),
    nl, nl, write("Usted tiene "), write(Enf).

% Tipo de componente que se debe tomar el paciente en funcion de sus sintomas
tomarParaSintoma(analgesico) :- sintoma(fiebre).
tomarParaSintoma(analgesico) :- sintoma(dolor).
tomarParaSintoma(antihistaminico) :- sintoma(congestion_nasal).
tomarParaSintoma(antihistaminico) :- sintoma(congestion_ocular).

medicamento(Med) :-
    tomarParaEnfermedad(TipoComp),
    esUnComponente(Comp, TipoComp),
    contiene(Med, Comp),
    \+alergico(Comp).

medicamento(Med) :-
    tomarParaSintoma(TipoComp), 
    esUnComponente(Comp, TipoComp),
    contiene(Med, Comp),
    \+alergico(Comp).

tratamiento :- 
    retractall(preguntado(_,_)), 
    medicamento(Med),
    nl, nl, write("Debe tomar "), write(Med).
tratamiento :- 
    write("Ve al medico, no se te puede asignar ningun medicamento.").

% ---- Entrada/Salida ----

% Sintoma generico
sintoma(dolor) :- sintoma(dolor_cabeza).
sintoma(dolor) :- sintoma(dolor_garganta).
% Sintomas que le debemos preguntar al paciente
sintoma(fiebre) :- pregunta_si(fiebre).
sintoma(congestion_nasal) :- pregunta_si(congestion_nasal).
sintoma(congestion_ocular) :- pregunta_si(congestion_ocular).
sintoma(dolor_cabeza) :- pregunta_si(dolor_cabeza).
sintoma(rigidez_nuca) :- pregunta_si(rigidez_nuca).
sintoma(nauseas) :- pregunta_si(nauseas).
sintoma(vomitos) :- pregunta_si(vomitos).
sintoma(dolor_garganta) :- pregunta_si(dolor_garganta).
sintoma(malestar_general) :- pregunta_si(malestar_general).
sintoma(picor_nariz) :- pregunta_si(picor_nariz).

% Alergias que le debemos preguntar al paciente
alergico(triprolidina) :- pregunta_si(triprolidina).
alergico(ebastina) :- pregunta_si(ebastina).
alergico(amoxicilina) :- pregunta_si(amoxicilina).
alergico(ampicilina) :- pregunta_si(ampicilina).
alergico(paracetamol) :- pregunta_si(paracetamol).
alergico(metoclopramida) :- pregunta_si(metoclopramida).
alergico(acido_acetilsalicilico) :- pregunta_si(acido_acetilsalicilico).

% Conjunto de preguntas sobre sintomas
pregunta(fiebre) :- write("Tiene usted fiebre? ").
pregunta(congestion_nasal) :- write("Tiene usted congestion nasal? ").
pregunta(congestion_ocular) :- write("Tiene usted congestion ocular? ").
pregunta(dolor_cabeza) :- write("Tiene usted dolor de cabeza? ").
pregunta(rigidez_nuca) :- write("Tiene usted rigidez en la nuca? ").
pregunta(nauseas) :- write("Tiene usted nauseas? ").
pregunta(vomitos) :- write("Tiene usted vomitos? ").
pregunta(dolor_garganta) :- write("Tiene usted dolor de garganta? ").
pregunta(malestar_general) :- write("Tiene usted malestar general? ").
pregunta(picor_nariz) :- write("Tiene usted picor de nariz? ").
% Conjunto de preguntas sobre alergias
pregunta(triprolidina) :- write("Tiene usted alergia a la triprolidina? ").
pregunta(ebastina) :- write("Tiene usted alergia a la ebastina? ").
pregunta(amoxicilina) :- write("Tiene usted alergia a la amoxicilina? ").
pregunta(ampicilina) :- write("Tiene usted alergia a la ampicilina? ").
pregunta(paracetamol) :- write("Tiene usted alergia al paracetamol? ").
pregunta(metoclopramida) :- write("Tiene usted alergia a la metoclopramida? ").
pregunta(acido_acetilsalicilico) :- write("Tiene usted alergia al acido acetilsalicilico? ").


% Comprobamos si se ha preguntado previamente

:- dynamic preguntado/2. 

pregunta_si(C) :- 
    confirma(C, R),  
    respuesta_positiva(C, R).

confirma(C, R) :- preguntado(C, R). 
confirma(C, R) :-
    \+preguntado(C, _), 
    nl, pregunta(C),  
    read(R),
    asserta(preguntado(C, R)). 


% Analizamos y reiteramos hasta obtener una respuesta valida
respuesta_positiva(_, R) :- afirmativa(R).
respuesta_positiva(C, R) :- 
    \+afirmativa(R), 
    \+negativa(R), 
    write('Por favor, conteste si/s o no/n y termine con . : '), 
    read(R2),
    retract(preguntado(C, R)),
    asserta(preguntado(C, R2)), 
    respuesta_positiva(C, R2).


% Respuestas afirmativas
afirmativa(si).
afirmativa(s).

% Respuestas negativas
negativa(no).
negativa(n).