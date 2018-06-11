import { request } from '../request';

/**
 * API call to /transactions
 *
 * @param {string} access_token Plaid's accessToken
 * @param {string} start_date initial date of the date range query
 * @param {string} end_date end date of the date range query
 * @return {promise} A promise object that will resolve with an array of transactions
*/
export const getTransactions = (access_token, start_date, end_date) => (
  request({
    path: '/transactions',
    method: 'GET',
    queryParams: {
      access_token,
      start_date,
      end_date
    }
  })
);
