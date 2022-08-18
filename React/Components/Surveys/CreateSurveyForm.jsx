import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { Button, Card, OverlayTrigger, Tooltip } from 'react-bootstrap';
import { Formik, Form, FieldArray, getIn } from 'formik';
import debug from 'sabio-debug';
import CreateSurveyHeader from './CreateSurveyHeader';
import QuestionCard from './QuestionCard';
import { useEffect } from 'react';
import * as toastr from 'toastr';
const _logger = debug.extend('CreateSurveyForm');

function CreateSurveyForm() {
    const { state } = useLocation();
    const navigate = useNavigate();
    const [surveyData, setSurveyData] = useState({
        header: {
            title: '',
            description: '',
        },
        cards: [
            {
                type: 'shortAnswer',
                question: '',
                answerOption: [{ optionNumber: 1, optionAnswer: 'Answer 1', isSelected: true }],
            },
        ],
    });

    useEffect(() => {
        _logger('location state', state);
        if (state?.type === 'NEW_SURVEY_DATA') {
            _logger(state);
            setSurveyData((prevState) => {
                return {
                    ...prevState,
                    header: {
                        title: state.payload.name,
                        description: state.payload.description,
                    },
                };
            });
        }
    }, []);

    const onSubmitClick = (e) => {
        e.preventDefault();
        toastr.success('Survey Added');
        navigate('/surveys');
    };

    false && _logger(null);

    return (
        <div className="container">
            <div className="row">
                <div className="col-11">
                    <Card className="mt-3">
                        <Formik initialValues={surveyData} enableReinitialize={true}>
                            {({ values, handleChange, setFieldValue }) => (
                                <Form>
                                    <div className="card-header">
                                        <div className="col">
                                            <CreateSurveyHeader value={values} onChange={handleChange} />
                                        </div>
                                    </div>
                                    <div className="p-2">
                                        <FieldArray name="cards">
                                            {(arrayHelpers) => {
                                                const data = getIn(arrayHelpers.form.values, arrayHelpers.name);
                                                return (
                                                    <div className="row">
                                                        {data.map((card, index) => (
                                                            <QuestionCard
                                                                key={`cards[${index}]`}
                                                                name={`${card.name}.${index}`}
                                                                index={index}
                                                                values={values}
                                                                setValues={setFieldValue}
                                                                onChange={handleChange}
                                                                onDelete={() => arrayHelpers.remove(index)}
                                                            />
                                                        ))}
                                                        <div className="col">
                                                            <OverlayTrigger
                                                                placement="top"
                                                                overlay={
                                                                    <Tooltip id={`tooltip-top`}>Add question</Tooltip>
                                                                }>
                                                                <Button
                                                                    key={`addButton`}
                                                                    className="me-3"
                                                                    name="addButton"
                                                                    variant="outline-info"
                                                                    onClick={() =>
                                                                        arrayHelpers.push({
                                                                            type: 'shortAnswer',
                                                                            question: '',
                                                                            answerOption: [],
                                                                        })
                                                                    }>
                                                                    Add
                                                                </Button>
                                                            </OverlayTrigger>
                                                            <OverlayTrigger
                                                                placement="top"
                                                                overlay={
                                                                    <Tooltip id={`tooltip-top`}>
                                                                        Submit Questions
                                                                    </Tooltip>
                                                                }>
                                                                <Button
                                                                    key={`submitButton`}
                                                                    name="submitButton"
                                                                    variant="outline-danger"
                                                                    onClick={onSubmitClick}>
                                                                    Submit
                                                                </Button>
                                                            </OverlayTrigger>
                                                        </div>
                                                    </div>
                                                );
                                            }}
                                        </FieldArray>
                                    </div>
                                </Form>
                            )}
                        </Formik>
                    </Card>
                </div>
            </div>
        </div>
    );
}

export default CreateSurveyForm;
