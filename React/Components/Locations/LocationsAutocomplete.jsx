//Call setBounds() to change the search area on an existing Autocomplete.

import React, {useState} from 'react'
import { GoogleMap, LoadScript, Autocomplete} from '@react-google-maps/api';


import logger from 'sabio-debug';
// import { search } from '../../services/newsletterTemplatesService';
const _log = logger.extend('Autocomplete');


const googleApiKey= process.env.REACT_APP_GOOGLE_MAPS_API_KEY;

const containerStyle = {
  width: '400px',
  height: '400px'
};

const center = {
  lat: 25.1972,
  lng: 55.2744
};

const searchOptions = {
  componentRestrictions: { country: ['ae'] },
  types: ['city']
}

export default function MyComponent() {

  const [autocomplete, setAutocomplete] = useState(); 

  const onLoad = (autocomplete) => {
    _log('autocomplete: ', autocomplete)
    setAutocomplete(() => autocomplete)
  };
    
  const onPlaceChanged = () => {
    if (autocomplete !== null) {
      const place = autocomplete.getPlace();
      _log('onPlaceChanged', place)
      _log('onPlaceChanged Latitude', place.geometry.location.lat())
      _log('onPlaceChanged Longitude', place.geometry.location.lng())
    } 
    else {
      _log('Autocomplete is not loaded yet!')
      }
  };
    

  return (
    <React.Fragment>
        <LoadScript
            googleMapsApiKey={googleApiKey}
            libraries={["places"]}
        >
            <div className='row justify-content-center'>
                <Autocomplete
                    searchOptions = {searchOptions}

                    onLoad={onLoad}
                    onPlaceChanged={onPlaceChanged}
                >
                    <input
                        type="text"
                        placeholder="What shall you search for?"
                        style = {{
                        // zIndex: -1,
                         boxSizing: `border-box`,
                         border: `1px solid transparent`,
                         width: `240px`,
                         height: `32px`,
                         padding: `0 12px`,
                         borderRadius: `3px`,
                        boxShadow: `0 2px 6px rgba(0, 0, 0, 0.3)`,
                        fontSize: `14px`,
                        outline: `none`,
                        textOverflow: `ellipses`,
                        position: "absolute",
                        left: "50%",
                        marginLeft: "-120px"
                            }}
                    />
                </Autocomplete>
            </div>
            <div>
                <GoogleMap
                    id="searchbox-example"
                    mapContainerStyle={containerStyle}
                    center={center}
                    zoom={10}
                    >
                </GoogleMap>
            </div>
        </LoadScript>
    </React.Fragment>
  )
}