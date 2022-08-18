import React, { useEffect, useState } from 'react';
import { Stack } from 'react-bootstrap';
import { Field } from 'formik';
import PropTypes from 'prop-types';

function Checkbox() {
    const [checkbox, setCheckbox] = useState({
        count: 0,
        data: [],
        ui: [],
    });

    const addCheckbox = () => {
        let data = { ...checkbox };
        data.count++;
        let checkboxData = { Name: `checkbox${data.count}`, text: '' };
        let newcheckbox = (
            <div className="row mt-2" key={`checkbox${data.count}`}>
                <Stack direction="horizontal" gap={3}>
                    <Field
                        type="checkbox"
                        className="form-control-input"
                        name={`checkbox${data.count}`}
                        aria-label={`checkbox${data.count}`}
                    />
                    <Field
                        type="text"
                        className="form-control"
                        name={`checkboxText${data.count}`}
                        id={`checkboxText${data.count}`}
                        placeholder={`Option ${data.count}`}
                    />
                </Stack>
            </div>
        );

        data.data.push(checkboxData);
        data.ui.push(newcheckbox);
        setCheckbox(data);
    };
    useEffect(addCheckbox, []);
    return (
        <div>
            <div className="row">{checkbox.ui}</div>
            <div className="row mt-2">
                <Stack direction="horizontal" gap={3}>
                    <a href="#" className="link-secondary" onClick={addCheckbox}>
                        <h4>Add option</h4>
                    </a>
                </Stack>
            </div>
        </div>
    );
}

export default Checkbox;
Checkbox.propTypes = {
    id: PropTypes.string.isRequired,
};
