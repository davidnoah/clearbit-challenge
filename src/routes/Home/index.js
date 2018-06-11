import React from 'react';
import BankLink from '../../components/BankLink';

import './Home.css';

/**
 * Renders the Home route
 * @returns {React.Component} Returns a react component
 */
class Home extends React.Component {
  render() {
    return (
      <div className="home__container">
        <h2>Welcome!</h2>
        <BankLink />
      </div>
    );
  }
}

export default Home;
