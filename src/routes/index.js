import React from 'react';
import { Switch, Route } from 'react-router-dom';

// Route Components
import Home from './Home';
import Transactions from './Transactions';

const Routes = () => {
  return (
    <div>
      <Switch>
        <Route
          path="/"
          component={ Home }
          exact={ true }
        />
        <Route
          path="/transactions"
          component={ Transactions }
        />
      </Switch>
    </div>
  );
};

export default Routes;
