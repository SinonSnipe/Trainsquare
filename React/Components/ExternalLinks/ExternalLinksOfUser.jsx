import React, { useState } from 'react';
import * as externalLinksService from '../../services/externalLinksService.js';
import toastr from 'toastr';
import debug from 'sabio-debug';
import { number } from 'prop-types';
import { Row, Col, Card, Table } from 'react-bootstrap';
import PageTitle from './PageTitle';
import { Link } from 'react-router-dom';

const _logger = debug.extend('ExternalLinksOfUser');

_logger('ExternalLinksOfUser');

function ExternalLinksOfUser() {
    const [externalLinksList, setExternalLinksList] = useState([]);
    const [querySpecs, setQuerySpecs] = useState({
        pageIndex: 0,
        pageSize: 25,
        userId: number,
    });

    const onFormFieldChange = (e) => {
        _logger('onChange', { syntheticEvent: e });
        const target = e.target;
        const value = target.value;
        const property = target.name;
        setQuerySpecs((prevState) => {
            const newQuerySpecs = {
                ...prevState,
            };
            newQuerySpecs[property] = value;
            return newQuerySpecs;
        });
    };

    const onGetLinksByUserClick = (e) => {
        e.preventDefault();
        externalLinksService
            .PaginateCreatedBy(querySpecs.pageIndex, querySpecs.pageSize, querySpecs.userId)
            .then(onPaginateByUserSuccess)
            .catch(onPaginateByUserError);
    };

    const onPaginateByUserSuccess = (response) => {
        _logger(response, 'just ran: onPaginateByUserSuccess');
        const receivedArray = response.data.item.pagedItems;
        toastr.success(`Success getting paginated ExternalLinks list`);
        setExternalLinksList((prevState) => {
            let newExternalLinksList = {
                ...prevState,
            };
            newExternalLinksList = receivedArray;
            return newExternalLinksList;
        });
    };
    const onPaginateByUserError = (error) => {
        _logger(error, 'just had: onPaginateByUserError');
        const errorData = error.data;
        toastr.error(`Retrieval Request Error: ${errorData}`);
    };

    const onDeleteClick = (e) => {
        e.preventDefault();
        externalLinksService
            .DeleteExternalLink(e.target.id)
            .then(onDeleteExternalLinkSuccess)
            .catch(onDeleteExternalLinkError);
    };
    const onDeleteExternalLinkSuccess = () => {
        toastr.success('Delete-Request Success');
    };
    const onDeleteExternalLinkError = () => {
        toastr.error('Delete-Request Error');
    };

    return (
        <React.Fragment>
            <PageTitle
                breadCrumbItems={[
                    { label: 'External Links', path: '/externallinks/externallinksmain' },
                    { label: 'Get By User', path: '/externallinksofuser', active: true },
                ]}
                title={'External Links'}
            />
            <div className="bg-dark">
                <br></br>
                <div className="container">
                    <h4>Retrieve User&apos;s Links</h4>
                </div>
                <div className="mx-auto" style={{ width: 400 }}>
                    <form>
                        <div className="form-group w-25 mb-2">
                            <label htmlFor="userId">User Numeric ID</label>
                            <input
                                type="text"
                                className="form-control"
                                id="userId"
                                name="userId"
                                placeholder="numeric ID"
                                value={querySpecs.userId}
                                onChange={onFormFieldChange}
                            />
                        </div>
                        <button
                            type="submit"
                            className="btn btn-primary"
                            id="getLinksByUserButton"
                            onClick={onGetLinksByUserClick}>
                            One User&apos;s Links
                        </button>
                    </form>
                </div>
                <br></br>
                <div className="col-md-9 mx-auto">
                    <Row>
                        <Col>
                            <Card
                                style={{
                                    height: '75vh',
                                    overflow: 'scroll',
                                    whitepace: 'nowrap',
                                }}>
                                <Card.Body>
                                    <h4 className="header-title">
                                        User&apos;s Records -{' '}
                                        <span className="text-muted font-11">Update or Delete</span>
                                    </h4>
                                    <br></br>

                                    <Table className="mb-0" bordered>
                                        <thead>
                                            <tr>
                                                <th>Record</th>
                                                <th>User ID</th>
                                                <th>Link</th>
                                                <th className="text-center">Delete</th>
                                                <th className="text-center">Update</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {externalLinksList.map((externalLinksList, index) => {
                                                return (
                                                    <tr key={index}>
                                                        <th scope="row">{externalLinksList.id}</th>
                                                        <td>{externalLinksList.userBasic.id}</td>
                                                        <td>{externalLinksList.url}</td>
                                                        <td className="table-action text-center">
                                                            <button
                                                                className="btn bg-white btn-sm m-1 text-muted"
                                                                id={externalLinksList.id}
                                                                onClick={onDeleteClick}>
                                                                Delete
                                                            </button>
                                                        </td>
                                                        <td className="table-action text-center">
                                                            <Link
                                                                to="/externallinks/externallinksmain"
                                                                className="btn bg-white btn-sm m-1 text-muted"
                                                                id={externalLinksList.id}>
                                                                Update
                                                            </Link>
                                                        </td>
                                                    </tr>
                                                );
                                            })}
                                        </tbody>
                                    </Table>
                                </Card.Body>
                            </Card>
                        </Col>
                    </Row>
                </div>
                <br></br>
                <br></br>
                <br></br>
            </div>
        </React.Fragment>
    );
}

export default ExternalLinksOfUser;
