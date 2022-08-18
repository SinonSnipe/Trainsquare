import React, { useEffect, useState } from 'react';
import { Row } from 'react-bootstrap';
import { GetWorkshopRequests } from '../../services/hostService';
import PropTypes from 'prop-types';
import MapRequests from './MapRequests';

import debug from 'sabio-debug';
import NavCard from './NavCard';
const _log = debug.extend('Requests');

const WorkshopRequest = () => {
    useEffect(() => {
        GetWorkshopRequests().then(onRequestSuccess).catch(onRequestError);
    }, []);

    const [requestDat, setRequest] = useState({});

    const onRequestSuccess = (response) => {
        _log('baseresponse', response);
        const request = response.items;
        setRequest((prevState) => {
            let requestDat = { ...prevState };
            requestDat.requestData = request;

            return requestDat;
        });
    };

    const request = requestDat.requestData;
    _log('requestDat', request);
    const onRequestError = (err) => {
        _log(err);
    };

    const mapRequests = (obj) => {
        return <MapRequests key={obj.id} request={obj} />;
    };

    return (
        <React.Fragment>
            <NavCard />
            <>
                <div>
                    {
                        <Row className="workshop-list-items" key={Math.random()}>
                            {request?.map(mapRequests)}
                        </Row>
                    }
                </div>
            </>
        </React.Fragment>
    );
};

WorkshopRequest.propTypes = {
    requestDat: PropTypes.shape({
        requestData: PropTypes.arrayOf(
            PropTypes.shape({
                avatarUrl: PropTypes.string.isRequired,
                briefDescription: PropTypes.string.isRequired,
                dateCreated: PropTypes.string.isRequired,
                dateModified: PropTypes.string.isRequired,
                firstName: PropTypes.string.isRequired,
                hostId: PropTypes.number.isRequired,
                id: PropTypes.number.isRequired,
                lastName: PropTypes.string.isRequired,
                topic: PropTypes.string.isRequired,
                userId: PropTypes.number.isRequired,
            }).isRequired
        ),
    }),
};

export default WorkshopRequest;
