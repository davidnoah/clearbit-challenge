import React from 'react';
import './Loader.css';

/**
 * Renders the loader component
 * @returns {React.Component}  Returns a stateless react component
 */
const Loader = () => (
  <div className="loader">
    <div className="cube-grid">
      <div className="cube cube1" />
      <div className="cube cube2" />
      <div className="cube cube3" />
      <div className="cube cube4" />
      <div className="cube cube5" />
      <div className="cube cube6" />
      <div className="cube cube7" />
      <div className="cube cube8" />
      <div className="cube cube9" />
    </div>
  </div>
);

export default Loader;
