from flask import Blueprint, request, jsonify, url_for, render_template
from models import Evento, Torneo, Jugador, AsistenciaEvento, Inscripcion, Resultado
from config import db
from datetime import date, time

routes = Blueprint('routes', __name__)

# EVENTOS

@routes.route("/eventos", methods=["POST"])
def crear_evento():
    data = request.json
    nuevo_evento = Evento(
        nombre_evento=data["nombre_evento"],
        fecha=date.fromisoformat(data["fecha"]),
        tema=data.get("tema"),
        capacidad=data.get("capacidad", 0)
    )
    db.session.add(nuevo_evento)
    db.session.commit()
    return jsonify({"mensaje": "Evento creado"}), 201

@routes.route("/eventos", methods=["GET"])
def listar_eventos():
    eventos = Evento.query.all()
    return jsonify([{
        "id": e.evento_id,
        "nombre": e.nombre_evento,
        "fecha": e.fecha.isoformat(),
        "tema": e.tema,
        "capacidad": e.capacidad
    } for e in eventos])

@routes.route("/eventos/<int:id>", methods=["PUT"])
def actualizar_evento(id):
    evento = Evento.query.get_or_404(id)
    data = request.json
    evento.nombre_evento = data.get("nombre_evento", evento.nombre_evento)
    if "fecha" in data:
        evento.fecha = date.fromisoformat(data["fecha"])
    evento.tema = data.get("tema", evento.tema)
    evento.capacidad = data.get("capacidad", evento.capacidad)
    db.session.commit()
    return jsonify({"mensaje": "Evento actualizado"})

@routes.route("/eventos/<int:id>", methods=["DELETE"])
def eliminar_evento(id):
    evento = Evento.query.get_or_404(id)
    db.session.delete(evento)
    db.session.commit()
    return jsonify({"mensaje": "Evento eliminado"})

# JUGADORES

@routes.route("/jugadores", methods=["POST"])
def crear_jugador():
    data = request.json
    jugador = Jugador(
        nombre=data["nombre"],
        nickname=data["nickname"],
        edad=data["edad"]
    )
    db.session.add(jugador)
    db.session.commit()
    return jsonify({"mensaje": "Jugador creado"}), 201

@routes.route("/jugadores", methods=["GET"])
def listar_jugadores():
    jugadores = Jugador.query.all()
    return jsonify([{
        "id": j.jugador_id,
        "nombre": j.nombre,
        "nickname": j.nickname,
        "edad": j.edad
    } for j in jugadores])

@routes.route("/jugadores/<int:id>", methods=["PUT"])
def actualizar_jugador(id):
    jugador = Jugador.query.get_or_404(id)
    data = request.json
    jugador.nombre = data.get("nombre", jugador.nombre)
    jugador.nickname = data.get("nickname", jugador.nickname)
    jugador.edad = data.get("edad", jugador.edad)
    db.session.commit()
    return jsonify({"mensaje": "Jugador actualizado"})

@routes.route("/jugadores/<int:id>", methods=["DELETE"])
def eliminar_jugador(id):
    jugador = Jugador.query.get_or_404(id)
    db.session.delete(jugador)
    db.session.commit()
    return jsonify({"mensaje": "Jugador eliminado"})

# TORNEOS

@routes.route("/torneos", methods=["POST"])
def crear_torneo():
    data = request.json
    torneo = Torneo(
        evento_id=data["evento_id"],
        juego=data["juego"],
        hora_inicio=time.fromisoformat(data["hora_inicio"]),
        max_jugadores=data["max_jugadores"]
    )
    db.session.add(torneo)
    db.session.commit()
    return jsonify({"mensaje": "Torneo creado"}), 201

@routes.route("/torneos", methods=["GET"])
def listar_torneos():
    torneos = Torneo.query.all()
    return jsonify([{
        "id": t.torneo_id,
        "evento_id": t.evento_id,
        "juego": t.juego,
        "hora_inicio": t.hora_inicio.isoformat(),
        "max_jugadores": t.max_jugadores
    } for t in torneos])

@routes.route("/torneos/<int:id>", methods=["PUT"])
def actualizar_torneo(id):
    torneo = Torneo.query.get_or_404(id)
    data = request.json
    torneo.evento_id = data.get("evento_id", torneo.evento_id)
    torneo.juego = data.get("juego", torneo.juego)
    if "hora_inicio" in data:
        torneo.hora_inicio = time.fromisoformat(data["hora_inicio"])
    torneo.max_jugadores = data.get("max_jugadores", torneo.max_jugadores)
    db.session.commit()
    return jsonify({"mensaje": "Torneo actualizado"})

@routes.route("/torneos/<int:id>", methods=["DELETE"])
def eliminar_torneo(id):
    torneo = Torneo.query.get_or_404(id)
    db.session.delete(torneo)
    db.session.commit()
    return jsonify({"mensaje": "Torneo eliminado"})

# INSCRIPCIONES

@routes.route("/inscripciones", methods=["POST"])
def crear_inscripcion():
    data = request.json
    inscripcion = Inscripcion(
        jugador_id=data["jugador_id"],
        torneo_id=data["torneo_id"],
        fecha_inscripcion=date.fromisoformat(data["fecha_inscripcion"])
    )
    db.session.add(inscripcion)
    db.session.commit()
    return jsonify({"mensaje": "Inscripción creada"}), 201

@routes.route("/inscripciones", methods=["GET"])
def listar_inscripciones():
    inscripciones = Inscripcion.query.all()
    return jsonify([{
        "id": i.inscripcion_id,
        "jugador_id": i.jugador_id,
        "torneo_id": i.torneo_id,
        "fecha_inscripcion": i.fecha_inscripcion.isoformat()
    } for i in inscripciones])

@routes.route("/inscripciones/<int:id>", methods=["PUT"])
def actualizar_inscripcion(id):
    inscripcion = Inscripcion.query.get_or_404(id)
    data = request.json
    inscripcion.jugador_id = data.get("jugador_id", inscripcion.jugador_id)
    inscripcion.torneo_id = data.get("torneo_id", inscripcion.torneo_id)
    if "fecha_inscripcion" in data:
        inscripcion.fecha_inscripcion = date.fromisoformat(data["fecha_inscripcion"])
    db.session.commit()
    return jsonify({"mensaje": "Inscripción actualizada"})

@routes.route("/inscripciones/<int:id>", methods=["DELETE"])
def eliminar_inscripcion(id):
    inscripcion = Inscripcion.query.get_or_404(id)
    db.session.delete(inscripcion)
    db.session.commit()
    return jsonify({"mensaje": "Inscripción eliminada"})

# RESULTADOS

@routes.route("/resultados", methods=["POST"])
def crear_resultado():
    data = request.json
    resultado = Resultado(
        inscripcion_id=data["inscripcion_id"],
        posicion=data["posicion"],
        puntos=data["puntos"]
    )
    db.session.add(resultado)
    db.session.commit()
    return jsonify({"mensaje": "Resultado creado"}), 201

@routes.route("/resultados", methods=["GET"])
def listar_resultados():
    resultados = Resultado.query.all()
    return jsonify([{
        "id": r.resultado_id,
        "inscripcion_id": r.inscripcion_id,
        "posicion": r.posicion,
        "puntos": r.puntos
    } for r in resultados])

@routes.route("/resultados/<int:id>", methods=["PUT"])
def actualizar_resultado(id):
    resultado = Resultado.query.get_or_404(id)
    data = request.json
    resultado.inscripcion_id = data.get("inscripcion_id", resultado.inscripcion_id)
    resultado.posicion = data.get("posicion", resultado.posicion)
    resultado.puntos = data.get("puntos", resultado.puntos)
    db.session.commit()
    return jsonify({"mensaje": "Resultado actualizado"})

@routes.route("/resultados/<int:id>", methods=["DELETE"])
def eliminar_resultado(id):
    resultado = Resultado.query.get_or_404(id)
    db.session.delete(resultado)
    db.session.commit()
    return jsonify({"mensaje": "Resultado eliminado"})

# ASISTENCIAS

@routes.route("/asistencias", methods=["POST"])
def crear_asistencia():
    data = request.json
    asistencia = AsistenciaEvento(
        jugador_id=data["jugador_id"],
        evento_id=data["evento_id"],
        hora_entrada=time.fromisoformat(data["hora_entrada"])
    )
    db.session.add(asistencia)
    db.session.commit()
    return jsonify({"mensaje": "Asistencia registrada"}), 201

@routes.route("/asistencias", methods=["GET"])
def listar_asistencias():
    asistencias = AsistenciaEvento.query.all()
    return jsonify([{
        "id": a.asistencia_id,
        "jugador_id": a.jugador_id,
        "evento_id": a.evento_id,
        "hora_entrada": a.hora_entrada.isoformat()
    } for a in asistencias])

@routes.route("/asistencias/<int:id>", methods=["PUT"])
def actualizar_asistencia(id):
    asistencia = AsistenciaEvento.query.get_or_404(id)
    data = request.json
    asistencia.jugador_id = data.get("jugador_id", asistencia.jugador_id)
    asistencia.evento_id = data.get("evento_id", asistencia.evento_id)
    if "hora_entrada" in data:
        asistencia.hora_entrada = time.fromisoformat(data["hora_entrada"])
    db.session.commit()
    return jsonify({"mensaje": "Asistencia actualizada"})

@routes.route("/asistencias/<int:id>", methods=["DELETE"])
def eliminar_asistencia(id):
    asistencia = AsistenciaEvento.query.get_or_404(id)
    db.session.delete(asistencia)
    db.session.commit()
    return jsonify({"mensaje": "Asistencia eliminada"})
