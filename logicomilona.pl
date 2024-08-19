% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)


% Punto 1

esCrack(Chef) :- 
    cocinaEn(Restaurante1,Chef),
    cocinaEn(Restaurante2,Chef),
    Restaurante1 \= Restaurante2. 

esCrack(Chef) :- 
    elabora(Chef, padThai). 

% Punto 2

esOtaku(Chef) :- 
    cocinaEn(_, Chef),
    forall(cocinaEn(Restaurante,Chef), tieneEstilo(Restaurante, oriental(japon))). 


% Punto 3

esTop(Plato) :- 
    elabora(_, Plato),
    forall(elabora(Chef, Plato), esCrack(Chef)).

% Punto 4 

esDificil(Plato) :- 
    receta(Plato, Duracion, _),
    Duracion > 120. 

esDificil(Plato) :- 
    receta(Plato,_,Ingredientes),
    member(trufa,Ingredientes). 

esDificil(souffleDeQueso). 


% Punto 5 

seMereceLaMichelin(Restaurante) :- 
    cocinaEn(Restaurante, Chef),
    esCrack(Chef),
    tieneEstilo(Restaurante, Estilo),
    estiloMichelinero(Estilo). 

estiloMichelinero(oriental(tailandia)).
estiloMichelinero(bodegon(palermo,_)).


estiloMichelinero(italiano(CantidadPastas)) :-
    CantidadPastas > 5. 

estiloMichelinero(mexicano(Ingredientes)) :-
    member(rocoto, Ingredientes),
    member(habanero, Ingredientes). 

% Punto 6

tieneMayorRepertorio(Restaurante, OtroRestaurante) :- 
    Restaurante \= OtroRestaurante,
    cantidadDePlatosRestaurante(Restaurante, CantPlatos),
    cantidadDePlatosRestaurante(OtroRestaurante, OtraCantidadPlatos),
    CantPlatos > OtraCantidadPlatos. 

cantidadDePlatosRestaurante(Restaurante, CantidadDePlatos) :- 
    cocinaEn(Restaurante,Chef),
    findall(Platos, elabora(Chef, Platos), ListaDePlatos), 
    length(ListaDePlatos, CantidadDePlatos).
    

calificacionGastronomica(Restaurante, Calificacion) :-
    cantidadDePlatosRestaurante(Restaurante, CantPlatos),
    Calificacion is CantPlatos * 5. 

% prueba 