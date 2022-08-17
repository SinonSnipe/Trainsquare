import { useEffect, useState, useCallback } from 'react';
import React from 'react';
import debug from 'sabio-debug';
import AdvertisementTemp from './AdvertisementTemp';
import * as advertisementService from '../../services/advertisementService';
import { Link } from 'react-router-dom';
import toastr from '../../utils/toastr';
import ReactPaginate from 'react-paginate';

const _logger = debug.extend('Advertisements');

function Advertisements() {
    _logger('Advertisement Component');

    const [currentPage, setCurrentPage] = useState(0);
    const [pageSize] = useState(6);

    const [pageData, setpageData] = useState({
        arrayOfAdvertisements: [],
        advertisementComponents: [],
        currentPage: 0,
        pageSize: 0,
        totalPages: 0,
    });

    const onGetAdvertisementSuccess = (data) => {
        _logger(data);
        let arrofAdvertisements = data.item.pagedItems;
        let pageIndex = data.item.pageIndex;
        let ps = data.item.pageSize;
        let totalPages = data.item.totalPages;

        setpageData((prevState) => {
            const pd = { ...prevState };
            pd.arrayOfAdvertisements = arrofAdvertisements;
            pd.currentPage = pageIndex;
            pd.pageSize = ps;
            pd.totalPages = totalPages;
            pd.advertisementComponents = arrofAdvertisements.map(mapAdvertisement);
            return pd;
        });
    };

    const pageChange = (data) => {
        _logger(`Page selected was ${data.selected}`);
        setCurrentPage(data.selected);
    };

    const getAdvertisement = () => {
        advertisementService.get(currentPage, pageSize).then(onGetAdvertisementSuccess).catch(onGetAdvertisementError);
    };

    const onGetAdvertisementError = (err) => {
        _logger(err);
    };

    const onAdDeleteRequest = useCallback((advertisement, eObj) => {
        _logger(advertisement, eObj);

        const deleteHandler = onDeleteAdSuccess(advertisement.id);

        advertisementService.deleteAd(advertisement.id).then(deleteHandler).catch(onDeleteAdError);
    }, []);

    const onDeleteAdSuccess = (adIdToBeDeleted) => {
        _logger('onDeleteAdSuccess', adIdToBeDeleted);
        toastr.success(`The Advertisement was successfully deleted.`);

        return () => {
            setpageData((prevState) => {
                const adsData = { ...prevState };

                adsData.arrayOfAdvertisements = [...adsData.arrayOfAdvertisements];
                const idxOf = adsData.arrayOfAdvertisements.findIndex(
                    (advertisement) => advertisement.id === adIdToBeDeleted
                );

                if (idxOf >= 0) {
                    adsData.arrayOfAdvertisements.splice(idxOf, 1);
                    adsData.advertisementComponents = adsData.arrayOfAdvertisements.map(mapAdvertisement);
                }
                return adsData;
            });
        };
    };

    const onDeleteAdError = (error) => {
        _logger(error);
    };

    useEffect(() => {
        _logger('useEffect firing...');
        getAdvertisement();
    }, [currentPage]);

    const mapAdvertisement = (anAd) => {
        return <AdvertisementTemp onAdClicked={onAdDeleteRequest} advertisement={anAd} key={anAd.id} />;
    };

    return (
        <div className="container">
            <div className="container shadow">
                <div className="row p-3 pb-1">
                    <h1 className="col" style={{ textAlign: 'left' }}>
                        Advertisements
                    </h1>
                    <div style={{ width: '10rem' }}></div>
                    <Link to={'/newadvertisement'} style={{ width: '10rem' }} className="btn btn-primary">
                        Create Ad
                    </Link>
                </div>
                <hr />
                <div>
                    <ReactPaginate
                        previousLabel={'previous'}
                        nextLabel={'next'}
                        breakLabel={'...'}
                        pageCount={4}
                        marginPagesDisplayed={3}
                        pageRangeDisplayed={2}
                        onPageChange={pageChange}
                        containerClassName={'pagination justify-content-center'}
                        pageClassName={'page-item'}
                        pageLinkClassName={'page-link'}
                        previousClassName={'page-item'}
                        previousLinkClassName={'page-link'}
                        nextClassName={'page-item'}
                        nextLinkClassName={'page-link'}
                        breakClassName={'page-item'}
                        breakLinkClassName={'page-link'}
                        activeClassName={'active'}
                    />
                </div>
                <div className="card-deck p-3">
                    <h4 style={{ textAlign: 'center' }}>Displaying all active advertisements</h4>
                    <div className="row pt-2">{pageData.advertisementComponents}</div>
                </div>
            </div>
        </div>
    );
}

export default Advertisements;
