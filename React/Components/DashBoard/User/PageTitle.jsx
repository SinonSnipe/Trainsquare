import React from 'react';
import { Row, Col, Breadcrumb } from 'react-bootstrap';
import propTypes from 'prop-types';

function PageTitle(props) {
    return (
        <Row>
            <Col>
                <div className="page-title-box">
                    <div className="page-title-right">
                        <Breadcrumb listProps={{ className: 'm-0' }}>
                            <Breadcrumb.Item href="/">Trainsquare</Breadcrumb.Item>

                            {props.breadCrumbItems.map((item, index) => {
                                return item.active ? (
                                    <Breadcrumb.Item active key={index}>
                                        {item.label}
                                    </Breadcrumb.Item>
                                ) : (
                                    <Breadcrumb.Item key={index} href={item.path}>
                                        {item.label}
                                    </Breadcrumb.Item>
                                );
                            })}
                        </Breadcrumb>
                    </div>
                    <h4 className="page-title">{props.title}</h4>
                </div>
            </Col>
        </Row>
    );
}

PageTitle.propTypes = {
    title: propTypes.string.isRequired,
    breadCrumbItems: propTypes.arrayOf(
        propTypes.shape({
            label: propTypes.string.isRequired,
            path: propTypes.string.isRequired,
        })
    ),
};

export default PageTitle;
