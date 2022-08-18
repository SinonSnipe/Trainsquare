import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Button } from 'react-bootstrap';
import PropTypes from 'prop-types';
import { GetProfile } from '../../services/hostService';
import NavCard from './NavCard';

import debug from 'sabio-debug';

const _log = debug.extend('ProfileCard');

const ProfileCard = () => {
    useEffect(() => {
        GetProfile().then(onProfileSuccess).catch(onProfileError);
    }, []);

    const [profileDat, setProfile] = useState({});

    const onProfileSuccess = (response) => {
        _log(response);
        const profile = response.item;
        setProfile((prevState) => {
            let profileDat = { ...prevState };
            profileDat.profileData = profile;

            return profileDat;
        });
    };

    const profile = profileDat.profileData;

    const onProfileError = (err) => {
        _log(err);
    };

    return (
        <>
            <NavCard />
            <Row>
                <Col style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                    <Card className="w-50 border .mx-auto position-relative">
                        <Card.Body className="text-center mb-2">
                            <Row>
                                <Col>
                                    <div className="text-center mt-1">
                                        <p className="text-black mb-2 font-13">
                                            <strong>Full Name :</strong>
                                            <span className="ms-2">
                                                {profile?.firstName}
                                                {profile?.middleI}  
                                                {profile?.lastName}{' '}
                                            </span>
                                        </p>
                                       
                                        <p className="text-black mb-2 font-13">
                                            <strong>Email :</strong>
                                            <span className="ms-2">{profile?.email} </span>
                                        </p>
                                        
                                        <p className="text-black mb-1 font-13">
                                            <strong>Member Since :</strong>
                                            <span className="ms-2">{profile?.dateCreated} </span>
                                        </p>
                                    </div>
                                    <Button>Edit Profile</Button>
                                </Col>
                            </Row>
                        </Card.Body>
                    </Card>
                </Col>
            </Row>
        </>
    );
};

ProfileCard.propTypes = {
    profileData: PropTypes.shape({
        userId: PropTypes.number.isRequired,
        hostId: PropTypes.number.isRequired,
        firstName: PropTypes.string.isRequired,
        middleI: PropTypes.string.isRequired,
        lastName: PropTypes.string.isRequired,
        avatarUrl: PropTypes.string.isRequired,
        dateCreated: PropTypes.string.isRequired,
        email: PropTypes.string.isRequired,
    }),
};

export default ProfileCard;
