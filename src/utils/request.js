const { REACT_APP_API_HOST } = process.env;
/**
 * Invokes API gateway
 *
 * @param {Object} config              API request config object
 * @param {string} config.path         Path name to API endpoint
 * @param {string} config.method       HTTP request method
 * @param {Object} config.headers      Any corresponding headers sent with the API request
 * @param {Object} config.queryParams  Any corresponding query parameters sent with the API request
 * @param {Object} config.body         Body of the request
 * @return {promise} A promise object
*/
export async function request({
  path,
  method = 'GET',
  queryParams = {},
  body,
  headers = {}
}) {
  let form_data = new FormData();

  for (let key in body) {
    form_data.append(key, body[key]);
  }

  const endpoint = new URL(`${REACT_APP_API_HOST}${path}`);

  Object.keys(queryParams)
    .forEach(key => endpoint.searchParams.append(key, queryParams[key]));

  const results = await fetch(endpoint, {
    method,
    headers,
    body: body && form_data,
    queryParams
  });

  if (results.status >= 400) {
    throw new Error(await results.text());
  }

  return results.status === 204 ? results.text() : results.json();
}