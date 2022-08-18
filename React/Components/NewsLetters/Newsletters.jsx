import React, { useState, useEffect, useCallback } from 'react';
import debug from 'sabio-debug';
import { Link } from 'react-router-dom';
import { Row } from 'react-bootstrap';
import Pagination from 'rc-pagination';
import 'rc-pagination/assets/index.css';
import locale from 'rc-pagination/lib/locale/en_US';
import NewslettersCard from '../newsletters/NewslettersCard';
import * as newslettersService from '../../services/newslettersService';
import toastr from '../../utils/toastr';

function Newsletters() {
    const _logger = debug.extend('Newsletters');

    const [pageData, setPageData] = useState({
        arrayOfNewsletters: [],
        newslettersComponents: [],
        pageIndex: 0,
        current: 1,
        pageSize: 4,
        totalCount: 0,
        totalPage: 0,
        query: '',
    });
    const [formData, setFormData] = useState({
        templateId: '',
        name: '',
        coverPhoto: '',
        dateToPublish: '',
        dateToExpire: '',
        arrayOfNewsletterComponents: [],
    });

    useEffect(() => {
        _logger('firing useEffect for get Newsletter template');
        newslettersService
            .paginated(pageData.pageIndex, pageData.pageSize)
            .then(onGetNewslettersSuccess)
            .catch(onGetNewslettersError);
    }, []);

    const onDeleteRequested = useCallback((myNews, eObj) => {
        _logger(myNews.id, { myNews, eObj });
        const handler = getDeleteSuccessHandler(myNews.id);
        newslettersService.deleteById(myNews.id).then(handler).catch(onDeleteNewsError);
    }, []);

    const getDeleteSuccessHandler = (idToBeDeleted) => {
        _logger('getDeleteSuccessHandler', idToBeDeleted);

        return () => {
            _logger('onDeleteNewsSuccess', idToBeDeleted);
            setPageData((prevState) => {
                const pd = { ...prevState };
                pd.arrayOfNewsletters = [...pd.arrayOfNewsletters];

                const idxOf = pd.arrayOfNewsletters.findIndex((newsletter) => {
                    let result = false;

                    if (newsletter.id === idToBeDeleted) {
                        result = true;
                    }

                    return result;
                });

                if (idxOf >= 0) {
                    pd.arrayOfNewsletters.splice(idxOf, 1);
                    pd.newslettersComponents = pd.arrayOfNewsletters.map(mapNewsletter);
                }

                return pd;
            });
            toastr.success('Successfully deleted Newsletter!');
        };
    };

    const onDeleteNewsError = (err) => {
        _logger(err);
        toastr.error('Unable to Delete Newsletter Template....');
    };
    const mapNewsletter = (aNewsletter) => {
        return (
            <NewslettersCard
                oneNewsletter={aNewsletter}
                key={aNewsletter.id}
                onNewsLetterClicked={onDeleteRequested}
                onEditClicked={onGetForm}
            />
        );
    };

    const onGetForm = useCallback((aNewsletter) => {
        _logger('onGetForm', aNewsletter, aNewsletter.id);
        const editHandler = getByIdSuccess(aNewsletter);
        newslettersService.getById(aNewsletter.id).then(editHandler).catch(onGetByIdError);
    }, []);
    const getByIdSuccess = (aNewsletter) => {
        _logger('Get by Id Success Handler', aNewsletter);
        setFormData((prevState) => {
            return {
                ...prevState,
                id: aNewsletter.id,
                templateId: aNewsletter.templateId,
                name: aNewsletter.name,
                coverPhoto: aNewsletter.coverPhoto,
                dateToPublish: aNewsletter.dateToPublish,
                dateToExpire: aNewsletter.dateToExpire,
                dateModified: new Date(aNewsletter.date),
            };
        });
    };
    _logger('formData after getById', formData);
    const onGetByIdError = (err) => {
        _logger(err);
    };

    const onGetNewslettersSuccess = (response) => {
        _logger(response.item.pagedItems);
        _logger(response.item.totalPages);
        let current = response.item.pageIndex + 1;
        let news = response.item.pagedItems;
        let totalPages = response.item.totalPages;
        let totalCount = response.item.totalCount;
        setPageData((prevState) => {
            return {
                ...prevState,
                arrayOfNewsletters: news,
                newslettersComponents: news.map(mapNewsletter),
                totalCount: totalCount,
                current: current,
                totalPages: totalPages,
            };
        });
    };

    const onChangePage = (page) => {
        _logger('page', page);

        setPageData((prevState) => {
            return { ...prevState, pageIndex: page - 1, current: page };
        });
        newslettersService
            .paginated(page - 1, pageData.pageSize)
            .then(onGetNewslettersSuccess)
            .catch(onGetNewslettersError);
    };

    const onGetNewslettersError = (err) => {
        _logger(err);
        let arrayOfNewslettersData = [];
        setPageData((prevState) => {
            return {
                ...prevState,
                arrayOfNewsletters: arrayOfNewslettersData,
            };
        });
    };

    return (
        <React.Fragment>
            <Row>
                <h2 className="page-title"> Newsletters </h2>

                <Link className="rounded-pill mb-3" to="/newsletter/new">
                    <i className="mdi mdi-plus"></i>
                    Create Newsletter
                </Link>
            </Row>
            <Row xl={4} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                {pageData.arrayOfNewsletters.map(mapNewsletter)}
            </Row>
            <div align="center">
                <Pagination
                    className="newsletter-paginate"
                    onChange={onChangePage}
                    pageSize={pageData.pageSize}
                    current={pageData.current}
                    total={pageData.totalCount}
                    locale={locale}
                    hideOnSinglePage={true}
                />
            </div>
        </React.Fragment>
    );
}

export default Newsletters;
