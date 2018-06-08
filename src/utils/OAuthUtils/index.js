import { request } from '../request';

export const createAccessToken = (public_token) => (
  request({
    path: '/oauth/access-token',
    method: 'POST',
    body: {
      public_token
    }
  })
)