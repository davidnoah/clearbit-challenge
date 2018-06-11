import * as OAuthUtil from '../../../utils/OAuthUtil';

// Action Constants
export const RECEIVE_ACCESS_TOKEN = 'RECEIEVE_ACCESS_TOKEN';

// Sync Actions

/**
 * Returns an action creator with an accessToken
 *
 * @param {String} accessToken Plaid accessToken
 * @return {Object} An action type and a accessToken
*/
const receieveAccessToken = (accessToken) => ({
  type: RECEIVE_ACCESS_TOKEN,
  accessToken
});

// Async Actions

/**
 * Asyncronously exchanges a Plaid publicToken for a Plaid accessToken
 * @param {String} publicToken - Plaid publicToken
 * @return {promise} A promise object that will resolve with a Plaid accessToken
*/
export const createAccessToken = (publicToken) => dispatch => (
  OAuthUtil.createAccessToken(publicToken)
    .then(response => dispatch(receieveAccessToken(response.access_token)))
);
