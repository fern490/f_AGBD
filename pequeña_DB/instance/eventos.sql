/* Es la base → todos los torneos ocurren dentro de eventos */

CREATE TABLE eventos_discoteca (
    evento_id INTEGER PRIMARY KEY,
    nombre_evento TEXT,
    fecha INTEGER,
    tema TEXT,
    capacidad INTEGER
);

CREATE TABLE torneos (
    torneo_id INTEGER PRIMARY KEY,
    evento_id INTEGER,
    juego TEXT,
    hora_inicio TIME,
    max_jugadores INTEGER,
    FOREIGN KEY (evento_id) REFERENCES eventos_discoteca(evento_id)
);

CREATE TABLE jugadores (
    jugador_id INTEGER PRIMARY KEY,
    nombre TEXT,
    nickname TEXT,
    edad INTEGER
);

CREATE TABLE asistencias_evento (
    asistencia_id INTEGER PRIMARY KEY,
    jugador_id INTEGER,
    evento_id INTEGER,
    hora_entrada TIME,
    FOREIGN KEY (jugador_id) REFERENCES jugadores(jugador_id),
    FOREIGN KEY (evento_id) REFERENCES eventos_discoteca(evento_id)
);

CREATE TABLE inscripciones (
    inscripcion_id INTEGER PRIMARY KEY,
    jugador_id INTEGER,
    torneo_id INTEGER,
    fecha_inscripcion DATE,
    FOREIGN KEY (jugador_id) REFERENCES jugadores(jugador_id),
    FOREIGN KEY (torneo_id) REFERENCES torneos(torneo_id)
);

CREATE TABLE resultados (
    resultado_id INTEGER PRIMARY KEY,
    inscripcion_id INTEGER,
    torneo_id INTEGER,
    jugador_id INTEGER,
    posicion INTEGER,
    puntos INTEGER,
    FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(inscripcion_id),
    FOREIGN KEY (torneo_id) REFERENCES torneos(torneo_id),
    FOREIGN KEY (jugador_id) REFERENCES jugadores(jugador_id)
);


