import React from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
import { func, object } from 'prop-types';
import PlaidLink from 'react-plaid-link';
import { createAccessToken } from '../../redux/actions/OAuthActions';

const BankLink = ({ createAccessToken, history }) => {
  const { REACT_APP_PUBLIC_KEY } = process.env;

  const _handleSuccess = (publicToken) => {
    createAccessToken(publicToken)
      .then(() => {
        history.push('/transactions');
      });
  };

  return (
    <PlaidLink
      clientName="ClearbitIntegration"
      env="sandbox"
      className="btn--small"
      product={ ['auth', 'transactions'] }
      publicKey={ REACT_APP_PUBLIC_KEY }
      onExit={ () => { } }
      onSuccess={ _handleSuccess }
    >
      Connect your bank
    </PlaidLink >
  );
};

BankLink.propTypes = {
  createAccessToken: func,
  history: object
};

const mapDispatchToProps = {
  createAccessToken
};

export default withRouter(connect(
  null,
  mapDispatchToProps
)(BankLink));
