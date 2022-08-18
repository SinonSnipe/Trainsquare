import React, { useEffect, useState } from 'react';
import { Row } from 'react-bootstrap';
import PropTypes from 'prop-types';
import MapWorkShops from './MapWorkshops';
import { GetWorkshops } from '../../services/hostService';
import debug from 'sabio-debug';
import NavCard from './NavCard';
const _log = debug.extend('workshopCard');

const WorkShopsCard = () => {
    useEffect(() => {
        GetWorkshops().then(onWorkshopSuccess).catch(onWorkshopError);
    }, []);

    const [workshopDat, setArrayOfWorkshops] = useState({ workshopData: [] });

    _log('WorkshopResponse', workshopDat);

    const onWorkshopSuccess = (response) => {
        _log(response);
        const workshops = response.items;

        setArrayOfWorkshops((prevState) => {
            let workshopDat = { ...prevState };
            workshopDat.workshopData = workshops;

            return workshopDat;
        });
    };

    const onWorkshopError = (err) => {
        _log(err);
    };

    const workshops = workshopDat.workshopData;

    const mapWorkShopRow = (obj) => {
        return <MapWorkShops key={obj.id} workshop={obj} />;
    };

    return (
        <>
            <NavCard />

            <>
                <div>
                    {
                        <Row className="workshop-list-items" key={Math.random()}>
                            {workshops.map(mapWorkShopRow)}
                        </Row>
                    }
                </div>
            </>
        </>
    );
};

WorkShopsCard.propTypes = {
    workshopDat: PropTypes.shape({
        workshopData: PropTypes.arrayOf(
            PropTypes.shape({
                id: PropTypes.number,
                name: PropTypes.string,
                summary: PropTypes.string,
                shortDescription: PropTypes.string,
                venueId: PropTypes.number,
                hostId: PropTypes.number,
                dateCreated: PropTypes.string,
                dateModified: PropTypes.string,
                statusId: PropTypes.number,
                dateStart: PropTypes.string,
                dateEnd: PropTypes.string,
                imageUrl: PropTypes.string,
                length: PropTypes.string,
            })
        ),
    }),
};

export default WorkShopsCard;
