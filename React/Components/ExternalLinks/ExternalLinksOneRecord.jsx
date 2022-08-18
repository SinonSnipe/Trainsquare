import React, { useState } from 'react';
import * as externalLinksService from '../../services/externalLinksService.js';
import toastr from 'toastr';
import debug from 'sabio-debug';
import { number } from 'prop-types';
import PageTitle from './PageTitle';
import { Row, Col, Card, Table } from 'react-bootstrap';
import { Link } from 'react-router-dom';

const _logger = debug.extend('ExternalLinksOneRecord');

_logger('ExternalLinksOneRecord');

function ExternalLinksOneRecord() {
    const [externalLinkObject, setExternalLinkObject] = useState([]);
    const [primaryKey, setPrimaryKey] = useState({ primaryKeyId: number });

    const onFormFieldChange = (e) => {
        _logger('onChange', { syntheticEvent: e });
        const target = e.target;
        const value = target.value;
        const property = target.name;
        setPrimaryKey((prevState) => {
            const newPageInfo = {
                ...prevState,
            };
            newPageInfo[property] = value;
            return newPageInfo;
        });
    };

    const onGetById = (e) => {
        e.preventDefault();
        _logger('primaryKey.primaryKeyId: ', primaryKey.primaryKeyId);
        externalLinksService
            .GetOneExternalLink(primaryKey.primaryKeyId)
            .then(onGetOneExternalLinkSuccess)
            .catch(onGetOneExternalLinkError);
    };

    const onGetOneExternalLinkSuccess = (response) => {
        _logger(response, 'just ran: onGetOneExternalLinkSuccess');
        const arrayForReceived = [];
        arrayForReceived.push(response.data.item);
        toastr.success(`Success getting one ExternalLink by ID`);
        setExternalLinkObject((prevState) => {
            let newExternalLink = {
                ...prevState,
            };
            newExternalLink = arrayForReceived;
            return newExternalLink;
        });
    };
    const onGetOneExternalLinkError = (error) => {
        _logger(error, 'just had: onGetOneExternalLinkError');
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
                    { label: 'Get by ID', path: '/externallinksonerecord', active: true },
                ]}
                title={'External Links'}
            />
            <div className="bg-dark">
                <br></br>
                <div className="container">
                    <h4>Retrieve Record by Primary ID</h4>
                </div>
                <div className="mx-auto mt-4" style={{ width: 400 }}>
                    <form>
                        <div className="form-group w-25 mb-2">
                            <label htmlFor="primaryKeyId">Primary Key ID</label>
                            <input
                                type="text"
                                className="form-control"
                                id="primaryKeyId"
                                name="primaryKeyId"
                                placeholder="primary key id"
                                value={primaryKey.primaryKeyId}
                                onChange={onFormFieldChange}
                            />
                        </div>
                        <button type="submit" className="btn btn-primary" id="getByIdButton" onClick={onGetById}>
                            Get One Record
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
                                        One Link by Record ID -{' '}
                                        <span className="text-muted font-11">Update or Delete</span>
                                    </h4>
                                    <br></br>

                                    <Table className="mb-0" bordered>
                                        <thead>
                                            <tr>
                                                <th>Record</th>
                                                <th>User ID</th>
                                                <th>Entity</th>
                                                <th>Business#</th>
                                                <th>Link Type</th>
                                                <th>Link</th>
                                                <th className="text-center">Delete</th>
                                                <th className="text-center">Update</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {externalLinkObject.map((externalLinksList, index) => {
                                                return (
                                                    <tr key={index}>
                                                        <th scope="row">{externalLinksList.id}</th>
                                                        <td>{externalLinksList.userBasic.id}</td>
                                                        <td>{externalLinksList.entityBusinessType}</td>
                                                        <td>{externalLinksList.entityId}</td>
                                                        <td>{externalLinksList.urlType}</td>
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

export default ExternalLinksOneRecord;
