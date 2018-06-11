import { request } from '../request';

/**
 * API call to /oauth/access-token
 *
 * @param {string} public_token Plaid's public_token
 * @return {promise} A promise object that will resolve with an access_token
*/
export const createAccessToken = (public_token) => (
  request({
    path: '/oauth/access-token',
    method: 'POST',
    body: {
      public_token
    }
  })
);
