import React from 'react';
import { Link } from 'react-router-dom';
import { Card, Row, Col } from 'react-bootstrap';
import './host.css';

// import debug from 'sabio-debug';
// const _log = debug.extend('HostDash');

const NavCard = () => {
    return (
        <Card className=" navCardStyle pb-3">
            <Row>
                <Col lg={12}>
                    <div className="navCard_container page-title-box">
                        <Link to="/dashboard/host">
                            <h4 className="navCard_text_color page-title">My Hosting Dashboard</h4>
                        </Link>
                    </div>
                </Col>
            </Row>

            <Row className="text-center">
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/workshops">
                            Workshops
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/sessions">
                            Sessions
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/notes">
                             Notes
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/workshopRequest">
                             Requests
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/lessons">
                             Lessons
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/attendance">
                            Attendance
                        </Link>
                    </button>
                </Col>
                <Col>
                    <button className=" navCardButt">
                        <Link className="navCard_text_color" to="/dashboard/host/profile">
                             Profile
                        </Link>
                    </button>
                </Col>
            </Row>
        </Card>
    );
};

export default NavCard;
