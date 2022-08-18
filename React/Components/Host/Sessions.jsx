import React, { useState, useEffect } from 'react';
import { Row } from 'react-bootstrap';
import NavCard from './NavCard';
import { GetSessions } from '../../services/hostService';
import MapSessions from './MapSessions';

import debug from 'sabio-debug';
const _log = debug.extend('Attendance');

const Attendance = () => {
    useEffect(() => {
        GetSessions().then(onSessionSuccess).catch(onSessionError);
    }, []);

    const [sessionDat, setSession] = useState({});

    const onSessionSuccess = (response) => {
        const session = response.item.pagedItems;
        setSession((prevState) => {
            let sessionDat = { ...prevState };
            sessionDat.sessionData = session;

            return sessionDat;
        });
    };

    const session = sessionDat.sessionData;

    const onSessionError = (err) => {
        _log(err);
    };

    const mapSession = (obj) => {
        return <MapSessions key={obj.id} session={obj} />;
    };
    return (
        <>
            <NavCard />
            <>
                <div>
                    {
                        <Row className="workshop-list-items" key={Math.random()}>
                            {session?.map(mapSession)}
                        </Row>
                    }
                </div>
            </>
        </>
    );
};

export default Attendance;
