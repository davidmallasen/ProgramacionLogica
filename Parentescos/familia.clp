(deffacts inicio
    (dd juan maria rosa m)
    (dd juan maria luis h)
    (dd jose laura pilar m)
    (dd luis pilar miguel h)
    (dd miguel isabel jaime h)
    (dd pedro rosa pablo h)
    (dd pedro rosa ana m)
)

(defrule padre
    (dd ?p ? ?h ?)
    =>
    (assert (padre ?p ?h))
)

(defrule madre
    (dd ? ?m ?h ?)
    =>
    (assert (madre ?m ?h))
)

(defrule progPat
    (padre ?p ?h)
    =>
    (assert (progenitor ?p ?h))
)
(defrule progMat
    (madre ?m ?h)
    =>
    (assert (progenitor ?m ?h))
)

(defrule hijo
    (dd ?p ?m ?h h)
    =>
    (assert (hijo ?h ?p))
    (assert (hijo ?h ?m))
)

(defrule hija
    (dd ?p ?m ?h m)
    =>
    (assert (hija ?h ?p))
    (assert (hija ?h ?m))
)

(defrule hermano
    (dd ?p ?m ?h1 h)
    (dd ?p ?m ?h2 ?)
    (test (neq ?h1 ?h2))
    =>
    (assert(hermano ?h1 ?h2))
)

(defrule hermana
    (dd ?p ?m ?h1 m)
    (dd ?p ?m ?h2 ?)
    (test (neq ?h1 ?h2))
    =>
    (assert(hermana ?h1 ?h2))
)

(defrule abuelo
    (padre ?a ?p)
    (progenitor ?p ?n)
    =>
    (assert(abuelo ?a ?n))
)

(defrule abuela
    (madre ?a ?p)
    (progenitor ?p ?n)
    =>
    (assert(abuela ?a ?n))
)

(defrule primoTio
    (progenitor ?prog ?yo)
    (hermano ?tio ?prog)
    (hijo ?primo ?tio)
    =>
    (assert(primo ?primo ?yo))
)
(defrule primoTia
    (progenitor ?prog ?yo)
    (hermana ?tia ?prog)
    (hijo ?primo ?tia)
    =>
    (assert(primo ?primo ?yo))
)

(defrule primaTio
    (progenitor ?prog ?yo)
    (hermano ?tio ?prog)
    (hija ?prima ?tio)
    =>
    (assert(prima ?prima ?yo))
)
(defrule primaTia
    (progenitor ?prog ?yo)
    (hermana ?tia ?prog)
    (hija ?prima ?tia)
    =>
    (assert(prima ?prima ?yo))
)

(defrule ascendiente
    (progenitor ?prog ?yo)
    =>
    (assert(ascendiente ?prog ?yo))
)
(defrule ascendienteProg
    (progenitor ?prog ?yo)
    (ascendiente ?asc ?prog)
    =>
    (assert(ascendiente ?asc ?yo))
)