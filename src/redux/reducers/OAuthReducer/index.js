import * as actions from '../../actions/OAuthActions';

const initialState = {
  accessToken: null
};

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