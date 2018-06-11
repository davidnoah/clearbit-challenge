import React from 'react';
import { array, func } from 'prop-types';
import { snakeToTitleCase } from '../../utils/stringManipulation';

import './Table.css';

/**
 * Returns an action creator with a list of transactions
 *
 * @param {Array} columns List of column names
 * @param {Array} rows List of row objects
 * @param {Function} onRowClick Action when row is clicked
 * @return {React.Component} A stateless React table component
*/
class Table extends React.Component {
  render() {
    const { columns, rows, onRowClick } = this.props;

    return (
      <table className="table">
        <thead className="table__head">
          <tr>
            {
              columns.map((column, index) => (
                <th
                  className="table__th"
                  key={ `col${index}` }
                >
                  { snakeToTitleCase(column) }
                </th>
              ))
            }
          </tr>
        </thead>
        <tbody className="table__body">
          { rows
            .map((row, rowIndex) => (
              <tr
                className="table__tr"
                key={ rowIndex }
                onClick={ () => row.domain && onRowClick(`http://www.${row.domain}`) }
              >
                { Object.keys(row).map((key, index) => {
                  let value = row[key];

                  if (key === 'logo' && value) {
                    value = <img src={ row[key] } alt="transaction-logo" />;
                  }

                  if (key === 'is_recurring') {
                    value = row[key] ? 'RECURRING' : '';
                  }

                  return (
                    <td className="table__td" key={ `td${index}` }>
                      {value || '\u2014' }
                    </td>
                  );
                }) }
              </tr>
            )) }
        </tbody>
      </table>
    );
  }
}

Table.propTypes = {
  columns: array,
  rows: array,
  onRowClick: func
};

export default Table;
