import { combineReducers } from 'redux';
import transactions from './TransactionReducer';

export default combineReducers({ transactions });