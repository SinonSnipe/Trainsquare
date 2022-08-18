import React from 'react';
import debug from 'sabio-debug';
import Dropzone from './Dropzone';
import Basic from './BasicFileUpload';
import FileViewer from './FileViewer';

function FileUpload() {
    const _logger = debug.extend('FileUploadParent');

    const getUploadReturn = (fileData) => {
        _logger(fileData);
    };

    return (
        <div className="container">
            <div className="col p-2">
                <h2>File Upload Test Page</h2>
                <div className="row">
                    <div className="col-6">
                        <h4>Dropzone</h4>
                        <Dropzone uploadedFiles={getUploadReturn} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-6">
                        <h4>Basic Form Input</h4>
                        <Basic uploadedFile={getUploadReturn} />
                    </div>
                </div>
                <div className="row">
                    <div className="col-6">
                        <h4>File Viewer</h4>
                        <FileViewer />
                    </div>
                </div>
            </div>
        </div>
    );
}
export default FileUpload;
