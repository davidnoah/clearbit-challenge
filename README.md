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

When logging in to a bank user these credentials:

username: user_good
password: pass_good

---
### Overview
I have built a small application in Ruby/Sinatra and React/Redux. This app allows a user to log in to his/her bank account and query for a list of bank transactions by date through the Plaid API (As of now the Plaid API is set up in a sandbox environment. All transactions are fake).
