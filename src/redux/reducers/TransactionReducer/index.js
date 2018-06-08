import * as actions from '../../actions/TransactionActions';

const initialState = [];

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