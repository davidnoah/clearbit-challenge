import * as TransactionUtil from '../../../utils/TransactionUtil';

// Action Constants
export const RECEIVE_TRANSACTIONS = 'RECEIVE_TRANSACTIONS';

// Sync Actions
const receiveTransactions = (transactions) => ({
  type: RECEIVE_TRANSACTIONS,
  transactions
});

// Async Actions
export const getTransactions = (accessToken, startDate, endDate) => dispatch => (
  TransactionUtil.getTransactions(accessToken, startDate, endDate)
    .then(transactions => dispatch(receiveTransactions(transactions)))
);
