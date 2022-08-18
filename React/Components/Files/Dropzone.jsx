import React, { useState } from 'react';
import { useDropzone } from 'react-dropzone';
import debug from 'sabio-debug';
import * as fileService from '../../services/fileService';
import PropTypes from 'prop-types';

function Drozone({ uploadedFiles }) {
    const _logger = debug.extend('FileUpload');
    const [progress, setProgress] = useState(0);

    const onDrop = (files) => {
        if (files && files.length > 0) {
            uploadFile(files);
        }
    };

    const { getRootProps, getInputProps, draggedFiles } = useDropzone({
        multiple: true,
        onDrop,
    });

    const uploadFile = (files) => {
        let formData = new FormData();
        setProgress(0);
        files.forEach((file) => formData.append('file', file));
        fileService
            .upload(formData, (event) => {
                setProgress(Math.round((98 * event.loaded) / event.total));
            })
            .then(uploadSuccess)
            .catch(uploadError);
    };

    const uploadSuccess = (response) => {
        let files = response.config.data.getAll('file');
        let returnedUrls = response.data.items;
        let uploadData = [];
        for (let i = 0; i < returnedUrls.length; i++) {
            let newData = {
                id: returnedUrls[i].id,
                name: files[i].name,
                type: files[i].type,
                size: files[i].size,
                url: returnedUrls[i].url,
            };
            setProgress(100);
            uploadData.push(newData);
        }

        uploadedFiles(uploadData); //Send files to parent
    };

    const uploadError = (response) => {
        _logger(response);
    };

    return (
        <section>
            <div {...getRootProps({ className: 'dropzone' })}>
                <input {...getInputProps()} />
                <div className="col text-center align-self-center">
                    <h1>
                        {draggedFiles.length > 1 ? (
                            <i className="mdi mdi-upload-multiple"></i>
                        ) : (
                            <i className="mdi mdi-upload"></i>
                        )}
                    </h1>
                    <h4>Drag & drop some files here, or click to select files</h4>
                </div>
            </div>
            <div>
                {progress > 0 && (
                    <div className="progress mb-3">
                        <div
                            className={`progress-bar ${
                                progress < 100
                                    ? 'progress-bar-animated bg-secondary progress-bar-striped'
                                    : 'bg-success progress-bar-striped'
                            }`}
                            role="progressbar"
                            aria-valuenow={progress}
                            aria-valuemin="0"
                            aria-valuemax="100"
                            style={{ width: progress + '%' }}>
                            {progress < 100 ? `${progress}%` : 'Complete'}
                        </div>
                    </div>
                )}
            </div>
        </section>
    );
}

export default Drozone;
Drozone.propTypes = {
    uploadedFiles: PropTypes.func,
};
