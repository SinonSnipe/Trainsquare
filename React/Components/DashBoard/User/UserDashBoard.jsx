import React, { useEffect, useState } from 'react';
import { Row, Col } from 'react-bootstrap';
import propTypes from 'prop-types';
import debug from 'sabio-debug';

import FaqBanner from './workshops/FaqBanner';
import PageTitle from './pagetitles/PageTitle';
import Profile from './profile/Profile';
import Messages from './message/Message';
import MyWorkshopsUserDashboard from './workshops/MyWorkshopsUserDashboard';
import DashBoardStats from './dashboardstats/DashBoardStats';
import Payment from './payment/Payment';
import * as userDashBoardService from '../../../services/userDashBoardServices';

import workshopicon from '../../../assets/images/dashboard/user/workshop-icon.png';
import usericon from '../../../assets/images/dashboard/user/user-icon.png';
import sessionicon from '../../../assets/images/dashboard/user/session-icon.png';
import ordericon from '../../../assets/images/dashboard/user/order-icon.png';

import FavoriteWorkshopsUserDashboard from '../../favoriteWorkshops/FavoriteWorkshopsUserDashboard';

const _logger = debug.extend('UserDashBoard'); //sabio:UserDashBoard

function UserDashBoard({ currentUser }) {
    const [userTotal, setUserTotal] = useState(0);
    const [sessionTotal, setSessionTotal] = useState(0);
    const [orderTotal] = useState(0);
    const [workshopTotal, setWorkshopsTotal] = useState(0);

    useEffect(() => {
        userDashBoardService.getTotalUsers(0, 1).then(onGetTotalUsersSuccess).catch(onGetGetTotalUsersError);
        userDashBoardService.getTotalSessions(0, 1).then(onGetTotalSessionsSuccess).catch(onGetTotalSessionsError);
    }, []);

    const onGetTotalUsersSuccess = (response) => {
        let total = response.data.item.totalCount;
        setUserTotal(total);
    };
    const onGetGetTotalUsersError = (response) => {
        _logger(response);
    };

    const onGetTotalSessionsSuccess = (response) => {
        let total = response.data.item.totalCount;
        setSessionTotal(total);
    };
    const onGetTotalSessionsError = (response) => {
        _logger(response);
    };

    const setUptotal = (total) => {
        if (!workshopTotal) {
            setWorkshopsTotal(total);
        }
    };

    return (
        <div>
            <PageTitle
                breadCrumbItems={[{ label: 'User', path: '/apps/user/dashboard', active: true }]}
                title={'User Dashboard'}
            />
            <Row>
                <Col xxl={3} sm={6}>
                    <DashBoardStats
                        icon={workshopicon}
                        nameicon="workshopicon"
                        description="Workshops"
                        title="Workshops"
                        stats={workshopTotal}
                        trend={{
                            textClass: 'badge bg-info',
                            icon: 'mdi mdi-arrow-down-bold',
                            total: 'Total Workshops',
                        }}
                        bgclassName="bg-primary"
                        textClass="text-white"
                    />
                </Col>
                <Col xxl={3} sm={6}>
                    <DashBoardStats
                        icon={usericon}
                        nameicon="usericon"
                        description="Members"
                        title="Members"
                        stats={userTotal}
                        trend={{
                            textClass: 'badge bg-info',
                            icon: 'mdi mdi-arrow-down-bold',
                            total: 'Total Members',
                        }}
                        bgclassName="bg-primary"
                        textClass="text-white"
                    />
                </Col>
                <Col xxl={3} sm={6}>
                    <DashBoardStats
                        icon={sessionicon}
                        nameicon="sessionicon"
                        description="Sessions"
                        title="Sessions"
                        stats={sessionTotal}
                        trend={{
                            textClass: 'badge bg-info',
                            total: 'Total Sessions',
                        }}
                        bgclassName="bg-primary"
                        textClass="text-white"
                    />
                </Col>
                <Col xxl={3} sm={6}>
                    <DashBoardStats
                        icon={ordericon}
                        nameicon="ordericon"
                        description="Orders"
                        title="Orders"
                        stats={orderTotal}
                        trend={{
                            textClass: 'badge bg-info',
                            total: 'Total Orders',
                        }}
                        bgclassName="bg-primary"
                        textClass="text-white"
                    />
                </Col>
            </Row>

            <Row>
                <Col xl={9}>
                    <MyWorkshopsUserDashboard setUptotal={setUptotal} />
                </Col>

                <Col xl={3}>
                    <Profile currentUser={currentUser} />
                </Col>
            </Row>

            <Row>
                <Col xl={9}>
                    <Payment />
                </Col>
                <Col xl={3}>
                    <Messages />
                </Col>

                <Col xl={4}>
                    <FaqBanner />
                </Col>
            </Row>

            <Row>
                <Col xl={9}>
                    <FavoriteWorkshopsUserDashboard />
                </Col>
            </Row>
        </div>
    );
}

UserDashBoard.propTypes = {
    currentUser: propTypes.shape({
        email: propTypes.string.isRequired,
        id: propTypes.number.isRequired,
        roles: propTypes.arrayOf(propTypes.string),
        isLoggedIn: propTypes.bool.isRequired,
        profilePic: propTypes.string.isRequired,
    }),
};
export default UserDashBoard;
