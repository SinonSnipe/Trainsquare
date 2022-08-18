import React from 'react';
import classNames from 'classnames';
import propTypes from 'prop-types';

function CardTitle({ title, containerClass }) {
    return (
        <div className={classNames(containerClass)}>
            {typeof title === 'string' ? <h4 className="header-title">{title}</h4> : title}
        </div>
    );
}
CardTitle.propTypes = {
    containerClass: propTypes.string.isRequired,
    title: propTypes.string.isRequired,
};

export default CardTitle;
