// src/components/Login.jsx
import React, { useState } from "react";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [role, setRole] = useState(""); // nuevo: rol seleccionado

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!email || !password || !role) {
      setError("Por favor, completa todos los campos y selecciona un rol");
      return;
    }

    console.log("Enviando datos:", { email, password, role });
    setError("");
  };

  return (
    <div style={styles.container}>
      <h2>Iniciar Sesión</h2>
      <form onSubmit={handleSubmit} style={styles.form}>
        <input
          type="email"
          placeholder="Correo electrónico"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          style={styles.input}
        />
        <input
          type="password"
          placeholder="Contraseña"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          style={styles.input}
        />
        <div style={styles.roles}>
          <button
            type="button"
            style={{
              ...styles.roleButton,
              backgroundColor: role === "admin" ? "#4CAF50" : "#ddd",
              color: role === "admin" ? "white" : "black",
            }}
            onClick={() => setRole("admin")}
          >
            Administrador
          </button>
          <button
            type="button"
            style={{
              ...styles.roleButton,

              backgroundColor: role === "cliente" ? "#4CAF50" : "#ddd",

              color: role === "cliente" ? "white" : "black",
            }}
            onClick={() => setRole("cliente")}
          >
            Cliente
          </button>
          <button
            type="button"
            style={{
              ...styles.roleButton,

              backgroundColor: role === "otros" ? "#4CAF50" : "#ddd",
              color: role === "otros" ? "white" : "black",
            }}
            onClick={() => setRole("otros")}
          >
            Otros
          </button>
        </div>

        {error && <p style={styles.error}>{error}</p>}

        <button type="submit" style={styles.button}>
          Entrar
        </button>
      </form>
    </div>
  );
};

// Estilos

const styles = {
  container: {
    width: "320px",
    margin: "100px auto",
    padding: "20px",
    border: "1px solid #ccc",
    borderRadius: "8px",
    textAlign: "center",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },

  form: {
    display: "flex",
    flexDirection: "column",
  },

  input: {
    margin: "10px 0",
    padding: "10px",
    fontSize: "16px",
  },

  roles: {
    display: "flex",
    justifyContent: "space-between",
    margin: "15px 0",
  },

  roleButton: {
    flex: 1,
    margin: "0 5px",
    padding: "10px",
    border: "none",
    cursor: "pointer",
    borderRadius: "4px",
    fontSize: "14px",
  },

  button: {
    padding: "10px",
    backgroundColor: "#4CAF50",
    color: "white",
    border: "none",
    cursor: "pointer",
    borderRadius: "4px",
  },

  error: {
    color: "red",
    fontSize: "14px",
  },
};

export default Login;
