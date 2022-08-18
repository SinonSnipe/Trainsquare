import React from 'react';
import Papa from 'papaparse';
import PropTypes from 'prop-types';
//import debug from 'sabio-debug';

//const _logger = debug.extend('FileParser');

const FileParserCsv = (props) => {
    const fileChangeHandler = (event) => {
        Papa.parse(event.target.files[0], {
            header: true,
            skipEmptyLines: true,
            complete: function (results) {
                const parsedArray = results.data;
                //_logger('parse', parsedArray);'

                const columnsArray = [];
                for (let i = 0; i < parsedArray.length; i++) {
                    const data = parsedArray[i];

                    columnsArray.push(Object.keys(data));
                }

                props.setParseData(() => {
                    return { columnTitles: columnsArray[0], parsedData: parsedArray };
                });
            },
        });
        //_logger('file change->', event.target.files[0]);
    };

    return (
        <div>
            <input type="file" name="file" accept=".csv" onChange={fileChangeHandler} />
        </div>
    );
};

FileParserCsv.propTypes = {
    setParseData: PropTypes.func,
};

export default FileParserCsv;
