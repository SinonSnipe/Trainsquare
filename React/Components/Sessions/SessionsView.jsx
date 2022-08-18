import React, { useEffect, useState, useCallback } from 'react';
import sessionFunctions from '../../services/sessionService';
import toastr from '../../utils/toastr';
import { useLocation, useNavigate } from 'react-router-dom';
import PDFButton from '../pdf/PDFButton';
import EmailPdf from '../pdf/EmailPdf';
import PropTypes from 'prop-types';
import Table from '../common-components/Table';
import { Modal } from 'react-bootstrap';
import './css/session-button-icons.css';
import debug from 'sabio-debug';
import { format } from 'date-fns';
import AddNoteBtn from './AddNoteBtn';
import sessionNoteService from '../../services/sessionNoteService';
import NoteTemplate from './NoteTemplate';
import Pagination from 'rc-pagination';
import 'rc-pagination/assets/index.css';
import locale from 'rc-pagination/lib/locale/en_US';

const _logger = debug.extend('Session');

function SessionsView(props) {
    const [sessions, setSessions] = useState({
        seshArray: [],
        sessionIds: [],
    });

    const [showModal, setModal] = useState(false);

    const [formInfo, setFormInfo] = useState({
        workShopId: '',
        openSlots: '',
        totalSlots: '',
        date: '',
        startTime: '',
        endTime: '',
        id: '',
    });

    const [workShopInfo, setWorkShop] = useState({
        workShopId: '',
        host: '',
        workShopName: '',
        summary: '',
        shortDescription: '',
        imageUrl: '',
        numberOfSessions: '',
        startTime: '',
        endTime: '',
        externalSiteUrl: '',
    });

    const user = props.currentUser;
    const location = useLocation();

    const authorizationCheck = (id) => {
        if (user.roles.some((role) => role === 'Admin')) {
            _logger('Admin', id);
            return true;
        } else if (
            user.roles.some((role) => {
                _logger(id);
                return role === 'Host';
            }) &&
            user.id === id
        ) {
            _logger('Host', id);
            return true;
        } else {
            return false;
        }
    };

    const editAndDelete = ({ row }) => {
        return (
            <div className="row">
                <i className="col-lg-2 mdi mdi-pencil session-button" onClick={() => onEdit(row.original)} />
                <i
                    className="col-lg-2 mdi mdi-trash-can session-button"
                    onClick={() => deleteConfirmation(row.original)}
                />
            </div>
        );
    };

    const columns = [
        {
            Header: 'Total Slots',
            accessor: 'totalSlots',
            sort: true,
        },
        {
            Header: 'Open Slots',
            accessor: 'openSlots',
            sort: true,
        },
        {
            Header: 'Date',
            accessor: 'date',
            sort: true,
        },
        {
            Header: 'Start Time',
            accessor: 'startTime',
            sort: true,
        },
        {
            Header: 'End Time',
            accessor: 'endTime',
            sort: true,
        },
        {
            Header: '',
            accessor: 'edit',
            sort: false,
            classes: 'table-action',
            Cell: authorizationCheck(workShopInfo.host.id) ? editAndDelete : '',
        },
    ];

    useEffect(() => {
        const workshop = location.state?.payload;
        if (workshop) {
            _logger('workshop', workshop);
            setWorkShop(workshop);
            setFormInfo((prevState) => {
                return {
                    ...prevState,
                    workShopId: workshop.id,
                    dateStart: workshop.dateStart,
                    dateEnd: workshop.dateEnd,
                };
            });
            if (workshop.id) {
                sessionFunctions.getByWorkShopId(workshop.id).then(onWorkShopSuccess).catch(onWorkShopError);
            }
        }
    }, []);

    const onWorkShopSuccess = (response) => {
        let temp = response.data.items;
        for (let i = 0; i < temp.length; i++) {
            const element = temp[i];
            temp[i].startData = element.startTime;
            temp[i].endData = element.endTime;
            temp[i].startTime = timeSpanToLocaleTime(element.startTime);
            temp[i].endTime = timeSpanToLocaleTime(element.endTime);
            temp[i].date = format(new Date(element.date), 'dd MMM yyyy');
        }

        setSessions(() => {
            return { seshArray: temp };
        });
    };
    const onWorkShopError = () => {
        toastr.error('Unable to load sessions or no sessions have been added yet.');
    };

    const navigate = useNavigate();

    const onAddBtn = () => {
        if (authorizationCheck(workShopInfo.host.id)) {
            const stateForTransport = {
                type: 'create',
                payload: {
                    dateStart: formInfo.dateStart,
                    dateEnd: formInfo.dateEnd,
                    workShopId: formInfo.workShopId,
                },
            };
            navigate(`/workshops/${workShopInfo.id}/sessions/create`, { state: stateForTransport });
        } else {
            toastr.error('Unauthorized access.');
        }
    };

    const onDelete = () => {
        if (authorizationCheck(sessions.sessionIds.host.id)) {
            const deleteHandler = onDeleteSuccess(sessions.sessionIds.id);
            sessionFunctions.remove(sessions.sessionIds.id).then(deleteHandler).catch(onDeleteError);
        } else {
            toastr.error('Unauthorized access.');
        }
    };

    const onDeleteSuccess = (id) => {
        return () => {
            setSessions((prevState) => {
                const temp = { ...prevState };
                temp.seshArray = [...prevState.seshArray];

                const indOf = temp.seshArray.findIndex((session) => {
                    if (session.id === id) {
                        return true;
                    } else {
                        return false;
                    }
                });

                if (indOf >= 0) {
                    temp.seshArray.splice(indOf, 1);
                }
                return temp;
            });
            toastr.success('Successfully deleted session!');
        };
    };

    const onDeleteError = () => {
        toastr.error('Unable to delete session...');
    };

    const onEdit = (session) => {
        if (authorizationCheck(session.host.id)) {
            _logger(session);
            const stateForTransport = {
                type: 'edit',
                payload: {
                    session: {
                        totalSlots: session.totalSlots,
                        openSlots: session.openSlots,
                        id: session.id,
                        date: new Date(session.date),
                        startTime: session.startData,
                        endTime: session.endData,
                        workShopId: session.workShopId,
                    },
                    workshopDates: {
                        workShopId: session.workShopId,
                        dateEnd: session.dateEnd,
                        dateStart: session.dateStart,
                    },
                },
            };
            navigate(`/workshops/${session.workShopId}/sessions/edit`, { state: stateForTransport });
        } else {
            toastr.error('Unauthorized access.');
        }
    };

    const timeSpanToLocaleTime = (time) => {
        //converts military time to standard
        let temp = new Date();
        temp.setHours(time.slice(0, 2), time.slice(3, 5), time.slice(6));
        return temp.toLocaleTimeString();
    };

    const deleteConfirmation = (session) => {
        setModal(!showModal);
        setSessions((prevState) => {
            return { ...prevState, sessionIds: { id: session.id, host: session.host } };
        });
    };

    // add note  button code

    const [sessionNoteData, setSessionNoteData] = useState({
        notesArr: [],
        noteComponents: [],
        pageIndex: 0,
        current: 1,
        pageSize: 3,
        totalCount: 0,
        totalPages: 0,
    });

    useEffect(() => {
        _logger('useEffect for getAll Paginate');
        sessionNoteService
            .getPaginate(sessionNoteData.pageIndex, sessionNoteData.pageSize)
            .then(onGetAllSuccess)
            .catch(onGetAllError);
    }, []);

    const mapSessionNotes = (aSessionNote) => {
        return <NoteTemplate noted={aSessionNote} key={aSessionNote.id} onDeleteNoteClicked={deleteRequested} />;
    };

    const deleteRequested = useCallback((myNote, e) => {
        _logger('Logger', myNote.id, { myNote, e });

        const handler = getRemoveSuccessHandler(myNote.id);

        sessionNoteService.remove(myNote.id).then(handler).catch(onRemoveError);
    }, []);

    const getRemoveSuccessHandler = (idToBeDeleted) => {
        return () => {
            _logger('onRemoveSuccess', idToBeDeleted);

            setSessionNoteData((prevState) => {
                const pd = { ...prevState };
                pd.notesArr = [...pd.notesArr];

                const idxOf = pd.notesArr.findIndex((note) => {
                    let result = false;
                    if (note.id === idToBeDeleted) {
                        result = true;
                    }
                    return result;
                });

                if (idxOf >= 0) {
                    pd.notesArr.splice(idxOf, 1);
                    pd.noteComponents = pd.notesArr.map(mapSessionNotes);
                }
                return pd;
            });
            toastr.success('Note Successfully Deleted');
            window.location.reload();
        };
    };

    const onRemoveError = (error) => {
        toastr.error('Unable to Delete Note');
        _logger('remove note err:', error);
    };

    const onGetAllSuccess = (response) => {
        _logger(response, 'getAllNotes');
        let pageIndex = response.item.pageIndex;
        let pageSize = response.item.pageSize;
        let totalCount = response.item.totalCount;
        let arrayOfNotes = response.item.pagedItems;

        setSessionNoteData((prevState) => {
            const pd = { ...prevState };
            pd.notesArr = arrayOfNotes;
            pd.pageIndex = pageIndex;
            pd.pageSize = pageSize;
            pd.totalCount = totalCount;
            pd.noteComponents = arrayOfNotes.map(mapSessionNotes);

            return pd;
        });
    };

    const onGetAllError = (error) => {
        _logger('get All err:', error);
    };

    const onPageChange = (page) => {
        sessionNoteService
            .getPaginate(page - 1, sessionNoteData.pageSize)
            .then(onGetAllSuccess)
            .catch(onGetAllError);
    };

    return (
        <React.Fragment>
            <h1>{workShopInfo.workShopName}</h1>
            <Modal show={showModal} onHide={() => setModal(!showModal)} size="sm">
                <div className="modal-filled bg-danger">
                    <Modal.Body className="p-4">
                        <div className="text-center">Are you sure you want to delete this session?</div>
                        <div className="row">
                            <div className="col mt-2">
                                <button type="btn" className="btn btn-light" onClick={() => setModal(!showModal)}>
                                    Cancel
                                </button>
                            </div>
                            <div className="col mt-2">
                                <button type="btn" className="btn btn-dark" onClick={onDelete}>
                                    Delete
                                </button>
                            </div>
                        </div>
                    </Modal.Body>
                </div>
            </Modal>
            <div
                aria-live="polite"
                aria-atomic="true"
                className="d-flex justify-content-end align-items-center position-relative"></div>
            <div className="row">
                <div className="col-lg-5">
                    <div className="card">
                        <div className="card-body">
                            <img className="img-fluid" src={workShopInfo.imageUrl} alt="" />
                            <h3>{workShopInfo.summary}</h3>
                            <p>{workShopInfo.shortDescription}</p>
                            <a href={workShopInfo.externalSiteUrl}>For More Info...</a>
                            <AddNoteBtn />
                        </div>
                    </div>
                </div>
                <div className="col">
                    <div className="card">
                        <div className="card-body">
                            <div className="row">
                                <div className="col-lg-1">
                                    <PDFButton type="session" size="lg" data={sessions.seshArray} />
                                </div>
                                <div className="col-lg-8">
                                    <EmailPdf type="session" size="lg" data={sessions.seshArray} />
                                </div>
                                {authorizationCheck(workShopInfo.host.id) && (
                                    <div className="col">
                                        <button
                                            onClick={onAddBtn}
                                            type="button"
                                            className="mt-2 btn-lg btn btn-primary">
                                            Create
                                        </button>
                                    </div>
                                )}
                            </div>
                            <Table
                                columns={columns}
                                data={sessions?.seshArray}
                                pageSize={5}
                                isSortable={true}
                                pagination={false}
                                isSelectable={false}
                                isSearchable={false}
                                theadClass="table-dark"
                                searchBoxClass="mb-2"
                            />
                        </div>
                    </div>
                </div>
            </div>

            <div className="row">{sessionNoteData.noteComponents}</div>
            <div className="col mb-3 mx-2 px-2 my-4">
                <div>
                    <Pagination
                        onChange={onPageChange}
                        total={sessionNoteData.totalCount}
                        pageSize={sessionNoteData.pageSize}
                        current={sessionNoteData.pageIndex + 1}
                        locale={locale}
                    />
                </div>
            </div>
        </React.Fragment>
    );
}

SessionsView.propTypes = {
    currentUser: PropTypes.shape({
        email: PropTypes.string,
        profilePic: PropTypes.string,
        id: PropTypes.number.isRequired,
        roles: PropTypes.arrayOf(PropTypes.string).isRequired,
    }),
};

export default SessionsView;
