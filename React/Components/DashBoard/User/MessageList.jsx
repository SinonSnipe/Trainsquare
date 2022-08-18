//Message componant are still hard coding and proptypes maynot be accurated
import React from 'react';
import classNames from 'classnames';
import propTypes from 'prop-types';

const MessageList = (props) => {
    const children = props.children || null;
    const Tag = props.tag;

    return (
        <Tag className={classNames('inbox-widget', props.className)} {...props}>
            {children}
        </Tag>
    );
};

MessageList.defaultProps = {
    tag: 'div',
};

MessageList.propTypes = {
    tag: propTypes.string.isRequired,
    className: propTypes.string,
    children: propTypes.node.isRequired,
};

export default MessageList;
