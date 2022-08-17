import React, { useState } from 'react';
import debug from 'sabio-debug';
import { Card, Row, Col, Modal, Button } from 'react-bootstrap';
import EditModal from './EditModal';
import PropTypes from 'prop-types';
import './css/blogs.css';
import * as blogAdminService from "../../../services/blogAdminService";
import toastr from "../../../utils/toastr";
const _logger = debug.extend('Blog Card');

function BlogCard(props) {
    const [post, setPost] = useState(props.currentPost);
    const [show, setShow] = useState(false);
    
    const handleShow = () => setShow(true);
    const handleClose = () => setShow(false);

    const [modal, setModal] = useState(false);
    const toggle = () => {
        setModal(!modal);
    };

    const openModalWithHeaderClass = () => {
        toggle();
    };

    const handleDeleteLocally = (e) => {
        e.preventDefault();
        props.onDelete(props.currentPost, e);
        _logger('Delete Post', e);
    };

    const updatePost = (e) => {
        e.preventDefault();
        
        const data = {
            typeId: post.type.id,
            title: post.title,
            subject: post.subject,
            content: post.content,
            isPublished: post.isPublished,
            imageUrl: post.imageUrl,
            datePublished: new Date(),
            statusId: post.status.id,
            id: post.id
        }
        blogAdminService
            .update(data)
            .then(onEditSuccess)
            .catch(onEditError)
        
        toastr.success("You just edit your Post, awesome!");

        window.location.replace('/blogsadmin')
    };

    const onEditSuccess = (response) => {
        _logger(response, 'successsfully edit the post');   
    };

    const onEditError = (response) => {
        _logger(response, 'error when editing a new post');
        toastr.error('Post could not be updated');
    };

    return (
        <React.Fragment>
            <div>
                <Card data-type={post.type.name}>
                    <Row className="g-0 align-items-center">
                        <Col md={4}>
                            <Card.Img className="img-fluid" src={post.imageUrl} alt="post" />
                        </Col>
                        <Col md={8}>
                            <Card.Body>
                                <Card.Title as="h3" className="line">{post.title}</Card.Title>
                                <Card.Text>{post.content}</Card.Text>
                                <Card.Text>
                                    <small className="text-muted">Published on {post.datePublished}</small>
                                </Card.Text>                           
                                <div>
                                    <button
                                        type="submit"
                                        className="btn btn-warning ms-2 me-2"
                                        onClick={handleShow}>
                                        Edit
                                    </button>
                                    <button type="button" className="btn btn-danger ms-1 me-1" onClick={openModalWithHeaderClass}>
                                        Delete
                                    </button>

                                    <Modal show={modal} onHide={toggle}>
                                        <Modal.Header
                                            onHide={toggle}
                                            closeButton
                                        >
                                        </Modal.Header>
                                        <Modal.Body>
                                            <h5 className="mt-0"> Are you sure you want to delete this Post?</h5>
                                        </Modal.Body>
                                        <Modal.Footer>
                                            <Button variant="light" onClick={toggle}>
                                                Close
                                            </Button>{' '}
                                            <Button variant="danger" onClick={handleDeleteLocally}>
                                                Delete Post
                                            </Button>
                                        </Modal.Footer>
                                    </Modal>
                                </div>
                            </Card.Body>
                        </Col>
                    </Row>
                </Card>
                <Modal show={show} onHide={handleClose} aria-labelledby="contained-modal-title-vcenter" centered>
                    <Modal.Header closeButton>
                        <Modal.Title>Edit Your Post</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <EditModal thePost={post} setPost={setPost} />
                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            Close
                        </Button>
                        <Button variant="primary" type="submit" onClick={updatePost} >
                            Save Changes
                        </Button>
                    </Modal.Footer>
                </Modal>
            </div>
        </React.Fragment>
    );
}

BlogCard.propTypes = {
    currentPost: PropTypes.shape({
        id: PropTypes.number,
        typeId:PropTypes.string,
        title: PropTypes.string,
        subject:PropTypes.string,
        content: PropTypes.string,
        isPublished:PropTypes.bool,
        imageUrl: PropTypes.string,
        datePublished: PropTypes.string,
        statusId: PropTypes.string
    }),
    onDelete: PropTypes.func.isRequired,
};

export default BlogCard;