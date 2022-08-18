import React, { useEffect, useState } from 'react';
import { Stack } from 'react-bootstrap';
import { Field } from 'formik';
import PropTypes from 'prop-types';

function RadioButtons() {
    const [radioButtons, setRadioButtons] = useState({
        count: 0,
        data: [],
        ui: [],
    });

    const addRadio = () => {
        let data = { ...radioButtons };
        data.count++;
        let radioButtonData = { Name: `radioButton${data.count}`, text: '' };
        let newRadioButton = (
            <div className="row mt-2" key={`radioButton${data.count}`}>
                <Stack direction="horizontal" gap={3}>
                    <Field
                        type="radio"
                        name="radioButton"
                        aria-label={`radioButton${data.count}`}
                        className="form-check-input"
                    />
                    <Field
                        type="text"
                        name={`radioText${data.count}`}
                        id={`radioText${data.count}`}
                        placeholder={`Option ${data.count}`}
                        className="form-control"
                    />
                </Stack>
            </div>
        );

        data.data.push(radioButtonData);
        data.ui.push(newRadioButton);
        setRadioButtons(data);
    };
    useEffect(addRadio, []);
    return (
        <div>
            <div className="row" role="group" aria-labelledby="radio-group">
                {radioButtons.ui}
            </div>
            <div className="row mt-2">
                <Stack direction="horizontal" gap={3}>
                    <a href="#" className="link-secondary" onClick={addRadio}>
                        <h4>Add option</h4>
                    </a>
                </Stack>
            </div>
        </div>
    );
}

export default React.memo(RadioButtons);
RadioButtons.propTypes = {
    id: PropTypes.string.isRequired,
};
