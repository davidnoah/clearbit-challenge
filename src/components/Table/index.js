import React from 'react';
import { array, func } from 'prop-types';

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
                  { column.name }
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
                { Object.keys(row).map(key => {
                  let value = row[key];

                  if (key === 'logo') {
                    value = <img src={ row[key] } />;
                  }

                  return (
                    <td className="table__td">
                      { value }
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
  onRowClick: func,
  rows: array
};

export default Table;
