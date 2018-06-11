import React from 'react';
import BankLink from '../../components/BankLink';

/**
 * Renders the Home route
 * @returns {React.Component} Returns a react component
 */
class Home extends React.Component {
  render() {
    return (
      <div>
        <BankLink />
      </div>
    );
  }
}

export default Home;
