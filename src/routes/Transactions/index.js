import React from 'react';
import { connect } from 'react-redux';
import { func, object, string, array } from 'prop-types';
import { getTransactions } from '../../redux/actions/TransactionActions';
import { bindAll } from 'lodash';
import DatePicker from 'react-datepicker';
import moment from 'moment';
import Table from '../../components/Table';
import Loader from '../../components/Loader';

import './Transactions.css';
import 'react-datepicker/dist/react-datepicker.css';

class Transactions extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoading: false,
      startDate: moment().subtract(7, 'days'),
      endDate: moment()
    };

    bindAll(this, 'queryTransactions', 'clearLoader');
  }

  componentDidMount() {
    const { accessToken, history } = this.props;

    if (!accessToken) {
      return history.push('/');
    }
  }

  async queryTransactions() {
    const startDate = this.state.startDate.format('YYYY-MM-DD');
    const endDate = this.state.endDate.format('YYYY-MM-DD');
    console.log(startDate, endDate);
    this.queryWithLoader(() => (
      this.props.getTransactions(this.props.accessToken, startDate, endDate)
    ));
  }

  async queryWithLoader(query) {
    this.setState({ isLoading: true });

    try {
      await query();
    } catch (err) {
      /* Do nothing */
    }

    this.clearLoader();
  }

  clearLoader() {
    this.setState({ isLoading: false });
  }

  handleDateChange(key, date) {
    this.setState({ [key]: date });
  }

  render() {
    const { transactions } = this.props;
    const { isLoading } = this.state;
    const columns = transactions.length ? Object.keys(transactions[0]) : [];

    return (
      <div className="transactionstable">
        <div className="transactiontable__dashboard">
          <DatePicker

            selected={ this.state.startDate }
            onChange={ (date) => this.handleDateChange('startDate', date) }
          />
          <DatePicker
            selected={ this.state.endDate }
            onChange={ (date) => this.handleDateChange('endDate', date) }
          />
          <button className="btn--small" onClick={ this.queryTransactions } >Get Transactions</button>
        </div>
        { isLoading ?
          <Loader /> :
          <Table
            rows={ transactions }
            columns={ columns }
          /> }
      </div>
    );
  }
}

Transactions.propTypes = {
  getTransactions: func,
  history: object,
  accessToken: string,
  transactions: array
};

const mapStateToProps = state => ({
  accessToken: state.oauth.accessToken,
  transactions: state.transactions
});

const mapDispatchToProps = {
  getTransactions
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Transactions);
