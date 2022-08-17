import debug from 'sabio-debug';
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import './Advertisement.css';
import { useNavigate } from 'react-router-dom';
//import { format } from 'date-fns';

function Advertisement(props) {
    const _logger = debug.extend('Advertisement Template');
    _logger('Advertisment Template');
    const navigate = useNavigate();

    const [showDetails, setShowRest] = useState({ show: false });

    const anAd = props.advertisement;

    const onDeleteClick = (e) => {
        e.preventDefault();
        props?.onAdClicked(props?.advertisement, e);
    };

    const onClickReadMore = () => {
        setShowRest(() => {
            return { show: !showDetails.show };
        });

        _logger('Showing remaining details');
    };

    const onEditClick = (e) => {
        _logger(e.currentTarget.dataset.id);
        navigate(e.currentTarget.dataset.id, { state: anAd });
    };

    return (
        <div className="col-md-6 col-lg-4 d-flex align-items-stretch">
            <div className="card border ">
                <img
                    className="card-img-top"
                    width={300}
                    height={200}
                    src={anAd.adMainImage || 'https://bit.ly/3rGMrZZ'}
                    alt="Card"
                />
                <div className="card-body ">
                    <p className="card-text">{anAd.title}</p>
                    <div>
                        <p className="card-details">
                            {showDetails.show ? anAd.details : `${anAd.details.slice(0, 100)}...`}
                        </p>

                        <a className="text-smaller" onClick={onClickReadMore}>
                            {showDetails.show ? 'Read less' : 'Read more'}
                        </a>
                    </div>
                    <small className="start-date text-muted pe-5">{`Workshop starts ${new Date(
                        anAd.dateStart
                    ).toDateString()}`}</small>
                </div>
                <div className="card-footer">
                    <button
                        data-id={`/updateadvertisement/${anAd.id}`}
                        onClick={onEditClick}
                        style={{ width: '6rem' }}
                        className=" btn btn-primary m-1 ps-2">
                        {' '}
                        Edit Ad{' '}
                    </button>
                    <button onClick={onDeleteClick} style={{ width: '6rem' }} className=" btn btn-warning m-1pl-6">
                        {' '}
                        Delete Ad{' '}
                    </button>
                </div>
            </div>
        </div>
    );
}

Advertisement.propTypes = {
    advertisement: PropTypes.shape({
        adMainImage: PropTypes.string.isRequired,
        title: PropTypes.string.isRequired,
        details: PropTypes.string.isRequired,
        id: PropTypes.number.isRequired,
        dateStart: PropTypes.string.isRequired,
    }),
    onAdClicked: PropTypes.func,
};

export default Advertisement;
