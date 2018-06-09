import React from 'react';
import { connect } from 'react-redux';
import { func, object } from 'prop-types';
import { getTransactions } from '../../redux/actions/TransactionActions';

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

    return (
      <div>
        { transactions.map((transaction, index) => (
          <div className="transaction__container" key={ `transaction ${index}` }>
              { transaction.name }
          </div>
        )) }
      </div>
    );
  }
};

Transactions.propTypes = {
  getTransactions: func,
  history: object
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