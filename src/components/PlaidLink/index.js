import React from 'react';
import PlaidLink from 'react-plaid-link';
import { createAccessToken } from '../../utils/OAuthUtils';

const BankLink = () => {
  const { REACT_APP_PUBLIC_KEY } = process.env;

  const _handleSuccess = (publicKey) => {
    createAccessToken(publicKey)
      .then(res => {
        console.log(res);
      })
  };

  return (
    <PlaidLink
      clientName="ClearbitIntegration"
      env="sandbox"
      product={ ["auth", "transactions"]}
      publicKey={ REACT_APP_PUBLIC_KEY }
      onExit={ () => { } }
      onSuccess={ _handleSuccess }
    >
      Connect your bank
    </PlaidLink >
  )
};

export default BankLink;
