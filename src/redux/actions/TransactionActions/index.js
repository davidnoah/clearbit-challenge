import * as TransactionUtil from '../../../utils/TransactionUtil';

// Action Constants
export const RECEIVE_TRANSACTIONS = 'RECEIVE_TRANSACTIONS';

// Sync Actions

/**
 * Returns an action creator with a list of transactions
 *
 * @param {Array} services List of transactions
 * @return {Object} An action type and list of transactions
*/
const receiveTransactions = (transactions) => ({
  type: RECEIVE_TRANSACTIONS,
  transactions
});

// Async Actions

/**
 * Asyncronously fetchs for a list of processed tranactions based on a date range
 * @param {String} accessToken - Plaid accessToken
 * @param {String} startDate The start date in the date range
 * @param {String} endDate The start date in the date range
 * @return {promise} A promise object that will resolve with a list of processed transactions
*/
export const getTransactions = (accessToken, startDate, endDate) => dispatch => (
  TransactionUtil.getTransactions(accessToken, startDate, endDate)
    .then(transactions => dispatch(receiveTransactions(transactions)))
);
