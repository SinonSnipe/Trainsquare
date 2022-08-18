import React from 'react';
import PageTitle from './PageTitle';
import ExternalLinksAdd from './ExternalLinksAddOrEdit';
import { useNavigate } from 'react-router-dom';

function ExternalLinksMain() {
    const navigate = useNavigate();

    const getAll = () => {
        navigate(`/externallinks/externallinks`);
    };
    const getById = () => {
        navigate(`/externallinks/externallinksonerecord`);
    };
    const getByUser = () => {
        navigate(`/externallinks/externallinksofuser`);
    };

    return (
        <React.Fragment>
            <PageTitle
                breadCrumbItems={[
                    { label: 'External Links', path: '/externallinks/externallinksmain' },
                    { label: 'Main', path: '/externallinksmain', active: true },
                ]}
                title={'External Links'}
            />

            <main role="main">
                <div
                    className="navbar navbar-expand-md navbar-dark bg-dark"
                    style={{
                        display: 'flex',
                        justifyContent: 'center',
                        height: '75vh',
                    }}>
                    <div
                        className="btn-toolbar justify-content-between"
                        role="toolbar"
                        aria-label="Toolbar with button groups">
                        <div className="btn-group" role="group" aria-label="First group">
                            <div>
                                <button type="button" className="btn btn-primary ms-2 me-2" onClick={getAll}>
                                    Get All
                                </button>
                                <button type="button" className="btn btn-primary ms-2 me-2" onClick={getById}>
                                    Get One
                                </button>
                                <button type="button" className="btn btn-primary ms-2 me-2" onClick={getByUser}>
                                    User Links
                                </button>
                                <ExternalLinksAdd></ExternalLinksAdd>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer className="container">
                <p>External Links</p>
            </footer>
        </React.Fragment>
    );
}

export default ExternalLinksMain;
