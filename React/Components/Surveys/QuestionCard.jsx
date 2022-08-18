import React, { useState } from 'react';
import debug from 'sabio-debug';
import { Button, Collapse, OverlayTrigger, Tooltip, Stack } from 'react-bootstrap';
import { Field } from 'formik';
import PropTypes from 'prop-types';
import RadioButtons from './surveyquestiontypes/RadioButtons';
import Checkbox from './surveyquestiontypes/Checkbox';
import Date from './surveyquestiontypes/Date';
import Upload from './surveyquestiontypes/Upload';
function QuestionCard({ index, values, onDelete, onChange }) {
    const _logger = debug.extend(`QuestionCard${index + 1}`);
    false && _logger(false);
    const [open, setOpen] = useState(true);

    const questionChange = (e) => {
        let value = e.target.value;
        renderAnswerOption(value);
        onChange(e);
    };

    const renderAnswerOption = (value) => {
        switch (value) {
            case 'shortAnswer':
                return (
                    <Field
                        type="text"
                        className="form-control"
                        name={`shortAnswer.${index}`}
                        placeholder="Short answer text"
                        size="lg"
                        readOnly
                    />
                );
            case 'paragraph':
                return (
                    <Field
                        type="text"
                        as="textarea"
                        className="form-control"
                        rows={3}
                        name={`paragraph.${index}`}
                        placeholder="Paragraph answer text"
                        size="lg"
                        readOnly
                    />
                );

            case 'multipleChoice':
                return (
                    <RadioButtons
                        name={`cards.${index}`}
                        key={`cards.${index}.radio${index}`}
                        values={values}
                        onChange={onChange}
                        cardIndex={index}
                    />
                );

            case 'checkbox':
                return <Checkbox key={`checkbox${index}`} answerIndex={index} />;

            case 'date':
                return <Date key={`date${index}`} />;

            case 'fileUpload':
                return <Upload key={`upload${index}`} />;
            default:
        }
    };

    const deleteClicked = () => {
        onDelete(index);
    };

    return (
        <div className="card" id={index + 1}>
            <div className="row card-header">
                <Stack direction="horizontal" gap={1}>
                    <Field
                        type="text"
                        className="form-control form-control-lg"
                        name={`cards[${index}].question`}
                        placeholder={`Question ${index + 1}`}
                        size="lg"
                    />
                    <OverlayTrigger
                        key={`optionTooltip${index + 1}}`}
                        placement="top"
                        overlay={
                            <Tooltip id={`tooltip-top`}>{open === false ? 'Open Options' : 'Close Options'}</Tooltip>
                        }>
                        <Button
                            key={`optionButton${index + 1}`}
                            variant="outline-secondary"
                            onClick={() => setOpen(!open)}
                            aria-controls="collapse-options"
                            aria-expanded={open}
                            size="lg">
                            {open === false ? (
                                <i className="mdi mdi-unfold-more-horizontal"></i>
                            ) : (
                                <i className=" mdi mdi-unfold-less-horizontal"></i>
                            )}
                        </Button>
                    </OverlayTrigger>
                    <OverlayTrigger
                        key={`deleteTooltip${index + 1}`}
                        placement="top"
                        overlay={<Tooltip id={`tooltip-top`}>Delete Question</Tooltip>}>
                        <Button
                            key={`deleteButton${index + 1}`}
                            variant="outline-danger"
                            onClick={deleteClicked}
                            size="lg">
                            <i className="mdi mdi-window-close"></i>
                        </Button>
                    </OverlayTrigger>
                </Stack>
            </div>
            <div className="row card-body mt-2 mb-2 p-1 ms-1">
                <Collapse in={open}>
                    <div className="row">
                        <div className="col">{renderAnswerOption(values.cards[index].type)}</div>
                        <div className="col-3">
                            <Field
                                as="select"
                                name={`cards[${index}].type`}
                                className="form-select form-select-lg"
                                onChange={questionChange}>
                                <option name="shortAnswer" value="shortAnswer">
                                    Short answer
                                </option>
                                <option name="paragraph" value="paragraph">
                                    Paragraph
                                </option>
                                <option name="multipleChoice" value="multipleChoice">
                                    Multiple choice
                                </option>
                                <option name="checkbox" value="checkbox">
                                    Checkbox
                                </option>
                                <option name="date" value="date">
                                    Date
                                </option>
                                <option name="fileUpload" value="fileUpload">
                                    File upload
                                </option>
                            </Field>
                        </div>
                    </div>
                </Collapse>
            </div>
        </div>
    );
}

export default QuestionCard;
QuestionCard.propTypes = {
    name: PropTypes.string.isRequired,
    index: PropTypes.number.isRequired,
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
    setValues: PropTypes.func.isRequired,
};
