import React from 'react';
import PropTypes from 'prop-types';
import { Row, Col, Accordion } from 'react-bootstrap';
import classNames from 'classnames';
// import logger from 'sabio-debug';

// const _logger = logger.extend('FaqTemplate');

function FaqTemplate(props) {
    // _logger(props);
    const anFaq = props?.faq;
    let id = props.faq.id;
    return (
        <>
            <Row className="my-4 mx-4 col-md-5">
                <Col key={id} lg={{ offset: 1 }}>
                    <Accordion>
                        <Accordion.Item eventKey="0">
                            <div className="faq-question-q-box mt-2 ms-2">Q.</div>
                            <Accordion.Header className={classNames('faq-question')}>{anFaq.question}</Accordion.Header>
                            <Accordion.Body className={classNames('faq-answer mb-4')}>{anFaq.answer}</Accordion.Body>
                        </Accordion.Item>
                    </Accordion>
                </Col>
            </Row>
        </>
    );
}

FaqTemplate.propTypes = {
    faq: PropTypes.shape({
        id: PropTypes.number.isRequired,
        question: PropTypes.string.isRequired,
        answer: PropTypes.string.isRequired,
        categoryId: PropTypes.number,
        sortOrder: PropTypes.number,
        createdBy: PropTypes.number,
        modifiedBy: PropTypes.number,
    }),
};

export default FaqTemplate;
