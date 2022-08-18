import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import { Stack } from 'react-bootstrap';
import { Field } from 'formik';
import { format } from 'date-fns';

function Datepicker() {
    const [startDate, setStartDate] = useState(new Date());
    const [endDate, setEndDate] = useState(null);
    const onChange = (dates) => {
        const [start, end] = dates;
        setStartDate(start);
        setEndDate(end);
    };
    return (
        <div className="row justify-content-center align-items-center">
            <div className="col-3 me-4">
                <DatePicker
                    selected={startDate}
                    onChange={onChange}
                    startDate={startDate}
                    endDate={endDate}
                    selectsRange
                    inline
                />
            </div>
            <div className="col-2 justify-content-center align-items-center">
                <Stack gap={3}>
                    <Stack>
                        <label htmlFor="startdate" className="form-label">
                            Start Date
                        </label>
                        <Field
                            type="text"
                            className="form-control"
                            value={format(new Date(startDate), 'dd MMM yyyy')}
                            name="startdate"
                            id="startdate"
                            readOnly
                        />
                    </Stack>
                    <Stack>
                        <label htmlFor="enddate" className="form-label">
                            End Date
                        </label>
                        <Field
                            type="text"
                            className="form-control"
                            value={format(new Date(endDate ? endDate : startDate), 'dd MMM yyyy')}
                            name="enddate"
                            id="enddate"
                            readOnly
                        />
                    </Stack>
                </Stack>
            </div>
        </div>
    );
}

export default Datepicker;
