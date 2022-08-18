import React, { useState } from 'react';
import debug from 'sabio-debug';
import { Button, Collapse, Form, OverlayTrigger, Tooltip, Stack } from 'react-bootstrap';
import PropTypes from 'prop-types';
import RadioButtons from './surveyquestiontypes/RadioButtons';
import Checkbox from './surveyquestiontypes/Checkbox';
import Date from './surveyquestiontypes/Date';
import Upload from './surveyquestiontypes/Upload';
import { Draggable } from 'react-beautiful-dnd';

function QuestionCard({ id, index, handleDelete }) {
    const _logger = debug.extend(`QuestionCard${id}`);
    const [open, setOpen] = useState(true);
    const [question, setQuestion] = useState({
        question: `QuestionCard${id}`,
        type: 'shortAnswer',
        data: {
            ui: (
                <Form.Control
                    type="text"
                    name="shortAnswer"
                    id={`shortAnswer${id}`}
                    placeholder="Short answer text"
                    size="lg"
                    readOnly
                />
            ),
            answerOptions: [],
        },
    });

    const questionChange = (e) => {
        _logger(e.target.value);
        let value = e.target.value;
        let option = renderAnswerOption(value);

        setQuestion(() => {
            let state = { ...question };
            state.type = value;
            state.data.ui = option;
            return state;
        });
        _logger({ state: question });
    };

    const renderAnswerOption = (value) => {
        switch (value) {
            case 'shortAnswer':
                return (
                    <Form.Control
                        type="text"
                        name="shortAnswer"
                        id={`shortAnswer${id}`}
                        placeholder="Short answer text"
                        size="lg"
                        readOnly
                    />
                );
            case 'paragraph':
                return (
                    <Form.Control
                        type="text"
                        as="textarea"
                        rows={3}
                        name="paragraph"
                        id={`paragraph${id}`}
                        placeholder="Paragraph answer text"
                        size="lg"
                        readOnly
                    />
                );

            case 'multipleChoice':
                return <RadioButtons key={`radiobuttons${id}`} id={`radiobuttons${id}`} />;

            case 'checkbox':
                return <Checkbox key={`checkbox${id}`} id={`radiobuttons${id}`} />;

            case 'date':
                return <Date key={`date${id}`} id={`date${id}`} />;

            case 'fileUpload':
                return <Upload key={`upload${id}`} id={`upload${id}`} />;
            default:
        }
    };

    return (
        <Draggable draggableId={id.toString()} index={index}>
            {(provided) => (
                <div
                    className="card"
                    id={id}
                    {...provided.draggableProps}
                    {...provided.dragHandleProps}
                    ref={provided.innerRef}>
                    <div className="row card-header">
                        <Stack direction="horizontal" gap={1}>
                            <Form.Control
                                type="text"
                                name="question"
                                id="question"
                                placeholder={`Question ${id}`}
                                size="lg"
                            />
                            <OverlayTrigger
                                key={`optionTooltip${id}`}
                                placement="top"
                                overlay={
                                    <Tooltip id={`tooltip-top`}>
                                        {open === false ? 'Open Options' : 'Close Options'}
                                    </Tooltip>
                                }>
                                <Button
                                    key={`optionButton${id}`}
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
                                key={`deleteTooltip${id}`}
                                placement="top"
                                overlay={<Tooltip id={`tooltip-top`}>Delete Question</Tooltip>}>
                                <Button
                                    key={`deleteButton${id}`}
                                    variant="outline-danger"
                                    onClick={() => handleDelete(id)}
                                    size="lg">
                                    <i className="mdi mdi-window-close"></i>
                                </Button>
                            </OverlayTrigger>
                        </Stack>
                    </div>
                    <div className="row card-body mt-2 mb-2 p-1 ms-1">
                        <Collapse in={open}>
                            <div className="row">
                                <div className="col">{question.data.ui}</div>
                                <div className="col-3">
                                    <Form.Select size="lg" onChange={questionChange}>
                                        <option value="shortAnswer">Short answer</option>
                                        <option value="paragraph">Paragraph</option>
                                        <option value="multipleChoice">Multiple choice</option>
                                        <option value="checkbox">Checkbox</option>
                                        <option value="linearScale">Linear Scale</option>
                                        <option value="date">Date</option>
                                        <option value="time">Time</option>
                                        <option value="fileUpload">File upload</option>
                                    </Form.Select>
                                </div>
                            </div>
                        </Collapse>
                    </div>
                </div>
            )}
        </Draggable>
    );
}

export default QuestionCard;
QuestionCard.propTypes = {
    id: PropTypes.number.isRequired,
    index: PropTypes.number.isRequired,
    handleDelete: PropTypes.func.isRequired,
};
