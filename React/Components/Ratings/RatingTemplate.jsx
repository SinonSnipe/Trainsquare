import React from 'react';
import debug from 'sabio-debug';
import { Row, Col, Card } from 'react-bootstrap';
import Rating from 'react-rating';
import { propTypes } from 'react-bootstrap/esm/Image';
import PropTypes from 'prop-types';

const _logger = debug.extend('ratings');

function RatingTemplate(props){

    _logger(props, propTypes)
    return (
        <>
            <Row>
                <Col xl={6}>
                    <Card>
                        <Card.Body>
                            <h4 className="header-title">WorkShop Rating</h4>
                            <p className="text-muted font-14"></p>

                            <Rating
                                initialRating={3}
                                emptySymbol="mdi mdi-star-outline font-22 text-muted"
                                fullSymbol="mdi mdi-star font-22 text-warning"
                            />
                        </Card.Body>
                    </Card>
                </Col>
            </Row>
        </>
    );
};

RatingTemplate.propTypes = {
    rating: PropTypes.shape({
        id: PropTypes.number.isRequired,
        subject: PropTypes.string,
        parentId: PropTypes.number,
        entityId: PropTypes.number.isRequired,
        isDeleted: PropTypes.bool.isRequired,
    }),
};

export default RatingTemplate;
