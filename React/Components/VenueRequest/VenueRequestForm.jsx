import React, { useEffect, useState, useCallback} from 'react';
import { Card, Container, Row } from 'react-bootstrap';
import { useLocation, useParams } from 'react-router-dom';
import PropTypes from 'prop-types';
import debug from 'sabio-debug';
import * as venue from '../../services/venueRequestService';
import { Formik, Form, Field, ErrorMessage} from 'formik';
import venueSchema from '../../schema/venueSchema';
import toastr from '../../utils/toastr';
import VenueRequestCard from './VenueRequestCard'



const _logger = debug.extend('BookVenue');

const VenueRequestForm = (props) => {
    _logger('props?-->', props )
   const location = useLocation();
   let {id} = useParams();

   const [formData, setFormData] = useState({
            venue: {
            venueDescription:'',
            eventDescription: '',
            url:'',
            startDate: '',
            endDate: '',
            venueId: '',
            venueName:'',
            userName:'',
            phoneNumber: '',
            email:'',
            requester: '',
            startTime: '',
            endTime: ''
            },
    });

    const [cardData, setCardData] = useState({
        arrayOfVenues: [],
        venuesComponents: []
});

  useEffect(() => {
    _logger('this', location.state.aVenue);
    if (location.state.aVenue) {
        const currentVenue = location.state.aVenue;
        setFormData((prevState) => {
            const newState = { ...prevState };
            newState.venue.venueDescription = currentVenue.description;
            newState.venue.venueName = currentVenue.name;
            newState.venue.url = currentVenue.imageUrl;
            newState.venue.venueId = currentVenue.id;
            return newState;
        });
        venue.getById(currentVenue.id).then(getByVenueIdSuccess).catch(getByVenueIdError)
    }
}, []);


const onReserveClicked = (values) => {
    _logger('reserveclicked', values)
    const venueData = {
        eventDescription: values.eventDescription,
        venueId: parseInt({id}.id),
        startDate: `${values.startDate} ${values.startTime}`,
        endDate: `${values.endDate} ${values.endTime}` ,
        requester: "1",  
        userName: values.userName,
        phoneNumber: values.phoneNumber,
        email: values.email   
    }
    _logger('reserve clicked-->', venueData)
    venue.create(venueData).then(onAddVenueRequestSuccess).catch(onAddVenueRequestError);
}
 
const onAddVenueRequestSuccess = (response) => {
    _logger('Venue Request successfully added->', response);
    toastr.success('Venue Successfully Booked!');
    venue.getById(response.venueId).then(getByVenueIdSuccess).catch(getByVenueIdError)
};

const onAddVenueRequestError = (err) => {
    _logger('Venue Request error->', err);
    toastr.error('Error: Could not book venue.');
};

const getByVenueIdSuccess = (response) => {
    let venues = response.pagedItems;
    _logger('arrayOfVenues', venues)
    setCardData((prevState)=>{
     return {...prevState, arrayOfVenues: venues, venuesComponents: venues.map(mapVenueRequest)}
    })
}
  
const getByVenueIdError = (response) => {
_logger("getByvenueId error", response)
toastr.error('Error: Could not find venue.');
}    

const mapVenueRequest = (venueRequest) => {
    return <VenueRequestCard 
                venueRequest={venueRequest} 
                key={venueRequest.id}
                onDeleteClicked={onRemoveRequested}
                onEditClicked={onEditRequested}
            />;
};

const onEditRequested = (values) => {
    _logger('values-->', values)
    let startDate = values.startDate.split("T")[0]
    let startTime = values.startDate.split("T")[1]   
    let endDate = values.endDate.split("T")[0]
    let endTime = values.endDate.split("T")[1]   

    setFormData((prevState) => {
        const newState = { ...prevState };
        newState.venue.eventDescription = values.eventDescription;
        newState.venue.startDate = startDate;
        newState.venue.endDate = endDate;
        newState.venue.startTime = startTime;
        newState.venue.endTime = endTime;
        newState.venue.requester = values.requester
       
        const fakeHost = { ...prevState };
        fakeHost.venue.userName = 'Allen La Rosa';
        fakeHost.venue.phoneNumber = '(925)-724-8055';
        fakeHost.venue.email = 'allen.larosa@ymail.com';

        return newState;
    });
};

const onRemoveRequested = useCallback((currentRequest) => {
    const handler = getSuccessHandler(currentRequest);
    venue.deleteById(currentRequest).then(handler).catch(onRemoveError);
}, []);

const getSuccessHandler = (idToBeDeleted) => {
    return () => {
        setCardData((prevState) => {
            const pd = { ...prevState };
            const venues = pd.arrayOfVenues;
            const idxOf = venues.findIndex((aVenue) => aVenue.id === idToBeDeleted);

            if (idxOf >= 0) {
                venues.splice(idxOf, 1);
                pd.requestComponents = venues.map(mapVenueRequest);
            }
            return pd;
        });
        toastr.info(`Event has been deleted.`);
    };
};

const onRemoveError = (err) => {
    toastr.error(err);
};

    return (
        <>
        <div className="container">
                <Card className="p-2 mx-5 my-4 ">
                    <Card.Header>
                        <h2>Book This Venue:</h2> 
                    </Card.Header>
                    <Formik
                        enableReinitialize={true}
                        initialValues={formData.venue}
                        onSubmit={onReserveClicked}
                        validationShchema={venueSchema}>
                    <Form>
                    <Row>
                        <div className="text-center col">
                            <h4>{formData.venue.venueName}</h4>
                            <img src={formData.venue.url} alt="" style={{height: "350px", width: "600px"}} className="mb-3 img-fluid rounded-corners" />
                            <p>{formData.venue.venueDescription}</p>
                            <div className="row">
                                <div className="col-4">
                                    <label htmlFor="userName">Name</label>
                                    <Field type="text" name="userName" className="form-control" />
                                    <ErrorMessage name="userName" component="div" className="has-error" />
                                </div>
                                <div className="col-4">
                                    <label htmlFor="phoneNumber">Phone Number</label>
                                    <Field type="text" name="phoneNumber" className="form-control" />
                                    <ErrorMessage name="phoneNumber" component="div" className="has-error" />
                                </div>
                                <div className="col-4">
                                    <label htmlFor="email">Email</label>
                                    <Field type="text" name="email" className="form-control" />
                                    <ErrorMessage name="email" component="div" className="has-error" />
                                </div>
                                <div className="col-12 mt-2">
                                    <label htmlFor="eventDescription">Event Description</label>                                   
                                    <Field
                                        component="textarea"
                                        name="eventDescription"
                                        type="text"
                                        placeholder="Enter a short description"
                                        className="form-control"></Field>

                                    <ErrorMessage name="eventDescription" component="div" className="has-error" />
                                </div>
                                <div className="col mt-2">
                                    <label htmlFor="startDate">Start Date</label>
                                    <Field type="date" name="startDate" className="form-control" />
                                    <ErrorMessage name="startDate" component="div" className="has-error" />
                                </div>
                                <div className="col mt-2">
                                    <label htmlFor="endDate">End Date</label>
                                    <Field type="date" name="endDate" className="form-control" />
                                    <ErrorMessage name="endDate" component="div" className="has-error" />
                                </div>    
                            </div>
                            <div className="row">
                                <div className="col">
                                    <label className="mt-2" htmlFor="startTime">Start Time</label>
                                    <Field type="time" name="startTime" className="form-control" />
                                    <ErrorMessage name="startTime" component="div" className="has-error" />
                                </div>
                                <div className="col">
                                    <label className="mt-2" htmlFor="endTime">End Time</label>
                                    <Field type="time" name="endTime" className="form-control" />
                                    <ErrorMessage name="endTime" component="div" className="has-error" />
                                </div>
                            </div>
                            <button type="submit" className="btn col-4 btn-info my-2">
                                  Reserve
                            </button>    
                        </div>  
                    </Row>    
                    </Form>
                    </Formik>
                </Card>    
            </div>
                <Container>
                <h2 className="mt-5">Upcoming Reservations:</h2> 
                <div className="row">{cardData.arrayOfVenues.map(mapVenueRequest)}</div>
                </Container>
                
                 
        </>
    );
};

VenueRequestForm.propTypes = {
    venueRequest: PropTypes.shape({
        venueId: PropTypes.number.isRequired,
        endDate: PropTypes.number.isRequired,
        startDate: PropTypes.number.isRequired,
        eventDescription: PropTypes.string.isRequired,
    }),
};

export default VenueRequestForm;
