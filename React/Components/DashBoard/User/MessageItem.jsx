//Message componant are still hard coding and proptypes maynot be accurated
import React from 'react';
import classNames from 'classnames';
import propTypes from 'prop-types';

const MessageItem = (props) => {
    const children = props.children || null;
    const Tag = props.tag;

    return (
        <Tag className={classNames('inbox-item', props.className)} {...props}>
            {children}
        </Tag>
    );
};

MessageItem.defaultProps = {
    tag: 'div',
};

MessageItem.propTypes = {
    tag: propTypes.string.isRequired,
    className: propTypes.string,
    children: propTypes.node.isRequired,
};

export default MessageItem;
