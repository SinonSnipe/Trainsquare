import React, { useState } from 'react';
import debug from 'sabio-debug';
import * as fileService from '../../services/fileService';
import PropTypes from 'prop-types';
function BasicFileUpload(props) {
    const _logger = debug.extend('BasicFileUpload');
    const [upload, setUpload] = useState({
        file: null,
    });

    const uploadFile = () => {
        let files = { ...upload };
        let bodyFormData = new FormData();
        bodyFormData.append('file', files.file);
        fileService.upload(bodyFormData).then(uploadSuccess).catch(uploadError);
    };

    const uploadSuccess = (response) => {
        props.uploadedFile(response.data.items);
    };

    const uploadError = (response) => {
        _logger(response);
    };

    return (
        <form>
            <div className="form-outline">
                <label htmlFor="file" className="form-label">
                    File
                </label>
                <input
                    type="file"
                    name="file"
                    id="file"
                    className="form-control form-control"
                    onChange={(event) => {
                        setUpload({ file: event.target.files[0] });
                        _logger({ onChange: event.target.files[0] });
                    }}
                />
            </div>
            <div className="form-outline mt-2">
                <button id="submit" className="btn btn-primary btn-block" type="button" onClick={uploadFile}>
                    Upload
                </button>
            </div>
        </form>
    );
}

export default BasicFileUpload;
BasicFileUpload.propTypes = {
    uploadedFile: PropTypes.func,
};
