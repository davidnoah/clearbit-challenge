export const toTitleCase = (str) => {
  let formattedStr = str.replace('_', ' ');
  return formattedStr.replace(/\w\S*/g, (txt) => {
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
};
