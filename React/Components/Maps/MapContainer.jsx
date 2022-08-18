import React, { useState, useCallback, useEffect } from 'react';
import { LoadScript, GoogleMap, Marker, InfoWindow } from '@react-google-maps/api';
import * as workshopService from '../../services/workShopService';
//import MapAutoComplete from './MapAutoComplete';
import MapMarker from './MapMarker';
import PropTypes from 'prop-types';
import toastr from 'toastr';
import debug from 'sabio-debug';

const _logger = debug.extend('WorkshopMap');

const googleApiKey = process.env.REACT_APP_GOOGLE_MAPS_API_KEY;

const mapContainerStyle = {
    height: '1000px',
    width: '1000px',
};

const MapContainer = (props) => {
    const [center, setCenter] = useState(null);

    const [nearby, setNearby] = useState({ workshopsFound: false, workshops: null });

    const [infoWindow, setInfoWindow] = useState({
        isShowing: false,
        workshop: null,
        position: null,
    });

    useEffect(() => {
        if (center) {
            const lat = center.lat;
            const lng = center.lng;
            const radius = 3000;

            workshopService
                .searchGeo(radius, lat, lng)
                .then((response) => {
                    _logger('success->', response.items);
                    setNearby((prevState) => {
                        const workshopData = { ...prevState };
                        workshopData.workshopsFound = true;
                        workshopData.workshops = response.items;
                        return workshopData;
                    });

                    props.setWorkShopCards((prevState) => {
                        const wd = { ...prevState };
                        wd.workshopsFound = true;
                        wd.workshops = response.items;
                        return wd;
                    });
                })
                .catch((err) => {
                    _logger('error->', err);
                    toastr.error('No results found for selected location.', 'Error');
                });
        }
    }, [center]);

    useEffect(() => {
        if (props.coordinates) {
            _logger('coordinateProps->', props.coordinates);

            setCenter(props.coordinates);
        }
    }, [props.coordinates]);

    const onMapClicked = useCallback((map) => {
        _logger('map->', map);

        const coords = {
            lat: map.latLng.lat(),
            lng: map.latLng.lng(),
        };

        setCenter(() => {
            return coords;
        });
    }, []);

    const onDragEnd = () => {
        //future upgrade can capture event data if possible
    };

    const onInfoWindowClosed = () => {
        setInfoWindow((prevState) => {
            const iw = { ...prevState };
            iw.isShowing = false;
            iw.workshop = null;
            iw.position = null;
            return iw;
        });
    };

    const mapMarker = (workshop, index) => {
        const position = {
            lat: workshop.latitude,
            lng: workshop.longitude,
        };

        return (
            <Marker
                key={`${workshop.workshop.id}_${index}_marker`}
                title={`${workshop.workshop.name}(${workshop.workshop.id})`}
                position={position}
                onClick={() => {
                    setInfoWindow((prevState) => {
                        const iw = { ...prevState };
                        iw.isShowing = true;
                        iw.workshop = workshop;
                        iw.position = position;
                        return iw;
                    });
                }}></Marker>
        );
    };

    return (
        <React.Fragment>
            <LoadScript googleMapsApiKey={googleApiKey} libraries={['places']}>
                {/* <div className="row mb-4">
                    <MapAutoComplete key="autocomplete" setMapCenter={setCenter} />
                </div>
                <br /> */}
                <div className="row" style={{ justifyContent: 'center', marginLeft: 'auto', marginRight: 'auto' }}>
                    <GoogleMap
                        id="workshop_map"
                        mapContainerStyle={mapContainerStyle}
                        zoom={12}
                        center={center}
                        onClick={onMapClicked}
                        onDragEnd={onDragEnd}>
                        <MapMarker key="centerMarker" position={center} name="Search Location" color="blue" />
                        {nearby.workshopsFound && nearby.workshops.map(mapMarker)}
                        {infoWindow.isShowing && (
                            <InfoWindow
                                key={`${infoWindow.workshop.workshop.name}_key`}
                                position={infoWindow.position}
                                onCloseClick={onInfoWindowClosed}>
                                <div>
                                    <h4>{infoWindow.workshop.workshop.name}</h4>
                                    <p>{infoWindow.workshop.workshop.summary}</p>
                                </div>
                            </InfoWindow>
                        )}
                    </GoogleMap>
                </div>
            </LoadScript>
        </React.Fragment>
    );
};

MapContainer.propTypes = {
    coordinates: PropTypes.shape({ lat: PropTypes.number, lng: PropTypes.number }),
    setWorkShopCards: PropTypes.func,
};

export default MapContainer;
