import React from 'react';
import { getTransactions } from '../../redux/actions/TransactionActions';

class Transactions extends React.Component {
  componentDidMount() {
    const startDate = '2017-01-01';
    const endDate = '2017-06-7'
    this.props.getTransactions(this.state.accessToken, startDate, endDate);
  }

  render() {
    return (
      <div>
        Transactions
      </div>
    )
  }
}

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