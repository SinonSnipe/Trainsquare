import React from 'react';
import { Field } from 'formik';
import PropTypes from 'prop-types';

function NewSurveyHeader({ onChange, value }) {
    return (
        <div>
            <div className="row p-1">
                <Field
                    type="text"
                    className="form-control form-control-lg"
                    name={value.header.title}
                    id="title"
                    value={value.header.title}
                    onChange={onChange}
                    readOnly
                />
            </div>
            <div className="row p-1">
                <Field
                    type="text"
                    className="form-control form-control-sm"
                    name={value.header.description}
                    id="description"
                    value={value.header.description}
                    onChange={onChange}
                    readOnly
                />
            </div>
        </div>
    );
}

export default React.memo(NewSurveyHeader);
NewSurveyHeader.propTypes = {
    onChange: PropTypes.func.isRequired,
    value: PropTypes.shape({
        header: PropTypes.shape({
            title: PropTypes.string.isRequired,
            description: PropTypes.string.isRequired,
        }),
    }),
};
