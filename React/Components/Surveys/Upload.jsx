import React, { useState } from 'react';
import Dropzone from '../../files/Dropzone';
import PropTypes from 'prop-types';

function Upload({ uploadedData }) {
    const [uploads, setUploads] = useState([]);
    const [tableUi, setTableUi] = useState([]);

    const getUploadReturn = (fileData) => {
        let state = [...uploads];
        let newUploads = fileData.map((file) => {
            let newData = {
                fileName: file.name,
                url: file.url,
                size: file.size,
            };
            return newData;
        });

        let newState = state.concat(newUploads);
        uploadedData(fileData);
        setUploads(newState);
        mapTable(newState);
    };

    const mapTable = (uploads) => {
        const table = [...tableUi];
        let index = 0;
        let newtable = uploads.map((upload) => {
            index++;
            return (
                <tr key={index}>
                    <th scope="row">{index}</th>
                    <td>{upload.fileName}</td>
                    <td>{upload.url}</td>
                    <td>{upload.size}</td>
                </tr>
            );
        });
        newtable.forEach((row) => table.push(row));
        setTableUi(table);
    };

    return (
        <div className="row">
            <div className="row">
                <Dropzone uploadedFiles={getUploadReturn} />
            </div>
            <div className="row">
                {uploads.length >= 1 && (
                    <table className="table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">FileName</th>
                                <th scope="col">URL</th>
                                <th scope="col">Size</th>
                            </tr>
                        </thead>
                        <tbody>{tableUi}</tbody>
                    </table>
                )}
            </div>
        </div>
    );
}

export default Upload;

Upload.propTypes = {
    uploadedData: PropTypes.func.isRequired,
};
