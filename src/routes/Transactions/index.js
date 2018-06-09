import React from 'react';
import { connect } from 'react-redux';
import { func, object, string, array } from 'prop-types';
import { getTransactions } from '../../redux/actions/TransactionActions';
import Table from '../../components/Table';

import './Transactions.css';

class Transactions extends React.Component {
  componentDidMount() {
    const { accessToken, history } = this.props;

    if (!accessToken) {
      return history.push('/');
    }

    const startDate = '2017-01-01';
    const endDate = '2017-06-07';
    this.props.getTransactions(this.props.accessToken, startDate, endDate);
  }

  render() {
    const { transactions } = this.props;
    const columns = transactions.length && [...Object.keys(transactions[0])];

    return (
      <div className="transactionstable">
        { transactions.length ?
          <Table
            rows={ transactions }
            columns={ columns }
          />
          : null }
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
