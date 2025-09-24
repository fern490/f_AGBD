import React from "react";
import Login from "./Login";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  useNavigate,
} from "react-router-dom";

import AdminDashboard from "./pages/AdminDashboard";
import ClienteDashboard from "./pages/ClienteDashboard";
import Home from "./pages/Home";

function App() {
  return (
    <div style={styles.appContainer}>
      <Login />
    </div>
  );
}

//
const styles = {
  appContainer: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    minHeight: "100vh",
  },
};

export default App;
