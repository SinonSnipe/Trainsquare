import React from 'react';
import { Button, Stack, OverlayTrigger, Tooltip } from 'react-bootstrap';
import { Field, FieldArray } from 'formik';
import PropTypes from 'prop-types';

function RadioButtonsFR({ cardIndex, values }) {
    return (
        <div>
            <FieldArray name={`cards[${cardIndex}].answerOption`}>
                {(arrayHelpers) => (
                    <div className="row" role="group" aria-labelledby="radio-group">
                        {values.cards[cardIndex].answerOption.map((button, index) => (
                            <div className="row mt-2" key={`radioButton${index}`}>
                                <Stack direction="horizontal" gap={3}>
                                    <Field
                                        type="radio"
                                        name={`cards[${cardIndex}].answerOption[${index}].optionNumber`}
                                        value={index}
                                        className="form-check-input"
                                    />
                                    <Field
                                        type="text"
                                        name={`cards[${cardIndex}].answerOption[${index}].optionAnswer`}
                                        placeholder={`cards[${cardIndex}].answerOption[${index}].optionAnswer ${index}`}
                                        className="form-control"
                                    />
                                    <OverlayTrigger
                                        key={`optionDeleteTooltip1`}
                                        placement="top"
                                        overlay={<Tooltip id={`tooltip-top`}>Delete Option</Tooltip>}>
                                        <Button
                                            key={`optionDeleteButton1`}
                                            variant="danger"
                                            size="sm"
                                            onClick={arrayHelpers.push({
                                                optionNumber: 0,
                                                optionAnswer: '',
                                                isSelected: false,
                                            })}>
                                            <i className="mdi mdi-window-close"></i>
                                        </Button>
                                    </OverlayTrigger>
                                </Stack>
                            </div>
                        ))}
                    </div>
                )}
            </FieldArray>
        </div>
    );
}

export default RadioButtonsFR;
RadioButtonsFR.propTypes = {
    cardIndex: PropTypes.number.isRequired,
    values: PropTypes.shape({
        cards: PropTypes.arrayOf(
            PropTypes.shape({
                type: PropTypes.string.isRequired,
                question: PropTypes.string.isRequired,
                answerOption: PropTypes.arrayOf(
                    PropTypes.shape({
                        optionNumber: PropTypes.number.isRequired,
                        optionAnswer: PropTypes.string.isRequired,
                    })
                ),
            })
        ),
    }),
    onDelete: PropTypes.func.isRequired,
    onChange: PropTypes.func.isRequired,
};
