import React, { useState, useEffect } from 'react';
import debug from 'sabio-debug';
import * as fileService from '../../services/fileService';
import { Table } from 'react-bootstrap';
import { format } from 'date-fns';

function FileViewer() {
    // const [files, setFiles] = useState([]);
    const _logger = debug.extend('FileViewer');
    const [filesData, setFilesData] = useState([]);

    useEffect(() => {
        fileService.getAll(0, 10).then(getAllSuccess).catch(getAllError);
    }, []);

    const getAllSuccess = (response) => {
        let data = response.data.item.pagedItems;
        renderTable(data);
        _logger({ getAllSuccess: response });
    };

    const getAllError = (response) => {
        _logger({ getAllError: response });
    };

    const renderTable = (filesData) => {
        setFilesData(filesData.map((file) => tableTemplate(file)));
    };

    const tableTemplate = (file) => {
        const { id, url, fileType, createdBy, dateCreated, dateModified } = file;
        return (
            <tr key={id}>
                <td>{id}</td>
                <td>{url}</td>
                <td>{fileType}</td>
                <td>{createdBy}</td>
                <td>{format(new Date(dateCreated), 'dd MMM yyyy')}</td>
                <td>{format(new Date(dateModified), 'dd MMM yyyy')}</td>
            </tr>
        );
    };

    false && _logger('placeholder');
    return (
        <div>
            <Table id="fileView">
                <tbody>
                    <tr>
                        <td>Id</td>
                        <td>Url</td>
                        <td>File Type</td>
                        <td>User</td>
                        <td>Created</td>
                        <td>Modified</td>
                    </tr>
                    {filesData}
                </tbody>
            </Table>
        </div>
    );
}

export default FileViewer;
