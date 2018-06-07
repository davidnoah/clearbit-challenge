import React from 'react';
import PlaidLink from 'react-plaid-link';

const BankLink = () => {
  const { REACT_APP_PUBLIC_KEY } = process.env;

  const _handleSuccess = (publicKey) => {
    console.log(publicKey);
  };

  return (
    <PlaidLink
      clientName = "ClearbitIntegration"
      env = "sandbox"
      product = { ["auth", "transactions"]}
      publicKey = { REACT_APP_PUBLIC_KEY }
      onExit = { () => { } }
      onSuccess = { _handleSuccess }
    >
      Connect your bank
    </PlaidLink >
  )
};

export default BankLink;
