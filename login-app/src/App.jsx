import React from "react";
import Login from "./Login";

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
