
% -- BASE DE CONOCIMIENTO --

% Datos de ciudades
eclipse(arrecifes,     buenosAires, horario(17, 44), 2.5,  duracion(0, 40)).
eclipse(bellaVista,    sanJuan,     horario(17, 41), 11.5, duracion(2, 27)).
eclipse(carmenDeAreco, buenosAires, horario(17, 44), 2.1,  duracion(1, 30)).
eclipse(chacabuco,     buenosAires, horario(17, 43), 2.6,  duracion(2, 07)).
eclipse(chepes,        laRioja,     horario(17, 42), 8.9,  duracion(2, 03)).
eclipse(ezeiza,        buenosAires, horario(17, 44), 0.9,  duracion(1, 01)).
eclipse(jachal,        sanJuan, 	horario(17, 41), 11.1, duracion(1, 39)).
eclipse(pergamino,     buenosAires, horario(17, 44), 2.9,  duracion(0, 56)).
eclipse(quines,        sanLuis,     horario(17, 42), 7.8,  duracion(2, 13)).
eclipse(rodeo,         sanJuan, 	horario(17, 41), 11.5, duracion(2, 16)).
eclipse(rioCuarto,     cordoba, 	horario(17, 42), 6.3,  duracion(1, 54)).
eclipse(venadoTuerto,  santaFe, 	horario(17, 43), 4.1,  duracion(2, 11)).
eclipse(merlo,         sanLuis, 	horario(17, 42), 7.1,  duracion(2, 19)).

% Servicios
servicio(bellaVista,   telescopio).
servicio(chepes, 	   telescopio).
servicio(ezeiza, 	   telescopio).
servicio(chacabuco,    reposeras).
servicio(arrecifes,    reposeras).
servicio(chepes,  	   reposeras).
servicio(venadoTuerto, reposeras).
servicio(quines, 	   observatorio).
servicio(rodeo, 	   lentes).
servicio(rioCuarto,    lentes).
servicio(merlo, 	   lentes).

seVeElEclipse(Ciudad, Provincia, Horario, Altura, Duracion):-
    eclipse(Ciudad, Provincia, Horario, Altura,  DuracionOriginal),
    conversionSegundos(DuracionOriginal, Duracion).

conversionSegundos(duracion(Minutos, Segundos), SegundosTotales):-
    SegundosTotales is Minutos * 60 + Segundos.

conversionMinutos(duracion(Minutos, Segundos), SegundosTotales):-
    Minutos is SegundosTotales div 60,
    Segundos is SegundosTotales mod 60.

% Punto 1
buenLugar(Lugar) :-
	eclipse(Lugar, _, horario(Hora, Minutos), _, _),
	Hora >= 17,
	Minutos > 42.

buenLugar(Lugar) :-
	eclipse(Lugar, _, _, Altura, _),
	Altura > 10.

% Punto 2
lugaresSinServicios(Lugar) :-
	seVeElEclipse(Lugar, _, _, _, _),
	not(servicio(Lugar, _)).

% Punto 3
seVeEnUnaSolaCiudad(Provincia) :-
    seVeElEclipse(CiudadA, Provincia, _, _, _),
    forall(seVeElEclipse(CiudadB, Provincia, _, _, _), CiudadA == CiudadB).

% Punto 4
lugarConMayorDuracion(Lugar) :-
	seVeElEclipse(Lugar, _, _, _, Duracion),
	not((seVeElEclipse(_, _, _, _, Duracion2), Duracion2 > Duracion)).

% Punto 5

% Parte A
duracionPromedioPais(Promedio) :-
	findall(Duracion, seVeElEclipse(_, _, _, _, Duracion), Lista),
	promedioDuracion(Lista, Promedio).

% Parte B
promedioProvincia(Provincia, Promedio) :-
	seVeElEclipse(_, Provincia, _, _, _),
	findall(Duracion, seVeElEclipse(_, Provincia, _, _, Duracion), Lista),
	promedioDuracion(Lista, Promedio).

% Parte C
promedioCiudadesConTelescopio(Ciudad, Promedio) :-
	seVeElEclipse(Ciudad, _, _, _, _),
	servicio(Ciudad, telescopio),
	findall(Duracion, seVeElEclipse(Ciudad, _, _, _, Duracion), Lista),
	promedioDuracion(Lista, Promedio).

promedioDuracion(Duraciones, Promedio) :-
	promedio(Duraciones, PromedioSegundos),
	conversionMinutos(Promedio, PromedioSegundos).

promedio(Lista, Promedio) :-
	sumlist(Lista, SumatoriaTotal),
	length(Lista, Total),
	Promedio is SumatoriaTotal // Total.