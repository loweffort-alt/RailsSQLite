import * as React from "react";
import * as ReactDOM from "react-dom";

const Home = () => {
  return (
    <div className="bg-red-700">
      <h1>Hola amiguitos</h1>
    </div>
  );
};

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<Home />, document.getElementById("welcome"));
});

export default Home;
