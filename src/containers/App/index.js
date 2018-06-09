import React, { Component } from 'react';
import { history } from '../../redux/createStore';
import { Router } from 'react-router';
import Routes from '../../routes';

import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <Router history={ history }>
          <Routes />
        </Router>
      </div>
    );
  }
}

export default App;
