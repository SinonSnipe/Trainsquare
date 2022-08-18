import React, { useState, useEffect, useCallback } from "react";
import { Row, Col, Button, ButtonGroup, } from 'react-bootstrap';
import * as surveyService from "../../services/surveyService";
import locale from 'rc-pagination/lib/locale/en_US';
import { useDebounce } from "./Debounce";
import { Link } from "react-router-dom";
import * as toastr from "toastr"
import Pagination from 'rc-pagination';
import Survey from "./Survey"

import debug from "sabio-debug";
const _logger = debug.extend("Surveys");

const Surveys = () => {

    const [pageData, setPageData] = useState({
        arrayOfSurveys: [],
        surveyComponents: [],
    });

    const [page, setPage] = useState({
        pageIndex: 0,
        pageSize: 8,
        currentPage: 0,
        totalPages: 0
    });

    const [searchInput, setSearchInput] = useState("")

    const changeHandler = (e) => {
        e.preventDefault()
        setSearchInput(e.target.value)
    }

    const onDeleteRequested = useCallback((mySurvey, e) => {
        _logger(mySurvey.id, { mySurvey, e });
        const handler = getDeleteSuccessHandler(mySurvey.id)
        surveyService.deleteSurvey(mySurvey.id).then(handler).catch(onDeleteError)

    }, []);
    const getDeleteSuccessHandler = (idToBeDeleted) => {

        return () => {
            setPageData(prevState => {
                const pd = { ...prevState };
                pd.arrayOfSurveys = [...pd.arrayOfSurveys];

                const idxOf = pd.arrayOfSurveys.findIndex((survey) => {
                    let result = false;

                    if (survey.id === idToBeDeleted) {
                        result = true;
                    }

                    return result;
                });

                if (idxOf >= 0) {
                    pd.arrayOfSurveys.splice(idxOf, 1);
                    pd.surveyComponents = pd.arrayOfSurveys.map(mapSurvey);
                }

                return pd;
            });
        }
    }
    const onDeleteError = (error) => {
        _logger(error);
        toastr.error("Record Not Deleted")
    }

    useEffect(() => {

        surveyService.selectAll(page.pageIndex, page.pageSize).then(onSelectAllSuccess).catch(onSelectAllError);

    }, [])

    const debouncedSearchInput = useDebounce(searchInput, 1000)

    useEffect(() => {
        if (searchInput.length > 0) {
            surveyService.getByQuery(page.pageIndex, page.pageSize, searchInput)
                .then(onSuccessGetCreatedBy)
                .catch(onErrorGetCreatedBy)
        }
        else {
            surveyService.selectAll(page.pageIndex, page.pageSize)
                .then(onSelectAllSuccess)
                .catch(onSelectAllError)
        }
    }, [debouncedSearchInput])

    const onSelectAllSuccess = (data) => {
        _logger(data.item.pagedItems)
        _logger("pageIndex>>", data.item.pageIndex, "pageSize>>", data.item.pageSize, "totalPages>>", data.item.totalPages)
        setPage((prevState) => {
            let sp = { ...prevState };
            sp.pageIndex = data.item.pageIndex;
            sp.pageSize = data.item.pageSize;
            sp.totalPages = data.item.totalPages;
            return sp;
        })
        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.arrayOfSurveys = data.item.pagedItems
            pd.surveyComponents = data.item.pagedItems.map(mapSurvey);
            return pd
        })
    }
    const onSelectAllError = (error) => {
        _logger(error)
        toastr.error("Records not Found")
    }
    const onSuccessGetCreatedBy = (data) => {
        _logger(data.item.pagedItems)

        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.arrayOfSurveys = data.item.pagedItems
            pd.surveyComponents = data.item.pagedItems.map(mapSurvey);
            return pd
        })
    }
    const onErrorGetCreatedBy = (error) => {
        _logger(error)
        toastr.error("Records not Found")
    }

    const mapSurvey = (aSurvey) => {
        return (
            <Col md={6} xxl={3} key={'SurveyA-' + aSurvey.id}>
                <Survey
                    survey={aSurvey}
                    onDeleteClicked={onDeleteRequested}
                />
            </Col>
        )
    }


    const onFilter = (e) => {
        e.preventDefault();
        _logger(e.target.id)
        if (e.target.id > 0) {
            surveyService.getByStatus(page.pageIndex, page.pageSize, e.target.id)
                .then(onSuccessGetCreatedBy)
                .catch(onErrorGetCreatedBy)
        }
        else {
            surveyService.selectAll(page.pageIndex, page.pageSize)
                .then(onSelectAllSuccess)
                .catch(onSelectAllError)
        }

    }

    const onChange = (page) => {
        surveyService
            .selectAll(page - 1, 8)
            .then(onSelectAllSuccess)
            .catch(onSelectAllError);
        setPage((prevState) => {
            let sp = { ...prevState };
            sp.currentPage = page;
            return sp;
        });
    };

    return (
        <>
            <Row className="mb-2">
                <h2>Survey</h2>
            </Row>

            <Row className="searchInputs">
                <Col sm={12}>
                    <input
                        type="text"
                        className="form-control"
                        placeholder="Search..."
                        value={searchInput}
                        onChange={changeHandler}
                    />
                </Col>
            </Row>
            <hr />

            <Row className="mb-2">
                <Col sm={4}>
                    <Link to="/surveys/create" variant="danger" className="rounded-pill mb-3">
                        <i className="mdi mdi-plus"></i> Create Survey
                    </Link>
                </Col>
                <Col sm={8}>
                    <div className="text-sm-end">

                        <ButtonGroup className="mb-3 ms-1">
                            <Button onClick={onFilter} variant="light" id="0">All</Button>
                            <Button onClick={onFilter} variant="light" id="1">Active</Button>
                            <Button onClick={onFilter} variant="light" id="2">Inactive</Button>
                            <Button onClick={onFilter} variant="light" id="3">Pending</Button>
                            <Button onClick={onFilter} variant="light" id="4">Cancelled</Button>
                        </ButtonGroup>
                    </div>
                </Col>
            </Row>
            <Row>
                {pageData.arrayOfSurveys.map(mapSurvey)}
            </Row>
            <Row>
                <Pagination
                    className="mb-2"
                    onChange={onChange}
                    currentPage={page.currentPage}
                    total={page.totalPages * 10}
                    locale={locale}
                />
            </Row>
        </>
    );
}



export default Surveys;