## Clearbit Challenge
A small app that processes bank transactions through the Clearbit name to domain API

---
### Setup

1. `git clone` this project
2. Navigate to directory
3. Run `yarn install` or `npm install`
4. Run `bundle install`
5. Run `rackup`
6. In a separate tab, run `yarn start` or `npm start`

Run the tests! Run `rspec spec`

When logging in to a bank use these credentials:

  username: `user_good`
  password: `pass_good`

---
### Overview
I have built a small application in Ruby/Sinatra and React/Redux. This app allows a user to log in to his/her bank account and query for a list of bank transactions by date through the Plaid API (As of now the Plaid API is set up in a sandbox environment. All transactions are fake). These transactions are the processed through the Clearbit API and each one is assessed to see if is a recurring transaction or not.

For the scope of the application, a full React/Redux frontend is overkill. That being said, I implemented the frontend like this to highlight my skills in React/Redux.

---
### Server
The app uses Ruby/Sinatra on the server-side and is built in a Model View Controller architecture. I knew that I could break up the functionality of this app in to two endpoints.

- `POST /oauth/access-token` in oauth_controller.rb

Has the duty of exchanging an Plaid API `public_token`, which is retrieved by a client-side request post-login, with a Plaid API `access_token`. This access_token is then sent to the front end to be used with any subsequent requests to the Plaid API.

- `GET /transactions` in transactions_controller.rb

This endpoint returns a list of bank transactions based on three parameters, `access_token`, `start_date`, `end_date`. The list of transactions are returned in decending order by date (most recent date first). They are processed through the Clearbit name to domain API and assessed if they are recurring.

#### Models
Transaction

The transaction model is responsible for initializing new `Transaction` instances and processing each transaction. There are a series of class methods built to handle this processing. The processing is handled in linear time.

- `Transaction.process_transactions`

Parent function that calls both transaction processing functions

- `Transaction.process_through_clearbit`

Processes each transaction through the Clearbit name to domain API. Checks to see if the company domain has been processed already, if not a request to Clearbit is made. Then set the domain and logo instance variables if a company domain is found. A hash is used to help ensure a company domain is never requested twice for the same company.

- `Transaction.check_for_recurrences`

This function identifies whether a transaction is recurring or not. A recurring transaction here is defined as a payment that occurs on the same day for the same amount of money over at least 2 consecutive months. This entire process happens over 1 iteration of the transactions array. During each iteration I first parse the transaction date into a Ruby date object and create an identifier (`#{transaction.name}_#{date.day}_#{transaction.amount}`). A hash named `last_occurance` is used to keep track of the last occurance an transaction has been seen using the identifier as a key. If a transaction has been seen previously I then check to see if that payment occured one month prior. If so, I change both the last_occurance transaction and current transaction to recurring. This is also done in linear time O(n).

---
## Trade-offs/Optimizations

- Yearly/Bi-monthly/Tri-monthly recurring payments

Yearly subscriptions would be hard to hard to assess during a  real-time request. My solution would be to implement a background processer and a database into the infrastructure. AWS Elastic Beanstalk provides functionality to handle backgroud tasks.

- Querying for at least 2 months if the transaction query is shorter than two months

This would be my first optimization. As of now, when one queries a date range that is less than 1 month, there is potential that the is_recurring boolean is  not accurate. This is because the queried transactions don't have enough context data to assess whether they are recurring or not. 

The fix would be to always add 1 month to the query at either end of the date range. This would at least give enough data to satisfy the way I've defined a recurrence in this project.

- Recurring payments with different amounts (e.g. credit card payments)

You would not want to flag a transaction if you have attended the same restaurant during consecutive months, but you do want to flag something like a recurring credit card payment. 

My thought behind this improvement would be to create a confidence score for each transaction. One way to do this would be to assess 3+ months. The more consecutive months a transaction occurs on the same day, the more confident one would be that it is recurring.

- Transactions that are period-based (i.e. every 30 days)

This can be implemented in a similar way that I implemented same-day based recurring transactions. When creating a unique identifier, instead of using `{company_name}_{day}_{amount}` you could use `{company_name}_{day_of_year % 30}_{amount}`. This identifier would look at all similar payments, 30 days apart.

- Future iteration: cache transactions

This will be a very important optimization. Caching recent transactions. One can make an asumptions that a user will commonly be looking at their most recent transactions. The most recent 3 months could be cached while older dates would require processing.

- Add limit and offset paramters to the tranaction query

Very large queries will take some time. If pagination was implemented into the API, it would prevent the frontend from running slow on large queries.

---
## React/Redux Frontend

Normally I would like to separate the client application and API into two separate repositories, but for the sake of ease of use, I decided to keep them together under one roof. Also, I used component based styling. Every component imports a .css file.

I documented this code using JSDoc (http://usejsdoc.org/) and ESLint was used to maintain code structure and clarity.

### State

```js
  {
    oauth: {
      accessToken: "A Plaid access token"
    },
    transactions: []
  }
```


