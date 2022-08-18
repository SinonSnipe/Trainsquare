import React from 'react';
import { Card } from 'react-bootstrap';
import classNames from 'classnames';
import propTypes from 'prop-types';
import '../userDashboard.css';

const DashBoardStats = (props) => {
    const textClass = props.textClass || 'text-muted';

    return (
        <Card className={classNames('widget-flat', 'control-card', props.bgclassName)}>
            <Card.Body>
                <img src={props.icon} alt={props.nameicon} className="iconControl" />
                <div className="textDisplay">
                    <h5 className={classNames('fw-normal', 'mt-0', 'titleClass', textClass)} title={props.description}>
                        {props.title}
                    </h5>
                    <h3 className={classNames('mt-3', 'mb-3', 'numberClass', props.textClass ? props.textClass : null)}>
                        {props.stats}
                    </h3>

                    {props.trend && (
                        <p className={classNames('mb-0', textClass)}>
                            <span className="text-nowrap">{props.trend.total}</span>
                        </p>
                    )}
                </div>
            </Card.Body>
        </Card>
    );
};

DashBoardStats.propTypes = {
    icon: propTypes.string.isRequired,
    nameicon: propTypes.string.isRequired,
    description: propTypes.string.isRequired,
    title: propTypes.string.isRequired,
    stats: propTypes.number.isRequired,
    bgclassName: propTypes.string.isRequired,
    textClass: propTypes.string.isRequired,

    trend: propTypes.shape({
        textClass: propTypes.string.isRequired,
        total: propTypes.string.isRequired,
    }),
};

export default DashBoardStats;
