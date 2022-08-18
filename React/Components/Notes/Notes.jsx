import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import debug from 'sabio-debug';
import noteService from '../../services/noteService';
import NoteCardTemplate from './NoteCardTemplate';
import toastr from '../../utils/toastr';
import locale from 'rc-pagination/lib/locale/en_US';
import Pagination from 'rc-pagination';
import 'rc-pagination/assets/index.css';
import { Container, Form } from 'react-bootstrap';
import NavCard from '../host/NavCard';
import lookup from '../../services/lookupService';

const _logger = debug.extend('Notes');

function Notes() {
    const navigate = useNavigate();
    const [tagsContent, setTagsContent] = useState([]);
    const [selectedType, setselectedType] = useState('');

    const [notePageData, setNotePageData] = useState({
        notesArr: [],
        noteComponents: [],
        pageIndex: 0,
        current: 1,
        pageSize: 3,
        totalCount: 0,
        totalPages: 0,
    });

    useEffect(() => {
        lookup(['TagsTypes']).then(onLookupSuccess).catch(onLookupError);
    }, []);
    const onLookupSuccess = (response) => {
        _logger(response, 'Tag content');

        setTagsContent((prevState) => {
            let newType = { ...prevState };
            newType = response.item.tagsTypes;
            return newType;
        });
    };
    const onLookupError = (response) => {
        _logger(response, 'error retrieving lookup table');
    };

    useEffect(() => {
        _logger('useEffect for getAll Paginate');
        noteService
            .getPaginate(notePageData.pageIndex, notePageData.pageSize)
            .then(onGetAllSuccess)
            .catch(onGetAllError);
    }, [selectedType]);

    const onGetAllSuccess = (response) => {
        _logger(response, 'getAll');
        let pageIndex = response.item.pageIndex;
        let pageSize = response.item.pageSize;
        let totalCount = response.item.totalCount;
        let arrayOfNotes = response.item.pagedItems;

        setNotePageData((prevState) => {
            const pd = { ...prevState };
            pd.notesArr = arrayOfNotes;
            pd.pageIndex = pageIndex;
            pd.pageSize = pageSize;
            pd.totalCount = totalCount;
            pd.noteComponents = arrayOfNotes.map(mapNotes);

            if (selectedType === '') {
                pd.noteComponents = response.item.pagedItems.map(mapNotes);
            } else {
                const filteredPagedItems = response.item.pagedItems.filter((item) => item.tag.name === selectedType);
                pd.noteComponents = filteredPagedItems.map(mapNotes);
            }

            return pd;
        });
    };

    const onPageChange = (page) => {
        noteService
            .getPaginate(page - 1, notePageData.pageSize)
            .then(onGetAllSuccess)
            .catch(onGetAllError);
    };

    const onGetAllError = (error) => {
        _logger('get All err:', error);
    };

    const deleteRequested = useCallback((myNote, e) => {
        _logger('Logger', myNote.id, { myNote, e });

        const handler = getRemoveSuccessHandler(myNote.id);

        noteService.remove(myNote.id).then(handler).catch(onRemoveError);
    }, []);

    const getRemoveSuccessHandler = (idToBeDeleted) => {
        return () => {
            _logger('onRemoveSuccess', idToBeDeleted);

            setNotePageData((prevState) => {
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
                    pd.noteComponents = pd.notesArr.map(mapNotes);
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
    const addNoteLocally = () => {
        _logger('add Note');
        navigate(`/notes/new`);
    };

    const mapNotes = (aNote) => {
        return <NoteCardTemplate notes={aNote} key={aNote.id} onDeleteNoteClicked={deleteRequested} />;
    };

    const mapType = (type, index) => <option key={`${type}_${index}`}>{type.name}</option>;
    _logger(mapType);

    const handleFilterChange = (e) => {
        e.preventDefault();
        const currentType = e.target.value;
        setselectedType(currentType);
    };

    return (
        <Container className="fluid">
            <NavCard />
            <div className="row">
                <div className="col mb-3 mx-1">
                    <h3 className="mb-1 mx-1">WorkShop Notes</h3>
                    <button className="btn btn-primary mb-2 back rounded-pill shadow" onClick={addNoteLocally}>
                        <i className="mdi mdi-plus"></i>
                        Add Note
                    </button>

                    <form className="form-inline my-2 my-md-0">
                        <div className="form-group">
                            <label htmlFor="StatusId">Filter Notes By Tag Type</label>
                            <Form.Select
                                aria-label="Default select example"
                                name="typeId"
                                className="form-control"
                                value={selectedType}
                                onChange={handleFilterChange}>
                                <option value="">Select Type of Note</option>
                                {tagsContent?.map(mapType)}
                            </Form.Select>
                        </div>
                    </form>
                </div>
            </div>

            <div className="row">{notePageData.noteComponents}</div>
            <div className="col mb-3 mx-2 px-2 my-4">
                <div>
                    <Pagination
                        onChange={onPageChange}
                        total={notePageData.totalCount}
                        pageSize={notePageData.pageSize}
                        current={notePageData.pageIndex + 1}
                        locale={locale}
                    />
                </div>
            </div>
        </Container>
    );
}
export default Notes;
