import React from 'react';
import { array } from 'prop-types';
import { toTitleCase } from '../../utils/stringManipulation';

import './Table.css';

class Table extends React.Component {
  render() {
    const { columns, rows } = this.props;

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
                  { toTitleCase(column) }
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
  rows: array
};

export default Table;
