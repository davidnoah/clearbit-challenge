import * as actions from '../../actions/TransactionActions';

const initialState = [];

/**
 * Assesses for transaction oriented action type and returns a new transaction state
 *
 * @param {Object} state The previous or initial transaction state
 * @param {Object} action The incoming action creator
 * @return {promise} The previous or new state object
*/
function TransactionReducer(state = initialState, action = {}) {
  switch (action.type) {
    case actions.RECEIVE_TRANSACTIONS: {
      return action.transactions;
    }
    default:
      return state;
  }
}

export default TransactionReducer;
