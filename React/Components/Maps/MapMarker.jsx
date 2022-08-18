import React from 'react';
import PropTypes from 'prop-types';
import './map-marker.css';

const MapMarker = (props) => {
    const { color, name } = props;
    return <div className="marker" style={{ backgroundColor: color, cursor: 'pointer' }} title={name} />;
};

MapMarker.propTypes = {
    name: PropTypes.string.isRequired,
    color: PropTypes.string.isRequired,
};

export default MapMarker;
