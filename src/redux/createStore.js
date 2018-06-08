import {
  createStore,
  applyMiddleware,
  compose
} from 'redux';
import thunk from 'redux-thunk';
import { routerMiddleware } from 'react-router-redux';
import createHistory from 'history/createBrowserHistory';
import rootReducer from './reducers';

export const history = createHistory();

const middleware = [thunk, routerMiddleware(history)];

const finalCreateStore = compose(
  applyMiddleware(...middleware),
  process.env.NODE_ENV === 'development' && window.devToolsExtension ?
    window.devToolsExtension() :
    f => f
)(createStore);

function configureStore(preloadedState) {
  const store = finalCreateStore(rootReducer, preloadedState);

  if (module.hot) {
    // Enable Webpack hot module replacement for reducers
    module.hot.accept('./reducers', () => {
      store.replaceReducer(rootReducer);
    });
  }

  return store;
}

export default configureStore();