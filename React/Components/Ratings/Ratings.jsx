import React, { useState, useEffect } from 'react';
import debug from 'sabio-debug';
import RatingTemplate from './RatingTemplate'
import ratingService from '../../services/ratingService'
import { Card, Pagination } from 'react-bootstrap';
import toastr from 'toastr';

const _logger = debug.extend('ratings');

function Ratings(){    
                                                                                                                                                                                                                               
    const [ratingData, setRatingData] = useState({
        subject: '',
        text: '',    
        name: '',
        email: '',  
        firstName: '',
        lastName: '',
        id: '',
        rating: '',
        commentId: '',
        entityTypeId: '',
        entityId: '',
        dateCreated: '',
        dateModified: '',
        createdBy: '',
        isDeleted: false
    }); 

    const [pageData, setPageData] = useState({
        pageIndex: 0,
        current: 1,
        pageSize: 10,
        totalCount: 0,
        totalPages: 0,
    });

    useEffect(() => {
        _logger('useEffect Firing')
        ratingService.getAllRatingsPaginate(pageData.pageIndex, pageData.pageSize)
        .then(onGetRatingsSuccess)
        .catch(onGetRatingsError);
    },[])

    const onPrevClick = () => {
        setPageData((prevState) => {
            let pd = { ...prevState };
            pd.current = prevState.current - 1;
            pd.index = prevState.index - 1;
            return pd;
        });
    };

    const onNextClick = () => {
        setPageData((prevState) => {
            let pd = { ...prevState };
            pd.current = prevState.current + 1;
            pd.index = prevState.index + 1;
            return pd;
        });
    };
                     
    const mapRating = (aRating) =>(
        <RatingTemplate
            rating={aRating}
            key={'ratingList' + aRating.Id}
            >
        </RatingTemplate>
    );
       


    const onGetRatingsSuccess = (data) => {
        _logger(data);
        let arrayOfRatings = data.item.pagedItems;
        const ratingCount = data.item.totalCount;
        const ratingPages = data.item.totalPages;
        const currentPage = data.item.pageIndex + 1;
        _logger(arrayOfRatings, ratingCount, ratingPages, currentPage);
         
        setRatingData((prevState) => {
            const ratingsData = {...prevState};
            ratingsData.arrayOfRatings = arrayOfRatings;
            ratingsData.ratingsComponents = arrayOfRatings.map(mapRating);
            return ratingsData;
        }); 
                 
        setPageData((prevState) => {
            const pd = {...prevState};
            pd.totalCount = ratingCount
            pd.totalPages = ratingPages
            pd.currentPage = currentPage
            _logger(pd);
            return pd;
        });
    }

    const onGetRatingsError = (err) => {
        _logger(err)
        toastr.error("Failed to get ratings from server")
    }

    return (
        <React.Fragment>
            <Card>
                <div className="container">
                    <div className="row">
                        <div className="page-title-box">
                            <h1 className='card-text text-left'>My Ratings</h1>
                        </div>
                        <div className="row">{ratingData.ratingsComponents}</div>
                    </div> 
                        <div>
                        <Pagination>
                        <Pagination.Prev onClick={onPrevClick} />
                        {pageData.items}
                        <Pagination.Next onClick={onNextClick} />
                    </Pagination>
                        </div>
                </div>
            </Card>
        </React.Fragment>
    )
}

export default Ratings;
