import React, { useState, useEffect, useCallback } from 'react';
import debug from 'sabio-debug';
import { Link } from 'react-router-dom';
import { Row } from 'react-bootstrap';
import Pagination from 'rc-pagination';
import 'rc-pagination/assets/index.css';
import locale from 'rc-pagination/lib/locale/en_US';
import NewsletterTemplateCard from '../newslettertemplates/NewsletterTemplateCard';
import * as newsletterTemplatesService from '../../services/newsletterTemplatesService';
import toastr from '../../utils/toastr';

function NewsletterTemplates() {
    const _logger = debug.extend('NewsletterTemplates');

    const [pageData, setPageData] = useState({
        arrayOfNewsletterTemplates: [],
        newsletterTemplatesComponents: [],
        pageIndex: 0,
        current: 1,
        pageSize: 3,
        totalCount: 0,
        totalPage: 0,
        query: '',
    });
    const [formData, setFormData] = useState({
        name: '',
        description: '',
        primaryImage: '',
        createdBy: '',
    });

    useEffect(() => {
        _logger('firing useEffect for get Newsletter template');
        newsletterTemplatesService
            .paginated(pageData.pageIndex, pageData.pageSize)
            .then(onGetNewsletterTemplatesSuccess)
            .catch(onGetNewsletterTemplatesError);
    }, []);

    const onDeleteRequested = useCallback((myNewsTemp, eObj) => {
        _logger(myNewsTemp.id, { myNewsTemp, eObj });
        const handler = getDeleteSuccessHandler(myNewsTemp.id);
        newsletterTemplatesService.deleteById(myNewsTemp.id).then(handler).catch(onDeleteNewsTempError);
    }, []);

    const getDeleteSuccessHandler = (idToBeDeleted) => {
        _logger('getDeleteSuccessHandler', idToBeDeleted);

        return () => {
            _logger('onDeleteNewsTempSuccess', idToBeDeleted);
            setPageData((prevState) => {
                const pd = { ...prevState };
                pd.arrayOfNewsletterTemplates = [...pd.arrayOfNewsletterTemplates];

                const idxOf = pd.arrayOfNewsletterTemplates.findIndex((newsletterTemplate) => {
                    let result = false;

                    if (newsletterTemplate.id === idToBeDeleted) {
                        result = true;
                    }

                    return result;
                });

                if (idxOf >= 0) {
                    pd.arrayOfNewsletterTemplates.splice(idxOf, 1);
                    pd.newsletterTemplatesComponents = pd.arrayOfNewsletterTemplates.map(mapNewsletterTemplate);
                }

                return pd;
            });
            toastr.success('Successfully deleted Newsletter Template!');
        };
    };

    const onDeleteNewsTempError = (err) => {
        _logger(err);
        toastr.error('Unable to Delete Newsletter Template....');
    };

    const mapNewsletterTemplate = (aNewsletterTemplate) => {
        return (
            <NewsletterTemplateCard
                oneNewsletterTemplate={aNewsletterTemplate}
                key={aNewsletterTemplate.id}
                onNewsLetterTemplateClicked={onDeleteRequested}
                onEditClicked={onGetForm}
            />
        );
    };
    const onGetForm = useCallback((aNewsletterTemplate) => {
        _logger('onGetForm', aNewsletterTemplate, aNewsletterTemplate.id);
        const editHandler = getByIdSuccess(aNewsletterTemplate);
        newsletterTemplatesService.getById(aNewsletterTemplate.id).then(editHandler).catch(onGetByIdError);
    });
    const getByIdSuccess = (aNewsletterTemplate) => {
        _logger('Get by Id Success Handler', aNewsletterTemplate);
        setFormData((prevState) => {
            return {
                ...prevState,
                id: aNewsletterTemplate.id,
                name: aNewsletterTemplate.name,
                description: aNewsletterTemplate.description,
                primaryImage: aNewsletterTemplate.primaryImage,
            };
        });
    };
    _logger('formData after getById', formData);
    const onGetByIdError = (err) => {
        _logger(err);
    };

    const onSearchTempsChanged = (event) => {
        const target = event.target;
        const value = target.value;
        const name = target.name;
        setPageData((prevState) => {
            _logger('On Search Change');
            const searchTemps = {
                ...prevState,
            };
            searchTemps[name] = value;
            return searchTemps;
        });
    };

    const onSearchTempsClicked = (e) => {
        _logger(e);

        if (pageData.query) {
            newsletterTemplatesService
                .search(0, pageData.pageSize, pageData.query)
                .then(onGetNewsletterTemplatesSuccess)
                .catch(onGetNewsletterTemplatesError);
        } else {
            newsletterTemplatesService
                .paginated(pageData.pageIndex, pageData.pageSize)
                .then(onGetNewsletterTemplatesSuccess)
                .catch(onGetNewsletterTemplatesError);
        }
    };

    const onGetNewsletterTemplatesSuccess = (response) => {
        _logger(response.item.pagedItems);
        _logger(response.item.totalPages);
        let current = response.item.pageIndex + 1;
        let template = response.item.pagedItems;
        let totalPages = response.item.totalPages;
        let totalCount = response.item.totalCount;
        setPageData((prevState) => {
            return {
                ...prevState,
                arrayOfNewsletterTemplates: template,
                newsletterTemplatesComponents: template.map(mapNewsletterTemplate),
                totalCount: totalCount,
                current: current,
                totalPages: totalPages,
            };
        });
    };

    const onChangePage = (page) => {
        _logger('page', page);

        if (pageData.query) {
            setPageData((prevState) => {
                let arTempData = { ...prevState };
                return arTempData;
            });
            newsletterTemplatesService
                .search(page - 1, pageData.pageSize, pageData.query)
                .then(onGetNewsletterTemplatesSuccess)
                .catch(onGetNewsletterTemplatesError);
        } else {
            setPageData((prevState) => {
                return { ...prevState, pageIndex: page - 1, current: page };
            });
            newsletterTemplatesService
                .paginated(page - 1, pageData.pageSize)
                .then(onGetNewsletterTemplatesSuccess)
                .catch(onGetNewsletterTemplatesError);
        }
    };

    const onGetNewsletterTemplatesError = (err) => {
        _logger(err);
        let arrayOfNewsletterTemplatesData = [];
        setPageData((prevState) => {
            return {
                ...prevState,
                arrayOfNewsletterTemplates: arrayOfNewsletterTemplatesData,
            };
        });
    };

    return (
        <React.Fragment>
            <Row>
                <h2 className="page-title"> Newsletter Templates </h2>
                <Link className="rounded-pill mb-3" to="/newsletter/templates/new">
                    <i className="mdi mdi-plus"></i>
                    Create Newsletter Template
                </Link>
                <div className="d-grid gap-2 d-md-flex justify-content-md-end">
                    <input
                        type="text"
                        className="form-control"
                        name="query"
                        placeholder="Search"
                        aria-label="query"
                        value={pageData.query}
                        onChange={onSearchTempsChanged}
                    />

                    <button className="btn btn-secondary me-md-2" type="button" onClick={onSearchTempsClicked}>
                        Search
                    </button>
                </div>
            </Row>
            <Row xl={4} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                {pageData.arrayOfNewsletterTemplates.map(mapNewsletterTemplate)}
            </Row>

            {/* <div className="row">{pageData.arrayOfNewsletterTemplates.map(mapNewsletterTemplate)}</div> */}

            <div align="center">
                <Pagination
                    className="newslettertemp-paginate"
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

export default NewsletterTemplates;
