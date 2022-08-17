import React, {useState, useEffect } from "react";
import PropTypes from 'prop-types';
import {Formik, Form, Field, ErrorMessage} from "formik";
import blogSchema from "../../../schema/blogAdminSchema";
import * as blogAdminService from "../../../services/blogAdminService";
import lookup from "../../../services/lookupService";
import toastr from "../../../utils/toastr";
import debug from "sabio-debug";
const _logger = debug.extend("adding new blog");


const EditModal =({thePost, setPost}) => {

    const [postFormData, setPostFormData] = useState({
        typeId: thePost.type.id,
        typeName: thePost.type.name,
        title: thePost.title,
        subject: thePost.subject,
        content: thePost.content,
        isPublished: thePost.isPublished,
        imageUrl: thePost.imageUrl,
        datePublished: thePost.datePublished,
        statusId: thePost.status.id,
        statusName: thePost.status.name,
    });

    const [typeContent, setTypeContent] = useState ([]);
    const [statusContent, setStatusContent] = useState ([]);

    useEffect(() => {
        lookup(["BlogTypes" , "BlogStatus"])
        .then(onLookupSuccess)
        .catch(onLookupError);
    },[]);

    const onLookupSuccess = (response) => {
        _logger(response, "Lookup table works")

        setTypeContent((prevState) => {
            let newType = {...prevState};
            newType = response.item.blogTypes;

            return newType;
        });

        setStatusContent((prevState) => {
            let newType = {...prevState};
            newType = response.item.blogStatus;

            return newType;
        });

    };

    const onLookupError = (response) => {
        _logger(response, "error retrieving lookup table")
    };

    const mapType = (type, index) => (
        <option 
         value={type.id}
         key={`${type}_${index}`}
        >{type.name}
        </option>
    );
    _logger(mapType);

    const onFormChange = (event) => {
        _logger('onChange', { syntheticEvent: event });

        const target = event.target;
        const newFieldValue = target.type === "checkbox" ? target.checked : target.value;
        const nameOfField = target.name; 
        setPostFormData((prevState) => {
            _logger('updater onChange');

            const newPostObject = {
                ...prevState,
            };
            newPostObject[nameOfField] = newFieldValue;
            return newPostObject;
        });

        setPost((prevState) => {

            const newPostObject = {
                ...prevState,
            };
            newPostObject[nameOfField] = newFieldValue;
            return newPostObject;
        });
    };

    const handleSubmit = (values) => {
        _logger(values, "success submit");

        blogAdminService
            .update(values)
            .then(onEditSuccess)
            .catch(onEditError)

        toastr.success("You just edit your Post, awesome!");
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
            <Formik 
                        enableReinitialize={true} 
                        initialValues={postFormData}
                        onSubmit={handleSubmit}
                        validationSchema={blogSchema}
                    >
                        <Form >
                            <div className="form-group">
                                <label htmlFor="typeId">Type</label> 
                                <Field
                                    className="form-control mb-3" 
                                    component="select"
                                    name="typeId"
                                    id="typeId"
                                    value={postFormData.typeId}
                                    onChange={onFormChange}
                                    >
                                    <option value={postFormData.typeId}>{postFormData.typeName}</option>
                                    {typeContent.map(mapType)}
                                </Field>  
                            </div>
                            <div className="form-group">
                                <label htmlFor="statusId">Status</label>
                                <Field
                                    className="form-control mb-3" 
                                    component="select"
                                    name="statusId"
                                    // id="statusId"
                                    // value={postFormData.statusId}
                                    onChange={onFormChange}>
                                    <option value={postFormData.statusId}>{postFormData.statusName}</option>
                                    {statusContent.map(mapType)}    
                                </Field>
                            </div>
                            <div className="form-group">
                                <label htmlFor="title">Title</label> 
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="title"
                                    id="title"
                                    value={postFormData.title}
                                    onChange={onFormChange}>
                                </Field>
                            </div>
                            <div className="form-group">
                                <label htmlFor="subject">Subject</label>        
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="subject"
                                    id="subject"
                                    value={postFormData.subject}
                                    onChange={onFormChange}>
                                </Field>
                            </div>
                            <div className="form-group">
                                <label htmlFor="content">Content</label>        
                                <Field
                                    className="form-control mb-3"
                                    component="textarea"
                                    name="content"
                                    id="content"
                                    value={postFormData.content}
                                    onChange={onFormChange}>
                                </Field>
                                <ErrorMessage name="content"  component="div" className="has-error" />
                            </div>
                            <div className="form-group">
                                <label htmlFor="imageUrl">Edit Image Url</label>        
                                <Field
                                    className="form-control mb-3"
                                    type="text"
                                    name="imageUrl"
                                    id="imageUrl"
                                    value={postFormData.imageUrl}
                                    onChange={onFormChange}>
                                </Field>
                            </div>
                            <div className="form-group">
                                <label htmlFor="datePublished">EditPublish Date</label>        
                                <Field
                                    className="form-control mb-3"
                                    type="date"
                                    name="datePublished"
                                    id="datePublished"
                                    value={postFormData.datePublished}
                                    onChange={onFormChange}>
                                </Field>
                            </div>
                            <div className="form-check">                          
                                <Field
                                    className="form-check-input"
                                    type="checkbox"
                                    name="isPublished"
                                    id="isPublished"
                                    value={true}
                                    checked={postFormData.isPublished}
                                    onChange={onFormChange}>
                                </Field>
                                <label htmlFor="isPublished" className="form-check-label" >Will this Post be publish yet?</label>
                            </div>                              
                        </Form> 
                    </Formik>
        </React.Fragment>
    );    
};

EditModal.propTypes = {
    thePost: PropTypes.shape({
        id: PropTypes.number,
        type: PropTypes.shape({
            id: PropTypes.number,
            name: PropTypes.string
        }),       
        title: PropTypes.string,
        subject:PropTypes.string,
        content: PropTypes.string,
        isPublished:PropTypes.bool,
        imageUrl: PropTypes.string,
        datePublished: PropTypes.string,
        status: PropTypes.shape({
            id: PropTypes.number,
            name: PropTypes.string
        })
    }),
    setPost: PropTypes.func,
 
};

export default EditModal;