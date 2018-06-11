import * as actions from '../../actions/OAuthActions';

const initialState = {
  accessToken: null
};

/**
 * Assesses for oauth oriented action type and returns a new oauth state
 *
 * @param {Object} state The previous or initial oauth state
 * @param {Object} action The incoming action creator
 * @return {promise} The previous or new state object
*/
function OAuthReducer(state = initialState, action = {}) {
  switch (action.type) {
    case actions.RECEIVE_ACCESS_TOKEN: {
      return { ...state, accessToken: action.accessToken };
    }
    default:
      return state;
  }
}

export default OAuthReducer;
