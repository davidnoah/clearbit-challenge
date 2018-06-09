import { request } from '../request';

export const getTransactions = (access_token, start_date, end_date) => (
  request({
    path: '/transactions',
    method: 'GET',
    queryParams: {
      access_token,
      start_date,
      end_date
    }
  })
);
