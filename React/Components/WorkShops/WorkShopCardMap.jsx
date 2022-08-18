import React, { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import MapContainer from '../../components/maps/MapContainer';
import './work-shop.css';

const WorkShopCardMap = () => {
    const [queryCoordinates, setQueryCoordinates] = useState(null);

    const [workShopCards, setWorkShopCards] = useState({
        workshopsFound: false,
        worskshops: null,
    });

    const { state } = useLocation();

    useEffect(() => {
        if (state?.type === 'COORDINATE_DATA' && state.payload) {
            setQueryCoordinates({ lat: state.payload.lat, lng: state.payload.lng });
        }
    }, [state]);

    const mapWorkShopCards = (workshop, index) => {
        return (
            <div key={`card_${workshop.workshop.id}_${index}`} className="row g-0 mb-.5 workshop-result-horizontalCard">
                <div className="col-md-5">
                    <img
                        src={workshop.workshop.imageUrl}
                        className="workshop-result-img rounded-start"
                        alt={workshop.workshop.name}
                    />
                </div>
                <div className="col-md-7">
                    <div className="card-body">
                        <h4 className="card-title">{workshop.workshop.name}</h4>
                        <p className="card-text workshop-result-desc">{workshop.workshop.shortDescription}</p>
                        <br />
                        <div className="row">
                            <div className="col workshop-result-link">
                                <a className="btn btn-sm btn-primary" href={workshop.workshop.externalSiteUrl}>
                                    More Details
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    };

    return (
        <>
            <h2 style={{ color: '#6169d0', textAlign: 'center' }}>Workshops Near Search Location</h2>
            <div className="workshop-result-container">
                <div className="row">
                    <div className="col-md-7 col-sm-12 workshop-result-col">
                        <div className="card mb-3 workshop-result-scroll">
                            {workShopCards.workshopsFound && workShopCards.workshops.map(mapWorkShopCards)}
                        </div>
                    </div>
                    <div className="col-md-5 col-sm-12 workshop-result-col">
                        <MapContainer coordinates={queryCoordinates} setWorkShopCards={setWorkShopCards} />
                    </div>
                </div>
            </div>
        </>
    );
};

export default WorkShopCardMap;
