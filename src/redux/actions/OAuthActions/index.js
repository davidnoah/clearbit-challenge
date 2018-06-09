import * as OAuthUtil from '../../../utils/OAuthUtil';

// Action Constants
export const RECEIVE_ACCESS_TOKEN = 'RECEIEVE_ACCESS_TOKEN';

// Sync Actions
const receieveAccessToken = (accessToken) => ({
  type: RECEIVE_ACCESS_TOKEN,
  accessToken
});

// Async Actions
export const createAccessToken = (publicToken) => dispatch => (
  OAuthUtil.createAccessToken(publicToken)
    .then(response => dispatch(receieveAccessToken(response.access_token)))
);
