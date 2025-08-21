from config import db

# MODELOS

class Evento(db.Model):
    __tablename__ = 'eventos_discoteca'
    evento_id = db.Column(db.Integer, primary_key=True)
    nombre_evento = db.Column(db.String)
    fecha = db.Column(db.Date)
    tema = db.Column(db.String)
    capacidad = db.Column(db.Integer)

class Torneo(db.Model):
    __tablename__ = 'torneos'
    torneo_id = db.Column(db.Integer, primary_key=True)
    evento_id = db.Column(db.Integer, db.ForeignKey('eventos_discoteca.evento_id'))
    juego = db.Column(db.String)
    hora_inicio = db.Column(db.Time)
    max_jugadores = db.Column(db.Integer)

class Jugador(db.Model):
    __tablename__ = 'jugadores'
    jugador_id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String)
    nickname = db.Column(db.String)
    edad = db.Column(db.Integer)

class AsistenciaEvento(db.Model):
    __tablename__ = 'asistencias_evento'
    asistencia_id = db.Column(db.Integer, primary_key=True)
    jugador_id = db.Column(db.Integer, db.ForeignKey('jugadores.jugador_id'))
    evento_id = db.Column(db.Integer, db.ForeignKey('eventos_discoteca.evento_id'))
    hora_entrada = db.Column(db.Time)

class Inscripcion(db.Model):
    __tablename__ = 'inscripciones'
    inscripcion_id = db.Column(db.Integer, primary_key=True)
    jugador_id = db.Column(db.Integer, db.ForeignKey('jugadores.jugador_id'))
    torneo_id = db.Column(db.Integer, db.ForeignKey('torneos.torneo_id'))
    fecha_inscripcion = db.Column(db.Date)

class Resultado(db.Model):
    __tablename__ = 'resultados'
    resultado_id = db.Column(db.Integer, primary_key=True)
    inscripcion_id = db.Column(db.Integer, db.ForeignKey('inscripciones.inscripcion_id'))
    torneo_id = db.Column(db.Integer, db.ForeignKey('torneos.torneo_id'))
    jugador_id = db.Column(db.Integer, db.ForeignKey('jugadores.jugador_id'))
    posicion = db.Column(db.Integer)
    puntos = db.Column(db.Integer)