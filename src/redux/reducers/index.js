import { combineReducers } from 'redux';
import transactions from './TransactionReducer';
import oauth from './OAuthReducer';

export default combineReducers({ transactions, oauth });