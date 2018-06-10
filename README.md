## Clearbit Challenge
A small app that processes bank transactions through the Clearbit name to domain API

---
### Setup

1. `git clone` this project
2. Navigate to directory
3. Run `yarn install` or `npm install`
4. Run `bundle install`
5. Create `.env` file and add the given variables
6. Run `rackup`
7. In a separate tab, run `yarn start` or `npm start`

When logging in to a bank use these credentials:

  username: `user_good`
  password: `pass_good`

---
### Overview
I have built a small application in Ruby/Sinatra and React/Redux. This app allows a user to log in to his/her bank account and query for a list of bank transactions by date through the Plaid API (As of now the Plaid API is set up in a sandbox environment. All transactions are fake). These transactions are the processed through the Clearbit API and each one is assessed to see if is a recurring transaction or not.

---
### Server
The app uses Ruby/Sinatra on the server-side and built in a Model View Controller architecture. I knew that I could break up the unctionality of this app in to two endpoints.

- `POST /oauth/access-token` in oauth_controller.rb

Has the duty of exchanging an Plaid API `public_token`, which is retrieved by a client-side request post-login, with a Plaid API `access_token`. This access_token is then sent to the front end to be used with any subsequent requests to the Plaid API.

- `GET /transactions` in transactions_controller.rb

This endpoint returns a list of bank transactions based on three parameters, `access_token`, `start_date`, `end_date`. The list of transactions are returned in decending order by date (most recent date first). They are processed through the Clearbit name to domain API and assessed if they are recurring.

#### Models
Transaction

The transaction model is responsible for initializing new `Transaction` instances and processing each transaction. There are a series of class methods built to handle this processing. The processing is handled in linear time.

- `Transaction.process_transactions`
- `Transaction.process_through_clearbit`
- `Transaction.check_for_recurrences`