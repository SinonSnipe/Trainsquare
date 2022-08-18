import React from 'react';
import { Form, InputGroup, Row, Col } from 'react-bootstrap';
import PropTypes from 'prop-types';

const TopbarSearch = (props) => {
    return (
        <>
            <Form.Group>
                <Row>
                    <Col md={{ span: 3, offset: 9 }}>
                        <InputGroup className="mb-3">
                            <Form.Control
                                placeholder="Search..."
                                name="searchInput"
                                value={props.searchInput}
                                onChange={props.onSearchInputChanged}
                                aria-label="Favorites's name"
                                aria-describedby="basic-addon2"
                            />
                        </InputGroup>
                    </Col>
                </Row>
            </Form.Group>
        </>
    );
};

TopbarSearch.propTypes = {
    onSearchInputChanged: PropTypes.func,
    searchInput: PropTypes.string,
};

export default TopbarSearch;
