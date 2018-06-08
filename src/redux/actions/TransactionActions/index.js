// Action Constants
export const RECEIVE_TRANSACTIONS = 'RECEIVE_TRANSACTIONS';

// Sync Actions

// Async Actions
const getTransactions = (accessToken, startDate, endDate) => dispatch => (
  TransactionUtil.getTransactions(accessToken, startDate, endDate)
    .then(transactions => dispatch(receiveTransactions(transactions)))
);
