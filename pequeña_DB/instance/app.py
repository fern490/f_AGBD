from flask import Flask, jsonify, request, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import time, date

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///discoteca.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# MODELOS

class Evento(db.Model):
    __tablename__ = 'eventos_discoteca'
    evento_id = db.Column(db.Integer, primary_key=True)
    nombre_evento = db.Column(db.String)
    fecha = db.Column(db.Integer)
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

# ENDPOINTS

@app.route('/eventos', methods=['GET'])
def obtener_eventos():
    eventos = Evento.query.all()
    return jsonify([{
        'evento_id': e.evento_id,
        'nombre_evento': e.nombre_evento,
        'fecha': e.fecha,
        'tema': e.tema,
        'capacidad': e.capacidad
    } for e in eventos])

@app.route('/torneos', methods=['POST'])
def crear_torneo():
    data = request.get_json()
    nuevo_torneo = Torneo(
        evento_id=data['evento_id'],
        juego=data['juego'],
        hora_inicio=time.fromisoformat(data['hora_inicio']),
        max_jugadores=data['max_jugadores']
    )
    db.session.add(nuevo_torneo)
    db.session.commit()
    return jsonify({'mensaje': 'Torneo creado', 'torneo_id': nuevo_torneo.torneo_id}), 201

@app.route('/ranking', methods=['GET'])
def ranking_jugadores():
    resultados = db.session.query(
        Jugador.nickname,
        db.func.sum(Resultado.puntos).label('total_puntos')
    ).join(Resultado, Resultado.jugador_id == Jugador.jugador_id)\
     .group_by(Jugador.nickname)\
     .order_by(db.desc('total_puntos')).all()

    return jsonify([{'nickname': r.nickname, 'puntos': r.total_puntos} for r in resultados])

# INICIAR APP

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
