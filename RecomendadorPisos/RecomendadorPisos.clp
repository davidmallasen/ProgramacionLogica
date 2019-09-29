;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; David Mallasén Quintana e Iván Prada Cazalla
;; Recomendador de pisos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module MAIN

(defmodule MAIN (export ?ALL))

(deftemplate MAIN::piso "Informacion de un piso."
    (slot id        ;;calle del piso con numero
        (type STRING)
    )
    (slot modalidad
        (type SYMBOL)
        (allowed-symbols compra alquiler alquilerOcompra)
    )
    (slot precio       ;;en euros
        (type INTEGER)
    )
    (slot tamanyo      ;;en metros cuadrados
        (type INTEGER)
    )
    (slot tipo
        (type SYMBOL)
        (allowed-symbols piso chalet casaRustica duplex atico)
    )         
    (slot numeroHabitaciones
        (type INTEGER)
    )
    (slot numeroBanyos
        (type INTEGER)
    )
    (slot admiteMascota 
        (type SYMBOL)
        (allowed-symbols si no)
        (default no)
    )
    (slot link
        (type STRING)
    )
)

(deftemplate MAIN::pisoRecomendado "Piso recomendado a un usuario"
    (slot nombre        ;;Nombre del usuario
        (type STRING)
    )
    (slot id            ;;Id del piso (direccion)
        (type STRING)
    )
    (slot precio        ;;Precio del piso
        (type INTEGER)
    )
    (slot tamanyo       ;;Tamanyo del piso
        (type INTEGER)
    )
    (slot puntuacion    ;;Puntuacion asociada al piso
        (type INTEGER)
    )
)

(deftemplate MAIN::usuario "Informacion de un usuario."
    (slot nombre
        (type STRING)
    )
    (slot pareja 
        (type SYMBOL)
        (allowed-symbols si no)
    )
    (slot compPiso
        (type INTEGER)
        (default 0)
    )
    (slot hijos
        (type INTEGER)
        (default 0)
    )
    (slot mascota 
        (type SYMBOL)
        (allowed-symbols si no)
    )
    (slot edad
        (type INTEGER)
    )
    (slot situacionEconomica
        (type INTEGER)
        (range 1 4)  ; 1-baja, 2-normal, 3-buena, 4-muyBuena
    )
    (slot trabajoEstable
        (type SYMBOL)
        (allowed-symbols si no)
    )
    (multislot tipoPiso
        (type SYMBOL)
        (allowed-symbols piso chalet casaRustica duplex atico)
    )
    (slot recomendarPor
      (type INTEGER)
      (range 1 4) ; El 1 es para ordenar por precioAsc, 2 precioDesc, 3 tamanyo, 4 grado adecuacion
    )
)

(deftemplate MAIN::question
    (slot text)
    (slot type)
    (slot ident)
)

(deftemplate MAIN::ask
    (slot ident)
)

(deftemplate MAIN::answer
    (slot ident)
    (slot text)
)

(deffacts MAIN::inicio
    (piso (id "Piso en venta en Almagro, Madrid") (modalidad compra) (precio 1050000) (tamanyo 124) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/38745212/"))
    (piso (id "Atico en venta en calle de Bailen s/n, Palacio, Madrid") (modalidad compra) (precio 3200000) (tamanyo 360) (tipo atico) (numeroHabitaciones 4) (numeroBanyos 3) (admiteMascota si) (link "https://www.idealista.com/inmueble/39012835/"))
    (piso (id "Piso en venta en Castellana, Madrid") (modalidad compra) (precio 630000) (tamanyo 146) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/37805029/"))
    (piso (id "Chalet adosado en venta en calle Pozohalcon, Entrevias, Madrid") (modalidad compra) (precio 126000) (tamanyo 90) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38815404/"))
    (piso (id "Alquiler de piso en calle Narvaez, Ibiza, Madrid") (modalidad alquiler) (precio 850) (tamanyo 50) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/30606056/"))
    (piso (id "Piso en Moratalaz - Marroquina / Marroquina, Madrid Capital") (modalidad alquiler) (precio 1150) (tamanyo 128) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-ascensor-amueblado-marroquina-144656706?RowGrid=1&tti=3&opi=300&RowGrid=1&tti=3&opi=300"))
    (piso (id "Piso en Encomienda De Palacios / Fontarron, Madrid Capital") (modalidad alquiler) (precio 690) (tamanyo 71) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-encomienda-de-palacios-145496670?RowGrid=5&tti=3&opi=300"))
    (piso (id "Atico en Plaza Laguna Negra, 13 / Horcajo, Madrid Capital") (modalidad alquiler) (precio 1300) (tamanyo 80) (tipo atico) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-parking-terraza-trastero-zona-comunitaria-ascensor-no-amueblado-laguna-negra-13-145489428?RowGrid=6&tti=3&opi=300"))
    (piso (id "Piso en Artilleros-Moratalaz / Fontarron, Madrid Capital") (modalidad compra) (precio 143000) (tamanyo 72) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-parking-fontarron-142703224?RowGrid=1&tti=1&opi=300"))
    (piso (id "Piso en Felix Rodriguez De La Fuente / Media Legua, Madrid Capital") (modalidad compra) (precio 66000) (tamanyo 64) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-felix-rodriguez-de-la-fuente-144879933?RowGrid=2&tti=1&opi=300"))
    (piso (id "Atico en Horcajo-Moratalaz / Horcajo, Madrid Capital") (modalidad compra) (precio 600000) (tamanyo 137) (tipo atico) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-parking-terraza-trastero-zona-comunitaria-ascensor-piscina-horcajo-143207577?RowGrid=6&tti=1&opi=300"))
    (piso (id "Piso en Parla - Centro / Centro, Parla") (modalidad compra) (precio 80000) (tamanyo 66) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/parla/aire-acondicionado-calefaccion-terraza-amueblado-centro-143594631?RowGrid=5&tti=1&opi=300"))
    (piso (id "Casa adosada en Rosa Manzano / Fuentebella - El Nido, Parla") (modalidad compra) (precio 313310) (tamanyo 320) (tipo chalet) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/parla/calefaccion-parking-jardin-terraza-trastero-patio-piscina-se-aceptan-mascotas-rosa-manzano-144291689?RowGrid=4&tti=1&opi=300"))
    (piso (id "Piso en Pinto / Centro, Parla") (modalidad compra) (precio 106100) (tamanyo 82) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/parla/calefaccion-terraza-ascensor-amueblado-pinto-145326086?RowGrid=6&tti=1&opi=300"))
    (piso (id "Piso en San Antón / Villa Juventus, Parla") (modalidad alquiler) (precio 650) (tamanyo 90) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/parla/calefaccion-terraza-amueblado-television-piscina-san-anton-145275355?RowGrid=2&tti=3&opi=300"))
    (piso (id "Piso en Parla - Centro / Las Americas - Parla Este, Parla") (modalidad alquiler) (precio 760) (tamanyo 110) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/parla/aire-acondicionado-calefaccion-trastero-zona-comunitaria-ascensor-parking-piscina-no-amueblado-las-americas-parla-este-145469435?RowGrid=7&tti=3&opi=300"))
    (piso (id "Chalet en Mas Sauro / Vallvidrera, Tibidabo i les PLanes, Barcelona Ca") (modalidad alquilerOcompra) (precio 3000) (tamanyo 561) (tipo chalet) (numeroHabitaciones 4) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/barcelona-capital/calefaccion-parking-terraza-trastero-ascensor-se-aceptan-mascotas-no-amueblado-vallvidrera-tibidabo-i-les-planes-144946360?RowGrid=1&tti=3&opi=300&RowGrid=1&tti=3&opi=300"))
    (piso (id "Planta baja en Josep De Peray / Can Mates - Volpelleres, Sant Cugat") (modalidad alquiler) (precio 1650) (tamanyo 107) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/sant-cugat-del-valles/aire-acondicionado-calefaccion-jardin-terraza-trastero-zona-comunitaria-ascensor-parking-piscina-josep-de-peray-145504136?RowGrid=11&tti=3&opi=300"))
    (piso (id "Piso en Serrallo / Berruguete, Madrid Capital") (modalidad alquiler) (precio 750) (tamanyo 43) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/madrid-capital/parking-ascensor-amueblado-serrallo-145504041?RowGrid=14&tti=3&opi=300"))
    (piso (id "Atico en Calle Santo Cristo De Cadret / Cadrete") (modalidad alquiler) (precio 500) (tamanyo 90) (tipo atico) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/cadrete/calefaccion-parking-terraza-trastero-ascensor-piscina-calle-santo-cristo-de-cadret-145503257?RowGrid=17&tti=3&opi=300"))
    (piso (id "Atico en Camins Al Grau - Penya - Roja - Avda. Francia / Penya - Roja") (modalidad alquiler) (precio 2000) (tamanyo 140) (tipo atico) (numeroHabitaciones 3) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/valencia-capital/valencia-ciudad-aire-acondicionado-terraza-ascensor-amueblado-parking-penya-roja-avda.-francia-145223323?RowGrid=26&tti=3&opi=300"))
    (piso (id "Casa adosada en Moraleja / La Moraleja distrito, Alcobendas") (modalidad compra) (precio 2800000) (tamanyo 520) (tipo chalet) (numeroHabitaciones 5) (numeroBanyos 5) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/alcobendas/la-moraleja-aire-acondicionado-calefaccion-parking-jardin-piscina-la-moraleja-distrito-144413757?RowGrid=1&tti=1&opi=300"))
    (piso (id "Piso en Soto De La Moraleja / El Soto de la Moraleja, Alcobendas") (modalidad compra) (precio 960000) (tamanyo 180) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/alcobendas/la-moraleja-trastero-zona-comunitaria-ascensor-piscina-el-soto-de-la-moraleja-141619270?RowGrid=2&tti=1&opi=300"))
    (piso (id "Piso en Centro / Centro, Alcobendas") (modalidad compra) (precio 158000) (tamanyo 60) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/alcobendas/alcobendas-ciudad-no-amueblado-centro-140623651?RowGrid=4&tti=1&opi=300"))
    (piso (id "Piso en Alcobendas ,Alcobendas / Centro, Alcobendas") (modalidad compra) (precio 117000) (tamanyo 60) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/alcobendas/alcobendas-ciudad-terraza-centro-144838003?RowGrid=11&tti=1&opi=300"))
    (piso (id "Piso en Avenida De Roma (Coslada) / Ciudad 70, Coslada") (modalidad compra) (precio 179900) (tamanyo 120) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/coslada/avenida-de-roma-coslada-145412323?RowGrid=16&tti=1&opi=300"))
    (piso (id "Piso en Coslada - Pueblo - Barrio Del Puerto / Pueblo - Barrio del Pueblo") (modalidad alquiler) (precio 1250) (tamanyo 145) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/coslada/aire-acondicionado-calefaccion-parking-ascensor-amueblado-pueblo-barrio-del-puerto-145126423?RowGrid=2&tti=3&opi=300"))
    (piso (id "Apartamento en Barrio de la Estacion, Coslada") (modalidad alquiler) (precio 830) (tamanyo 55) (tipo piso) (numeroHabitaciones 0) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/coslada/aire-acondicionado-calefaccion-zona-comunitaria-ascensor-piscina-amueblado-television-internet-piscina-barrio-de-la-estacion-143465014?RowGrid=8&tti=3&opi=300"))
    (piso (id "Piso en Coslada - Ciudad 70 / Ciudad 70, Coslada") (modalidad alquiler) (precio 700) (tamanyo 60) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/coslada/calefaccion-parking-ascensor-ciudad-70-145472777?RowGrid=9&tti=3&opi=300"))
    (piso (id "Piso en Coslada - El Barral Ferial / El Barral Ferial, Coslada") (modalidad alquiler) (precio 1150) (tamanyo 140) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/coslada/aire-acondicionado-calefaccion-parking-zona-comunitaria-ascensor-piscina-no-amueblado-el-barral-ferial-145310182?RowGrid=18&tti=3&opi=300"))
    (piso (id "Piso en Rivas-Vaciamadrid - Centro / Centro, Rivas-vaciamadrid") (modalidad compra) (precio 255000) (tamanyo 105) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/rivas-vaciamadrid/calefaccion-terraza-trastero-zona-comunitaria-ascensor-parking-piscina-centro-145474538?RowGrid=1&tti=1&opi=300"))
    (piso (id "Chalet en Rivas-Vaciamadrid - Rivas Urbanizaciones / Rivas Urbaniza") (modalidad compra) (precio 377424) (tamanyo 265) (tipo chalet) (numeroHabitaciones 5) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/rivas-vaciamadrid/aire-acondicionado-calefaccion-parking-jardin-terraza-piscina-rivas-urbanizaciones-141218404?RowGrid=5&tti=1&opi=300"))
    (piso (id "Piso en Rivas-Vaciamadrid ,La Fortuna / Rivas Urbanizaciones, Rivas") (modalidad alquiler) (precio 950) (tamanyo 92) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/rivas-vaciamadrid/calefaccion-parking-trastero-ascensor-piscina-amueblado-piscina-rivas-urbanizaciones-145239083?RowGrid=2&tti=3&opi=300"))
    (piso (id "Piso en Luis Mateo Díaz / Centro, Rivas-vaciamadrid") (modalidad alquiler) (precio 1100) (tamanyo 135) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/rivas-vaciamadrid/aire-acondicionado-calefaccion-parking-jardin-trastero-ascensor-piscina-se-aceptan-mascotas-luis-mateo-diaz-145405848?RowGrid=9&tti=3&opi=300"))
    (piso (id "Piso en Valmojado / Aluche, Madrid Capital") (modalidad compra) (precio 240000) (tamanyo 105) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-parking-jardin-terraza-trastero-zona-comunitaria-ascensor-valmojado-145144942?RowGrid=1&tti=1&opi=300"))
    (piso (id "Piso en Laguna 39 4 D / Aluche, Madrid Capital") (modalidad compra) (precio 119000) (tamanyo 79) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/madrid-capital/laguna-39-4-d-142401620?RowGrid=10&tti=1&opi=300"))
    (piso (id "Piso en Ocana / Aluche, Madrid Capital") (modalidad compra) (precio 90000) (tamanyo 45) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/madrid-capital/parking-ocana-145503543?RowGrid=12&tti=1&opi=300"))
    (piso (id "Piso en Aluche / Aluche, Madrid Capital") (modalidad compra) (precio 305000) (tamanyo 110) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/terraza-trastero-zona-comunitaria-ascensor-piscina-parking-piscina-aluche-144083670?RowGrid=22&tti=1&opi=300"))
    (piso (id "Piso en Valmojado / Aluche, Madrid Capital") (modalidad alquiler) (precio 850) (tamanyo 105) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-jardin-terraza-ascensor-amueblado-no-amueblado-valmojado-145238649?RowGrid=1&tti=3&opi=300"))
    (piso (id "Piso en Manuel De Bofarull, 13 / Aluche, Madrid Capital") (modalidad alquiler) (precio 650) (tamanyo 65) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-terraza-manuel-de-bofarull-13-145490882?RowGrid=12&tti=3&opi=300"))
    (piso (id "Duplex en Torrelodones - Casco Antiguo / Casco Antiguo, Torrelodone") (modalidad alquiler) (precio 890) (tamanyo 80) (tipo duplex) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/torrelodones/aire-acondicionado-calefaccion-terraza-trastero-zona-comunitaria-ascensor-piscina-piscina-casco-antiguo-145218175?RowGrid=1&tti=3&opi=300&RowGrid=1&tti=3&opi=300&RowGrid=1&tti=3&opi=300"))
    (piso (id "Piso en Los Angeles - Jarandilla / Los Angeles - Jarandilla, Torrelodon") (modalidad alquiler) (precio 300) (tamanyo 50) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/torrelodones/calefaccion-zona-comunitaria-amueblado-internet-piscina-los-angeles-jarandilla-145508956?RowGrid=3&tti=3&opi=300"))
    (piso (id "Chalet en Torrelodones - La Berzosilla / La Berzosilla, Torrelodones") (modalidad alquiler) (precio 2250) (tamanyo 650) (tipo chalet) (numeroHabitaciones 7) (numeroBanyos 4) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/torrelodones/calefaccion-parking-jardin-terraza-trastero-patio-se-aceptan-mascotas-internet-no-amueblado-la-berzosilla-144703732?RowGrid=10&tti=3&opi=300"))
    (piso (id "Atico en Salamanca - Fuente Del Berro / Goya, Madrid Capital") (modalidad alquiler) (precio 1950) (tamanyo 90) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-terraza-ascensor-amueblado-goya-145261888?RowGrid=4&tti=3&opi=300&RowGrid=4&tti=3&opi=300"))
    (piso (id "Piso en Retiro - Ibiza De Madrid / Ibiza de Madrid, Madrid Capital") (modalidad alquiler) (precio 2000) (tamanyo 110) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-ascensor-amueblado-se-aceptan-mascotas-no-amueblado-ibiza-de-madrid-145397116?RowGrid=7&tti=3&opi=300"))
    (piso (id "Piso en Alcala, 161 / Goya, Madrid Capital") (modalidad compra) (precio 1150000) (tamanyo 275) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-trastero-ascensor-no-amueblado-alcala-161-142296159?RowGrid=8&tti=1&opi=300"))
    (piso (id "Piso en Marcelo Usera / Moscardo, Madrid Capital") (modalidad compra) (precio 109000) (tamanyo 76) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/marcelo-usera-144964743?RowGrid=2&tti=1&opi=300&RowGrid=2&tti=1&opi=300"))
    (piso (id "Atico en Aixa / Atarfe") (modalidad compra) (precio 64988) (tamanyo 57) (tipo atico) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.fotocasa.es/vivienda/atarfe/calefaccion-terraza-ascensor-aixa-140199826?RowGrid=4&tti=1&opi=300"))
    (piso (id "Piso en Vallecas Madrid / Numancia, Madrid Capital") (modalidad compra) (precio 97470) (tamanyo 90) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/ascensor-no-amueblado-numancia-145267287?RowGrid=1&tti=1&opi=300"))
    (piso (id "Piso en Puente De Vallecas - Numancia / Numancia, Madrid Capital") (modalidad compra) (precio 210000) (tamanyo 72) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-parking-ascensor-numancia-145225703?RowGrid=10&tti=1&opi=300"))
    (piso (id "Chalet en Valdemorillo - Cerro De Alarcon - Puente La Sierra - Mirad") (modalidad compra) (precio 220000) (tamanyo 140) (tipo chalet) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/valdemorillo/calefaccion-jardin-piscina-amueblado-se-aceptan-mascotas-internet-cerro-de-alarcon-puente-la-sierra-mirador-del-romero-141488228?RowGrid=3&tti=1&opi=300&RowGrid=3&tti=1&opi=300"))
    (piso (id "Piso en Chamberi - Trafalgar / Trafalgar, Madrid Capital") (modalidad compra) (precio 1450000) (tamanyo 285) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-terraza-trastero-trafalgar-144769717?RowGrid=3&tti=1&opi=300&RowGrid=3&tti=1&opi=300"))
    (piso (id "Piso en Paseo General Martinez Campos / Almagro, Madrid Capital") (modalidad compra) (precio 975000) (tamanyo 177) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-parking-terraza-trastero-ascensor-general-martinez-campos-145467419?RowGrid=6&tti=1&opi=300"))
    (piso (id "Duplex en Alonso Quijano / Pozuelo de Calatrava") (modalidad compra) (precio 77500) (tamanyo 145) (tipo duplex) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/pozuelo-de-calatrava/calefaccion-terraza-ascensor-no-amueblado-alonso-quijano-141537538?RowGrid=3&tti=1&opi=300"))
    (piso (id "Piso en Zurbaran, 17 / Almagro, Madrid Capital") (modalidad alquiler) (precio 3950) (tamanyo 377) (tipo piso) (numeroHabitaciones 5) (numeroBanyos 4) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/aire-acondicionado-calefaccion-parking-terraza-ascensor-no-amueblado-zurbaran-17-141392423?RowGrid=4&tti=3&opi=300"))
    (piso (id "Piso en Hortaleza, 96 / Justicia - Chueca, Madrid Capital") (modalidad alquiler) (precio 1400) (tamanyo 45) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-television-hortaleza-96-144883173?RowGrid=6&tti=3&opi=300"))
    (piso (id "Piso en Chamberi - Almagro / Almagro, Madrid Capital") (modalidad alquiler) (precio 4500) (tamanyo 250) (tipo piso) (numeroHabitaciones 5) (numeroBanyos 4) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/madrid-capital/calefaccion-ascensor-almagro-145053826?RowGrid=35&tti=3&opi=300"))
    (piso (id "Piso en Rozas Centro - Casco Antiguo / Casco Antiguo, Las Rozas de M") (modalidad alquiler) (precio 650) (tamanyo 50) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/aire-acondicionado-calefaccion-ascensor-casco-antiguo-145369592?RowGrid=3&tti=3&opi=300"))
    (piso (id "Piso en Las Rozas De Madrid - El Pinar - Punta Galea / El Pinar - Punt") (modalidad alquiler) (precio 1200) (tamanyo 119) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/calefaccion-parking-terraza-trastero-zona-comunitaria-ascensor-piscina-el-pinar-punta-galea-145261876?RowGrid=6&tti=3&opi=300"))
    (piso (id "Piso en Rozas Centro - Zona Estacion / Zona Estacion, Las Rozas de") (modalidad alquiler) (precio 650) (tamanyo 65) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/trastero-ascensor-zona-estacion-145497387?RowGrid=19&tti=3&opi=300"))
    (piso (id "Piso en Rozas Centro - Casco Antiguo / Casco Antiguo, Las Rozas de") (modalidad compra) (precio 160000) (tamanyo 70) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/terraza-casco-antiguo-144668223?RowGrid=2&tti=1&opi=300"))
    (piso (id "Duplex en Burgo - Parque Paris / El Burgo, Las Rozas de Madrid") (modalidad compra) (precio 348000) (tamanyo 160) (tipo duplex) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/aire-acondicionado-calefaccion-parking-jardin-trastero-zona-comunitaria-ascensor-piscina-el-burgo-143888126?RowGrid=12&tti=1&opi=300"))
    (piso (id "Piso en Rozas Centro - Zona Estacion / Zona Estacion, Las Rozas de ") (modalidad compra) (precio 275000) (tamanyo 130) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/aire-acondicionado-calefaccion-ascensor-parking-zona-estacion-140586168?RowGrid=31&tti=1&opi=300"))
    (piso (id "Atico en Burgo - Parque Paris / El Burgo, Las Rozas de Madrid") (modalidad compra) (precio 540000) (tamanyo 200) (tipo atico) (numeroHabitaciones 4) (numeroBanyos 5) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/calefaccion-parking-jardin-terraza-trastero-zona-comunitaria-ascensor-piscina-el-burgo-144943629?RowGrid=3&tti=1&opi=300"))
    (piso (id "Finca rustica en Rozas Centro - Casco Antiguo / Casco Antiguo, Las ") (modalidad compra) (precio 300000) (tamanyo 205) (tipo casaRustica) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/casco-antiguo-145026058?RowGrid=3&tti=1&opi=300"))
    (piso (id "Duplex en Las Rozas-Parque Empresarial / Parque Empresarial, Las") (modalidad compra) (precio 370000) (tamanyo 130) (tipo duplex) (numeroHabitaciones 3) (numeroBanyos 3) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/las-rozas-de-madrid/aire-acondicionado-calefaccion-parking-terraza-trastero-zona-comunitaria-piscina-internet-piscina-parque-empresarial-144576041?RowGrid=7&tti=1&opi=300"))
    (piso (id "Alquiler de piso en Algete") (modalidad alquiler) (precio 650) (tamanyo 110) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39356305/"))
    (piso (id "Alquiler de chalet adosado en Emilia Pardo Bazan, 16") (modalidad alquiler) (precio 1000) (tamanyo 233) (tipo chalet) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/30025166/"))
    (piso (id "Alquiler de duplex en Algete") (modalidad alquiler) (precio 695) (tamanyo 103) (tipo duplex) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39134573/"))
    (piso (id "Atico en Tres Cantos - Zona Estacion - Centro / Zona Estacion - Centr") (modalidad compra) (precio 400000) (tamanyo 108) (tipo atico) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/tres-cantos/aire-acondicionado-calefaccion-terraza-zona-comunitaria-ascensor-parking-piscina-zona-estacion-centro-135747795?RowGrid=7&tti=1&opi=300"))
    (piso (id "Atico en Tres Cantos - Zona Industrial / Zona Industrial, Tres Cantos") (modalidad alquiler) (precio 850) (tamanyo 100) (tipo atico) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/tres-cantos/aire-acondicionado-calefaccion-terraza-ascensor-piscina-amueblado-se-aceptan-mascotas-no-amueblado-zona-industrial-145501716?RowGrid=3&tti=3&opi=300"))
    (piso (id "Piso en Zona Estacion - Centro / Zona Estacion - Centro, Tres Cantos") (modalidad alquiler) (precio 1300) (tamanyo 110) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.fotocasa.es/vivienda/tres-cantos/aire-acondicionado-calefaccion-parking-jardin-terraza-zona-comunitaria-ascensor-piscina-no-amueblado-zona-estacion-centro-145131225?RowGrid=13&tti=3&opi=300"))
    (piso (id "Alquiler de piso en travesia De Longares, 16") (modalidad alquiler) (precio 950) (tamanyo 101) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/39358875/"))
    (piso (id "Alquiler de piso en calle de julia garcia boutan, 17") (modalidad alquiler) (precio 850) (tamanyo 90) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38895397/"))
    (piso (id "Piso en venta en calle bucarest, 13") (modalidad compra) (precio 345000) (tamanyo 121) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/38765926/"))
    (piso (id "Atico en venta en calle de suecia") (modalidad compra) (precio 370000) (tamanyo 100) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/37480843/"))
    (piso (id "Casa o chalet en venta en calle de estocolmo") (modalidad compra) (precio 699000) (tamanyo 248) (tipo chalet) (numeroHabitaciones 4) (numeroBanyos 3) (admiteMascota si) (link "https://www.idealista.com/inmueble/39070028/"))
    (piso (id "Duplex en venta en Longares") (modalidad compra) (precio 174000) (tamanyo 60) (tipo duplex) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/38861910/"))
    (piso (id "Piso en venta en calle Bucarest, 31") (modalidad compra) (precio 149000) (tamanyo 60) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38880067/"))
    (piso (id "Alquiler de piso en San Herculano") (modalidad alquiler) (precio 700) (tamanyo 58) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/39209233/"))
    (piso (id "Alquiler de atico en Canillejas") (modalidad alquiler) (precio 900) (tamanyo 78) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39338223/"))
    (piso (id "Alquiler de piso en calle de Galileo") (modalidad alquiler) (precio 750) (tamanyo 45) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38954307/"))
    (piso (id "Alquiler de duplex en Arapiles") (modalidad alquiler) (precio 1400) (tamanyo 92) (tipo duplex) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39350352/"))
    (piso (id "Alquiler de piso en calle Donoso Cortes") (modalidad alquiler) (precio 1000) (tamanyo 75) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39298867/"))
    (piso (id "Piso en venta en calle Donoso Cortes") (modalidad compra) (precio 421000) (tamanyo 89) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/38555949/"))
    (piso (id "Piso en venta en Arapiles") (modalidad compra) (precio 1085000) (tamanyo 207) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/39115243/"))
    (piso (id "Alquiler de piso en de Orense s/n") (modalidad alquiler) (precio 950) (tamanyo 60) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/39359398/"))
    (piso (id "Alquiler de piso en plaza Manolete") (modalidad alquiler) (precio 1650) (tamanyo 65) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39357982/"))
    (piso (id "Alquiler de piso en calle de palencia, 40") (modalidad alquiler) (precio 700) (tamanyo 51) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39354547/"))
    (piso (id "Piso en venta en calle del General Moscardo, 1") (modalidad compra) (precio 1150000) (tamanyo 246) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/38805921/"))
    (piso (id "Duplex en venta en Cuatro Caminos") (modalidad compra) (precio 1370000) (tamanyo 282) (tipo duplex) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/38282451/"))
    (piso (id "Piso en venta en calle de san raimundo") (modalidad compra) (precio 233000) (tamanyo 75) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38485349/"))
    (piso (id "Piso en venta en calle de jeronima llorente") (modalidad compra) (precio 459000) (tamanyo 115) (tipo piso) (numeroHabitaciones 4) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/39017271/"))
    (piso (id "Alquiler de piso en castilla") (modalidad alquiler) (precio 750) (tamanyo 54) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39358756/"))
    (piso (id "Alquiler de atico en calle Francos Rodriguez, 31") (modalidad alquiler) (precio 780) (tamanyo 65) (tipo atico) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/29476985/"))
    (piso (id "Alquiler de piso en avenida DOCTOR FEDERICO RUBIO Y GALI, 1") (modalidad alquiler) (precio 750) (tamanyo 55) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39347208/"))
    (piso (id "Alquiler de piso en BRAVO MURILLO") (modalidad alquiler) (precio 999) (tamanyo 35) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/39338088/"))
    (piso (id "Alquiler de piso en rocafort") (modalidad alquiler) (precio 280) (tamanyo 75) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39354003/"))
    (piso (id "Alquiler de piso en calle Garganchon, 114") (modalidad alquiler) (precio 650) (tamanyo 60) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/39188248/"))
    (piso (id "Alquiler de casa o chalet en Campo de las Naciones-Corralejos") (modalidad alquiler) (precio 2500) (tamanyo 360) (tipo chalet) (numeroHabitaciones 6) (numeroBanyos 4) (admiteMascota si) (link "https://www.idealista.com/inmueble/39347927/"))
    (piso (id "Alquiler de piso en calle Bahia de Almeria") (modalidad alquiler) (precio 1100) (tamanyo 90) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39234669/"))
    (piso (id "Piso en venta en Campo de las Naciones-Corralejos") (modalidad compra) (precio 490000) (tamanyo 150) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/39350852/"))
    (piso (id "Atico en venta en calle de la Bahia de Cadiz") (modalidad compra) (precio 638000) (tamanyo 138) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38081859/"))
    (piso (id "Piso en venta en calle Babilonia, 35") (modalidad compra) (precio 214000) (tamanyo 46) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota no) (link "https://www.idealista.com/inmueble/38296048/"))
    (piso (id "Chalet adosado en venta en Campo de las Naciones-Corralejos") (modalidad compra) (precio 712000) (tamanyo 262) (tipo chalet) (numeroHabitaciones 3) (numeroBanyos 2) (admiteMascota si) (link "https://www.idealista.com/inmueble/37077854/"))
    (piso (id "Piso en venta en calle Bolivar, 8") (modalidad compra) (precio 129300) (tamanyo 38) (tipo piso) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39354705/"))
    (piso (id "Atico en venta en calle Embajadores") (modalidad compra) (precio 395000) (tamanyo 113) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38836375/"))
    (piso (id "Alquiler de piso en Legazpi") (modalidad alquiler) (precio 800) (tamanyo 45) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39283092/"))
    (piso (id "Alquiler de piso en avenida del Planetario") (modalidad alquiler) (precio 1000) (tamanyo 60) (tipo piso) (numeroHabitaciones 1) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39285030/"))
    (piso (id "Atico en venta en calle Embajadores") (modalidad compra) (precio 395000) (tamanyo 113) (tipo atico) (numeroHabitaciones 2) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38836375/"))
    (piso (id "Piso en venta en calle de camarena") (modalidad compra) (precio 194000) (tamanyo 91) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/38621159/"))
    (piso (id "Piso en venta en calle illescas") (modalidad compra) (precio 140000) (tamanyo 72) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/36220592/"))
    (piso (id "Alquiler de piso en Camarena") (modalidad alquiler) (precio 800) (tamanyo 80) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39358567/"))
    (piso (id "Alquiler de piso en calle de Camarena") (modalidad alquiler) (precio 550) (tamanyo 127) (tipo piso) (numeroHabitaciones 3) (numeroBanyos 1) (admiteMascota si) (link "https://www.idealista.com/inmueble/39336112/"))
)

(deffacts MAIN::question-data
    "Las preguntas que puede preguntar el sistema."
    
    (question (ident nombre) (type STRING) (text "Como te llamas? "))
    (question (ident pareja) (type si-no) (text "Tienes pareja? "))
    (question (ident hijos) (type number) (text "Cuantos hijos tienes? "))
    (question (ident mascota) (type si-no) (text "Tienes mascota? "))
    (question (ident edad) (type number) (text "Cuantos anyos tienes? "))
    (question (ident situacionEconomica) (type number) (text "Como definirias tu situacion economica? (1 - Baja, 2 - Normal, 3 - Buena, 4 - Muy buena) "))
    (question (ident trabajoEstable) (type si-no) (text "Tienes un trabajo estable? "))
    (question (ident companyerosPiso) (type number) (text "Cuantos companyeros de piso tienes? "))
    (question (ident estudOFamilia) (type number) (text "Eres estudiante/vives independiente (1) o es un piso familiar (2)? "))
    (question (ident recomendarPor) (type number) (text "Para recomendar por precio ascendente pulse (1), por precio descendente pulse (2), por tamanyo pulse (3) o por mejor adecuacion pulse (4): "))
    (question (ident reiniciarOSalir) (type number) (text "Quieres reiniciar (1) o salir (2)? "))
)

(defrule MAIN::start
    (declare (salience 10000))
    =>
    (printout t crlf "**********************************" crlf)
    (printout t " Bienvenido al recomendador de pisos!" crlf)
    (printout t " Por favor, responda a las preguntas y" crlf)
    (printout t " te dire que pisos te pueden venir bien." crlf)
    (printout t "**********************************" crlf crlf)
    (focus INTERVIEW RECOMMEND REPORT)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module QUESTIONS

(defmodule QUESTIONS (import MAIN ?ALL))

(deffunction QUESTIONS::is-answer-ok (?id ?answer ?type)
    "Comprueba que la respuesta tiene el formato adecuado."
    (if (or (eq ?type si-no) (eq ?type number)) then
        (if (eq ?type si-no) then
            (or (eq ?answer si) (eq ?answer no))
        else
            (if (and (eq ?type number) (integerp ?answer)) then
                (if (or (eq ?id reiniciarOSalir) (or (eq ?id situacionEconomica) (or (eq ?id estudOFamilia) (eq ?id recomendarPor)))) then
                    (if (or (eq ?id estudOFamilia) (eq ?id reiniciarOSalir)) then
                        (or (eq ?answer 1) (eq ?answer 2))
                    else
                        (and (>= ?answer 1) (<= ?answer 4))
                    )
                else
                    (>= ?answer 0)
                )
            else
                FALSE
            )
        )
    else ;; STRING
        (and (not (integerp ?answer)) (> (str-length ?answer) 0))
    )
)

(deffunction QUESTIONS::ask-user (?id ?question ?type)
    "Pregunta y devuelve la respuesta."
    (printout t ?question " ")
    (if (eq ?type si-no) then
        (printout t "(si o no) ")
    )
    (bind ?answer (read))
    (while (not (is-answer-ok ?id ?answer ?type)) do
        (printout t ?question " ")
        (if (eq ?type si-no) then
            (printout t "(si o no) ")
        )
        (bind ?answer (read))
    )
    ?answer
)
   
(defrule QUESTIONS::ask-question-by-id
    "Dado el identificador de una pregunta, la pregunta y asserta la respuesta."
  
    (declare (auto-focus TRUE))
    (question (ident ?id) (text ?text) (type ?type))
    (not (answer (ident ?id)))
    ?ask <- (ask (ident ?id))
    =>
    (bind ?answer (ask-user ?id ?text ?type))
    (assert (answer (ident ?id) (text ?answer)))
    (retract ?ask)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module INTERVIEW

(defmodule INTERVIEW (import MAIN ?ALL)(export ?ALL))

(defrule INTERVIEW::request-nombre
    =>
    (assert (ask (ident nombre))))
(defrule INTERVIEW::request-estudOFamilia
    =>
    (assert (ask (ident estudOFamilia))))
(defrule INTERVIEW::request-pareja
    =>
    (assert (ask (ident pareja))))
(defrule INTERVIEW::request-mascota
    =>
    (assert (ask (ident mascota))))
(defrule INTERVIEW::request-edad
    =>
    (assert (ask (ident edad))))
(defrule INTERVIEW::request-situacionEconomica
    =>
    (assert (ask (ident situacionEconomica))))
(defrule INTERVIEW::request-trabajoEstable
    =>
    (assert (ask (ident trabajoEstable))))
(defrule INTERVIEW::request-recomendarPor
    =>
    (assert (ask (ident recomendarPor))))


(defrule INTERVIEW::request-hijos
    (answer (ident estudOFamilia) (text 2))
    =>
    (assert (ask (ident hijos))))
(defrule INTERVIEW::request-companyerosPiso
    (answer (ident estudOFamilia) (text 1))
    =>
    (assert (ask (ident companyerosPiso))))


(defrule INTERVIEW::assert-usuario-fact
    (declare (salience 100))
    (answer (ident nombre) (text ?n))
    (answer (ident pareja) (text ?p))
    (answer (ident mascota) (text ?m))
    (answer (ident edad) (text ?e))
    (answer (ident situacionEconomica) (text ?s))
    (answer (ident trabajoEstable) (text ?t))
    (answer (ident recomendarPor) (text ?r))
    =>
    (assert (usuario (nombre ?n) (pareja ?p) (mascota ?m) (edad ?e) (situacionEconomica ?s) (trabajoEstable ?t) (recomendarPor ?r)))
)

(defrule INTERVIEW::modify-usuario-hijos
    (answer (ident hijos) (text ?nHijos))
    ?u <- (usuario (nombre ?n) (hijos ?nh))
    (test (neq ?nHijos ?nh))
    =>
    (modify ?u (hijos ?nHijos))
)

(defrule INTERVIEW::modify-usuario-comp
    (answer (ident companyerosPiso) (text ?nComp))
    ?u <- (usuario (nombre ?n) (compPiso ?cp))
    (test (neq ?cp ?nComp))
    =>
    (modify ?u (compPiso ?nComp))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module recommend

(defmodule RECOMMEND (import MAIN ?ALL) (export ?ALL))

;; ========== TIPO USUARIO ==========

;;precioUsuario -> 4-muyAlto 3-alto 2-normal 1-bajo
;;precioPiso -> 4-muyAlto 3-alto 2-normal 1-bajo
;;tamanyoUsuario -> 3-grande 2-medio 1-bajo
;;tamanyoPiso -> 3-grande 2-medio 1-bajo

(defrule RECOMMEND::situacionEconomica1
    (usuario (nombre ?n) (situacionEconomica 4))
    (usuario (nombre ?n) (trabajoEstable si))
    =>
    (assert (precioUsuario ?n 4))
    (assert (tamanyoUsuarioPorDinero ?n 3))
)

(defrule RECOMMEND::situacionEconomica2
    (usuario (nombre ?n) (situacionEconomica 4))
    (usuario (nombre ?n) (trabajoEstable no))
    =>
    (assert (precioUsuario ?n 3))
    (assert (tamanyoUsuarioPorDinero ?n 3))
)

(defrule RECOMMEND::situacionEconomica3
    (usuario (nombre ?n) (situacionEconomica 3))
    (usuario (nombre ?n) (trabajoEstable si))
    =>
    (assert (precioUsuario ?n 3))
    (assert (tamanyoUsuarioPorDinero ?n 3))
)

(defrule RECOMMEND::situacionEconomica4
    (usuario (nombre ?n) (situacionEconomica 3))
    (usuario (nombre ?n) (trabajoEstable no))
    =>
    (assert (precioUsuario ?n 2))
    (assert (tamanyoUsuarioPorDinero ?n 2))
)

(defrule RECOMMEND::situacionEconomica5
    (usuario (nombre ?n) (situacionEconomica 2))
    (usuario (nombre ?n) (trabajoEstable si))
    =>
    (assert (precioUsuario ?n 2))
    (assert (tamanyoUsuarioPorDinero ?n 2))
)

(defrule RECOMMEND::situacionEconomica6
    (usuario (nombre ?n) (situacionEconomica 2))
    (usuario (nombre ?n) (trabajoEstable no))
    =>
    (assert (precioUsuario ?n 1))
    (assert (tamanyoUsuarioPorDinero ?n 2))
)

(defrule RECOMMEND::situacionEconomica7
    (usuario (nombre ?n) (situacionEconomica 1))
    (usuario (nombre ?n) (trabajoEstable si))
    =>
    (assert (precioUsuario ?n 1))
    (assert (tamanyoUsuarioPorDinero ?n 1))
)

(defrule RECOMMEND::situacionEconomica8
    (usuario (nombre ?n) (situacionEconomica 1))
    (usuario (nombre ?n) (trabajoEstable no))
    =>
    (assert (precioUsuario ?n 1))
    (assert (tamanyoUsuarioPorDinero ?n 1))
)

(defrule RECOMMEND::trabajoEstable1
    (usuario (nombre ?n) (trabajoEstable si))
    =>
    (assert (modalidadUsuario ?n alquilerOcompra))
    (assert (modalidadUsuario ?n compra))
    (assert (modalidadUsuario ?n alquiler))
)

(defrule RECOMMEND::trabajoEstable2
    (usuario (nombre ?n) (trabajoEstable no))
    =>
    (assert (modalidadUsuario ?n alquiler))
    (assert (modalidadUsuario ?n alquilerOcompra))
)

(defrule RECOMMEND::tamanyoUsuarioPorPersonas1
    (usuario (nombre ?n) (hijos ?h) (compPiso ?c))
    (test (<= (+ ?h ?c) 1))
    =>
    (assert (tamanyoUsuarioPorPersonas ?n 1))
)

(defrule RECOMMEND::tamanyoUsuarioPorPersonas2
    (usuario (nombre ?n) (hijos ?h) (compPiso ?c))
    (test (> (+ ?h ?c) 1))
    (test (<= (+ ?h ?c) 3))
    =>
    (assert (tamanyoUsuarioPorPersonas ?n 2))
)

(defrule RECOMMEND::tamanyoUsuarioPorPersonas3
    (usuario (nombre ?n) (hijos ?h) (compPiso ?c))
    (test (> (+ ?h ?c) 3))
    =>
    (assert (tamanyoUsuarioPorPersonas ?n 3))
)

(defrule RECOMMEND::numHabBanyoUsuario1
    (usuario (nombre ?n) (hijos 0) (compPiso 0))
    =>
    (assert (numeroHabitacionesUsuario ?n 1))
    (assert (numeroBanyosUsuario ?n 1))
)

(defrule RECOMMEND::numHabBanyoUsuario2
    (usuario (nombre ?n) (hijos 1))     ; Sabemos que si tiene hijos no tiene companyeros de piso
    =>
    (assert (numeroHabitacionesUsuario ?n 2))
    (assert (numeroBanyosUsuario ?n 1))
)

(defrule RECOMMEND::numHabBanyoUsuario3
    (usuario (nombre ?n) (hijos 2))
    =>
    (assert (numeroHabitacionesUsuario ?n 2))
    (assert (numeroBanyosUsuario ?n 2))
)

(defrule RECOMMEND::numHabBanyoUsuario4
    (usuario (nombre ?n) (hijos 3))
    =>
    (assert (numeroHabitacionesUsuario ?n 3))
    (assert (numeroBanyosUsuario ?n 2))
)

(defrule RECOMMEND::numHabBanyoUsuario5
    (usuario (nombre ?n) (hijos ?h))
    (test (>= ?h 4))
    =>
    (assert (numeroHabitacionesUsuario ?n 3))
    (assert (numeroBanyosUsuario ?n 3))
)

(defrule RECOMMEND::numHabBanyoUsuario6
    (usuario (nombre ?n) (compPiso 1))  ; Sabemos que si tiene companyeros de piso no tiene hijos
    =>
    (assert (numeroHabitacionesUsuario ?n 2))
    (assert (numeroBanyosUsuario ?n 1))
)

(defrule RECOMMEND::numHabBanyoUsuario7
    (usuario (nombre ?n) (compPiso 2))
    =>
    (assert (numeroHabitacionesUsuario ?n 3))
    (assert (numeroBanyosUsuario ?n 1))
)

(defrule RECOMMEND::numHabBanyoUsuario8
    (usuario (nombre ?n) (compPiso 3))
    =>
    (assert (numeroHabitacionesUsuario ?n 4))
    (assert (numeroBanyosUsuario ?n 2))
)

(defrule RECOMMEND::numHabBanyoUsuario9
    (usuario (nombre ?n) (compPiso 4))
    =>
    (assert (numeroHabitacionesUsuario ?n 5))
    (assert (numeroBanyosUsuario ?n 2))
)

(defrule RECOMMEND::tipoPisoUsuario1
    ?u <- (usuario (nombre ?n) (edad ?e) (tipoPiso $?tPisos))
    (test (>= ?e 65))
    (test (not (member$ casaRustica $?tPisos)))
    =>
    (modify ?u (tipoPiso (insert$ $?tPisos 1 casaRustica)))
)

(defrule RECOMMEND::tipoPisoUsuario2
    ?u <- (usuario (nombre ?n) (edad ?e) (compPiso ?c) (tipoPiso $?tPisos))
    (test (<= ?e 30))
    (test (> ?c 0))
    (test (not (member$ piso $?tPisos)))
    =>
    (modify ?u (tipoPiso (insert$ $?tPisos 1 piso)))
)

(defrule RECOMMEND::tipoPisoUsuario3
    ?u <- (usuario (nombre ?n) (edad ?e) (hijos ?h) (pareja si) (mascota si) (tipoPiso $?tPisos))
    (test (> ?e 30))
    (test (> ?h 0))
    (test (not (member$ chalet $?tPisos)))
    =>
    (modify ?u (tipoPiso (insert$ $?tPisos 1 chalet)))
)

(defrule RECOMMEND::tipoPisoUsuario4
    ?u <- (usuario (nombre ?n) (situacionEconomica 4) (tipoPiso $?tPisos))
    (test (not (member$ atico $?tPisos)))
    =>
    (modify ?u (tipoPiso (insert$ $?tPisos 1 atico)))
)

(defrule RECOMMEND::tipoPisoUsuario5
    ?u <- (usuario (nombre ?n) (situacionEconomica ?se) (hijos ?h) (compPiso ?c) (tipoPiso $?tPisos))
    (test (>= ?se 3))
    (test (>= (+ ?h ?c) 2))
    (test (not (member$ duplex $?tPisos)))
    =>
    (modify ?u (tipoPiso (insert$ $?tPisos 1 duplex)))
)

;; ========== TIPO PISO ==========

(defrule RECOMMEND::precioPisoMuyAlto1
    (piso (id ?id) (precio ?p) (modalidad compra))
    (test (>= ?p 800000))
    =>
    (assert (precioPiso ?id 4))
)

(defrule RECOMMEND::precioPisoMuyAlto2
    (piso (id ?id) (precio ?p) (modalidad alquiler))
    (test (>= ?p 5000))
    =>
    (assert (precioPiso ?id 4))
)

(defrule RECOMMEND::precioPisoMuyAlto3
    (piso (id ?id) (precio ?p) (modalidad alquilerOcompra))
    (test (>= ?p 5000))
    =>
    (assert (precioPiso ?id 4))
)

(defrule RECOMMEND::precioPisoAlto1
    (piso (id ?id) (precio ?p) (modalidad compra))
    (test (< ?p 800000))
    (test (>= ?p 300000))
    =>
    (assert (precioPiso ?id 3))
)

(defrule RECOMMEND::precioPisoAlto2
    (piso (id ?id) (precio ?p) (modalidad alquiler))
    (test (< ?p 5000))
    (test (>= ?p 2000))
    =>
    (assert (precioPiso ?id 3))
)

(defrule RECOMMEND::precioPisoAlto3
    (piso (id ?id) (precio ?p) (modalidad alquilerOcompra))
    (test (< ?p 5000))
    (test (>= ?p 2000))
    =>
    (assert (precioPiso ?id 3))
)

(defrule RECOMMEND::precioPisoNormal1
    (piso (id ?id) (precio ?p) (modalidad compra))
    (test (< ?p 300000))
    (test (>= ?p 100000))
    =>
    (assert (precioPiso ?id 2))
)

(defrule RECOMMEND::precioPisoNormal2
    (piso (id ?id) (precio ?p) (modalidad alquiler))
    (test (< ?p 2000))
    (test (>= ?p 1000))
    =>
    (assert (precioPiso ?id 2))
)

(defrule RECOMMEND::precioPisoNormal3
    (piso (id ?id) (precio ?p) (modalidad alquilerOcompra))
    (test (< ?p 2000))
    (test (>= ?p 1000))
    =>
    (assert (precioPiso ?id 2))
)

(defrule RECOMMEND::precioPisoBajo1
    (piso (id ?id) (precio ?p) (modalidad compra))
    (test (< ?p 100000))
    =>
    (assert (precioPiso ?id 1))
)

(defrule RECOMMEND::precioPisoBajo2
    (piso (id ?id) (precio ?p) (modalidad alquiler))
    (test (< ?p 1000))
    =>
    (assert (precioPiso ?id 1))
)

(defrule RECOMMEND::precioPisoBajo3
    (piso (id ?id) (precio ?p) (modalidad alquilerOcompra))
    (test (< ?p 1000))
    =>
    (assert (precioPiso ?id 1))
)

(defrule RECOMMEND::tamanyoPiso1
    (piso (id ?id) (tamanyo ?t))
    (test (>= ?t 200))
    =>
    (assert (tamanyoPiso ?id 3))
)

(defrule RECOMMEND::tamanyoPiso2
    (piso (id ?id) (tamanyo ?t))
    (test (< ?t 200))
    (test (>= ?t 80))
    =>
    (assert (tamanyoPiso ?id 2))
)

(defrule RECOMMEND::tamanyoPiso3
    (piso (id ?id) (tamanyo ?t))
    (test (< ?t 80))
    =>
    (assert (tamanyoPiso ?id 1))
)

;; ========== RECOMENDACIONES ==========

(deffunction RECOMMEND::puntuacionPiso (?tamanyoUsuarioPorDinero ?tamanyoUsuarioPorPersonas ?tamanyoPiso ?cantidadUsuario ?cantidadPiso ?tipoPiso $?tPisoUsu)
    (bind ?punt (- 4 (abs (- ?tamanyoUsuarioPorDinero ?tamanyoPiso))))              ;Diferencia entre los parametros reales y los que inferimos que necesita el usuario
    (bind ?punt (+ ?punt (- 4 (abs (- ?tamanyoUsuarioPorPersonas ?tamanyoPiso)))))
    (bind ?punt (+ ?punt (- 4 (abs (- ?cantidadUsuario ?cantidadPiso)))))
    (if (subsetp (create$ ?tipoPiso) $?tPisoUsu) then                   ;Si coincide el tipo de piso con el que hemos inferido para el usuario (si hay)
        (bind ?punt (+ ?punt 6))
    )
    ?punt
)

(defrule RECOMMEND::RecoPiso
    (usuario (nombre ?n) (mascota ?m) (tipoPiso $?tPisoUsu))
    (piso (id ?id) (modalidad ?mod) (admiteMascota ?mPiso) (numeroHabitaciones ?nHab) (numeroBanyos ?nBan) (precio ?precio) (tamanyo ?tam) (tipo ?tipoPiso))

    ;Comprobamos que el precio no se pase de lo que se puede permitir el usuario
    (precioUsuario ?n ?cantidadUsuario)
    (precioPiso ?id ?cantidadPiso)
    (test (<= ?cantidadPiso ?cantidadUsuario))

    (test (not (and (eq ?m si) (eq ?mPiso no)))) ;;Si tiene mascota y no se admite no se lo debe recomendar, en caso contrario si

    ;Comprobamos que el tamanyo sea lo suficientemente grande para el numero de personas pero que no se pase
      ; por el precio (ya que generalmente a mayor tamanyo, mayor precio)
    (tamanyoUsuarioPorDinero ?n ?tamanyoUsuarioPorDinero)
    (tamanyoUsuarioPorPersonas ?n ?tamanyoUsuarioPorPersonas)
    (tamanyoPiso ?id ?tamanyoPiso)
    (test (<= ?tamanyoPiso ?tamanyoUsuarioPorDinero))
    (test (>= ?tamanyoPiso ?tamanyoUsuarioPorPersonas))

    ;Comprobamos que el piso tenga suficientes habitaciones y banyos
    (numeroHabitacionesUsuario ?n ?nHabU)
    (numeroBanyosUsuario ?n ?nBanU)
    (test (>= ?nHab ?nHabU))
    (test (>= ?nBan ?nBanU))

    ;Comprobamos que la modalidad sea la correcta (alquiler, compra o alquiler con opcion a compra)
    (modalidadUsuario ?n ?mod)

    => 

    (bind ?punt (puntuacionPiso ?tamanyoUsuarioPorDinero ?tamanyoUsuarioPorPersonas ?tamanyoPiso ?cantidadUsuario ?cantidadPiso ?tipoPiso $?tPisoUsu))
    (assert (pisoRecomendado (nombre ?n) (id ?id) (precio ?precio) (tamanyo ?tam) (puntuacion ?punt)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Module report

(defmodule REPORT (import MAIN ?ALL))

;Para mostrar solo los N mejores resultados si hay muchos
(deftemplate REPORT::contadorMostrados
    (slot contador 
        (type INTEGER)
        (default 0)
    )
)
(deffacts REPORT::contador
    (contadorMostrados (contador 0))
)

(defrule REPORT::ordenarImprimirPrecioAsc
    (usuario (nombre ?n) (recomendarPor 1))

    ?p <- (pisoRecomendado (nombre ?n) (id ?id) (precio ?p1))
    (not (pisoRecomendado (nombre ?n) (precio ?p2&:(> ?p2 ?p1))))

    (piso (id ?id) (modalidad ?mod) (precio ?prec) (tamanyo ?tam) (tipo ?tipo) (numeroHabitaciones ?nHabs) (numeroBanyos ?nBan) (admiteMascota ?masc) (link ?link))

    ?c <- (contadorMostrados (contador ?cont))
    (test (< ?cont 5))

    =>

    (modify ?c (contador (+ ?cont 1)))

    (printout t crlf)
    (printout t "**** Piso recomendado: " ?id crlf)
    (printout t "**** Precio (euros): " ?prec crlf)
    (printout t "**** Tamanyo (m^2): " ?tam crlf)
    (printout t "**** Modalidad: " ?mod crlf)
    (printout t "**** Tipo: " ?tipo crlf)
    (printout t "**** Numero de Habitaciones: " ?nHabs crlf)
    (printout t "**** Numero de banyos: " ?nBan crlf)
    (printout t "**** Admite mascotas: " ?masc crlf)
    (printout t "**** Mas informacion (link): " ?link crlf)
    (printout t crlf)
    (retract ?p)
)

(defrule REPORT::ordenarImprimirPrecioDesc
    (usuario (nombre ?n) (recomendarPor 2))

    ?p <- (pisoRecomendado (nombre ?n) (id ?id) (precio ?p1))
    (not (pisoRecomendado (nombre ?n) (precio ?p2&:(< ?p2 ?p1))))

    (piso (id ?id) (modalidad ?mod) (precio ?prec) (tamanyo ?tam) (tipo ?tipo) (numeroHabitaciones ?nHabs) (numeroBanyos ?nBan) (admiteMascota ?masc) (link ?link))

    ?c <- (contadorMostrados (contador ?cont))
    (test (< ?cont 5))

    =>

    (modify ?c (contador (+ ?cont 1)))

    (printout t crlf)
    (printout t "**** Piso recomendado: " ?id crlf)
    (printout t "**** Precio (euros): " ?prec crlf)
    (printout t "**** Tamanyo (m^2): " ?tam crlf)
    (printout t "**** Modalidad: " ?mod crlf)
    (printout t "**** Tipo: " ?tipo crlf)
    (printout t "**** Numero de Habitaciones: " ?nHabs crlf)
    (printout t "**** Numero de banyos: " ?nBan crlf)
    (printout t "**** Admite mascotas: " ?masc crlf)
    (printout t "**** Mas informacion (link): " ?link crlf)
    (printout t crlf)
    (retract ?p)
)

(defrule REPORT::ordenarImprimirTamanyo
    (usuario (nombre ?n) (recomendarPor 3))

    ?p <- (pisoRecomendado (nombre ?n) (id ?id) (tamanyo ?tam1))
    (not (pisoRecomendado (nombre ?n) (tamanyo ?tam2&:(> ?tam2 ?tam1))))

    (piso (id ?id) (modalidad ?mod) (precio ?prec) (tamanyo ?tam) (tipo ?tipo) (numeroHabitaciones ?nHabs) (numeroBanyos ?nBan) (admiteMascota ?masc) (link ?link))

    ?c <- (contadorMostrados (contador ?cont))
    (test (< ?cont 5))

    =>

    (modify ?c (contador (+ ?cont 1)))

    (printout t crlf)
    (printout t "**** Piso recomendado: " ?id crlf)
    (printout t "**** Precio (euros): " ?prec crlf)
    (printout t "**** Tamanyo (m^2): " ?tam crlf)
    (printout t "**** Modalidad: " ?mod crlf)
    (printout t "**** Tipo: " ?tipo crlf)
    (printout t "**** Numero de Habitaciones: " ?nHabs crlf)
    (printout t "**** Numero de banyos: " ?nBan crlf)
    (printout t "**** Admite mascotas: " ?masc crlf)
    (printout t "**** Mas informacion (link): " ?link crlf)
    (printout t crlf)
    (retract ?p)
)

(defrule REPORT::ordenarImprimirPuntuacion
    (usuario (nombre ?n) (recomendarPor 4))

    ?p <- (pisoRecomendado (nombre ?n) (id ?id) (puntuacion ?punt1))
    (not (pisoRecomendado (nombre ?n) (puntuacion ?punt2&:(> ?punt2 ?punt1))))

    (piso (id ?id) (modalidad ?mod) (precio ?prec) (tamanyo ?tam) (tipo ?tipo) (numeroHabitaciones ?nHabs) (numeroBanyos ?nBan) (admiteMascota ?masc) (link ?link))

    ?c <- (contadorMostrados (contador ?cont))
    (test (< ?cont 5))

    =>

    (modify ?c (contador (+ ?cont 1)))

    (printout t crlf)
    (printout t "**** Piso recomendado: " ?id crlf)
    (printout t "**** Precio (euros): " ?prec crlf)
    (printout t "**** Tamanyo (m^2): " ?tam crlf)
    (printout t "**** Modalidad: " ?mod crlf)
    (printout t "**** Tipo: " ?tipo crlf)
    (printout t "**** Numero de Habitaciones: " ?nHabs crlf)
    (printout t "**** Numero de banyos: " ?nBan crlf)
    (printout t "**** Admite mascotas: " ?masc crlf)
    (printout t "**** Mas informacion (link): " ?link crlf)
    (printout t crlf)
    (retract ?p)
)

(defrule REPORT::pedirReiniciarOSalir1
    ?c <- (contadorMostrados (contador 5))
    =>
    (printout t crlf)
    (assert (ask (ident reiniciarOSalir)))
)

(defrule REPORT::pedirReiniciarOSalir2
    (not (pisoRecomendado (nombre ?n)))
    (contadorMostrados (contador 0))
    =>
    (printout t crlf)
    (printout t "Lo siento, no hemos encontrado ningun piso adecuado para ti. A continuacion puedes reiniciar, cambiar alguna opcion, e intentaremos tener exito esta vez." crlf)
    (assert (ask (ident reiniciarOSalir)))
)

(defrule REPORT::pedirReiniciarOSalir3
    (not (pisoRecomendado (nombre ?n)))
    (contadorMostrados (contador ?c))
    (test (neq ?c 0))
    =>
    (printout t crlf)
    (assert (ask (ident reiniciarOSalir)))
)

(defrule REPORT::salir
    (answer (ident reiniciarOSalir) (text 2))
    =>
    (printout t crlf)
    (printout t "Hasta la proxima!" crlf)
)

(defrule REPORT::quitarRecomendaciones
    (declare (salience 100))
    (answer (ident reiniciarOSalir) (text 1))
    ?p <- (pisoRecomendado (nombre ?n))
    =>
    (retract ?p)
)

(defrule REPORT::quitarRespuestas
    (declare (salience 100))
    (answer (ident reiniciarOSalir) (text 1))
    ?p <- (answer (ident ?n))
    (test (neq ?n reiniciarOSalir))
    =>
    (retract ?p)
)

(defrule REPORT::reiniciar
    ?a <- (answer (ident reiniciarOSalir) (text 1))
    ?c <- (contadorMostrados (contador ?cont))
    =>
    (modify ?c (contador 0))
    (retract ?a)
    (printout t crlf)
    (printout t "Reiniciando el recomendador!" crlf)
    (reset)
    (run)
)