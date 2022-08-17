import React, { useCallback, useState, useEffect } from 'react';
import debug from 'sabio-debug';
import commentService from '../../services/commentService';
import CommentTemplate from '../comments/CommentTemplate';
import toastr from '../../utils/toastr';
import locale from 'rc-pagination/lib/locale/en_US';
import Pagination from 'rc-pagination';

const _logger = debug.extend('CommentsCreatedBy');

function CommentsCreatedBy() {
    const [commentsData, setCommentsData] = useState({
        subject: '',
        text: '',
        parentId: '',
        entityType: '',
        entityId: '',
        isDeleted: false,
        arrayOfComments: [],
        commentComponents: [],
    });

    const [pageData, setPageData] = useState({
        pageIndex: 0,
        current: 1,
        pageSize: 5,
        totalCount: 0,
        totalPages: 0,
    });

    useEffect(() => {
        _logger('useEffect firing');
        commentService
            .getByCurrent(pageData.pageIndex, pageData.pageSize)
            .then(onRetrieveCommentsSuccess)
            .catch(onRetrieveCommentsError);
    }, []);

    const onDeleteRequest = useCallback((myComment, eObj) => {
        _logger(myComment.id, { myComment, eObj });

        const handler = getDeleteSuccessHandler(myComment.id);

        commentService.remove(myComment.id).then(handler).catch(onDeleteError);
    }, []);

    const getDeleteSuccessHandler = (idToBeDeleted) => {
        toastr.success('Comment successfully deleted');
        _logger('getDeleteSuccessHandler', idToBeDeleted);
        return () => {
            _logger('onDeleteSuccess', idToBeDeleted);

            setCommentsData((prevState) => {
                const commentsData = { ...prevState };
                commentsData.arrayOfComments = [...commentsData.arrayOfComments];

                const indexOf = commentsData.arrayOfComments.findIndex((myComment) => myComment.id === idToBeDeleted);

                if (indexOf >= 0) {
                    commentsData.arrayOfComments.splice(indexOf, 1);
                    commentsData.commentComponents = commentsData.arrayOfComments.map(mapComments);
                }

                return commentsData;
            });
        };
    };

    const mapComments = (aComment) => {
        _logger('mapping comments', aComment);
        return (
            <CommentTemplate
                comment={aComment}
                key={'ListCommentCreatedBy' + aComment.id}
                onCommentClicked={onDeleteRequest}></CommentTemplate>
        );
    };

    const onRetrieveCommentsSuccess = (data) => {
        _logger(data);
        let arrayOfComms = data.item.pagedItems;
        const commentCount = data.item.totalCount;
        const commentPages = data.item.totalPages;
        const current = data.item.pageIndex + 1;
        _logger(arrayOfComms, commentCount, commentPages);

        setCommentsData((prevState) => {
            const commentsData = { ...prevState };
            commentsData.arrayOfComments = arrayOfComms;
            commentsData.commentComponents = arrayOfComms.map(mapComments);
            return commentsData;
        });

        setPageData((prevState) => {
            const pageData = { ...prevState };
            pageData.totalCount = commentCount;
            pageData.totalPages = commentPages;
            pageData.current = current;
            _logger(pageData);
            return pageData;
        });
    };

    const pageChange = (page) => {
        commentService
            .getByCurrent(page - 1, pageData.pageSize)
            .then(onRetrieveCommentsSuccess)
            .catch(onRetrieveCommentsError);
    };

    const onRetrieveCommentsError = (error) => {
        _logger(error);
    };

    const onDeleteError = (error) => {
        _logger('delete was not successful', error);
    };

    return (
        <div className="row">
            <div className="col"></div>
            <div className="col-6">
                <Pagination
                    className="mb-1"
                    onChange={pageChange}
                    pageSize={pageData.pageSize}
                    current={pageData.current}
                    total={pageData.totalCount}
                    locale={locale}
                />
                <div className="col-10 mt-2">{commentsData?.commentComponents}</div>
                <Pagination
                    className="mb-1"
                    onChange={pageChange}
                    pageSize={pageData.pageSize}
                    current={pageData.current}
                    total={pageData.totalCount}
                    locale={locale}
                />
            </div>
            <div className="col"></div>
        </div>
    );
}

export default CommentsCreatedBy;
