import { request } from '../request';

export const createAccessToken = (public_key) => (
  request({
    path: '/oauth/access-token',
    method: 'POST',
    body: {
      public_key
    }
  })
)