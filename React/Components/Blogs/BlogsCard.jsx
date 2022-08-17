import React from 'react';
import debug from 'sabio-debug';
import PropTypes from 'prop-types';
import './blog.css'

const BlogsCard =(props) => {
    const _logger = debug.extend('BlogsCard');
    _logger(props);

    const onReadMoreClick = (e) =>
    {
        e.preventDefault();
        props.onButtonClicked(props.blogs, e)
    }

    const readMoreButton = {
        padding: '12px 20px',
        border: '5px',
        borderRadius: '2px',
        fontSize: '20px',
        cursor: 'pointer',
        transition: '.3s background',
        '&:hover': {
            background: '#40d9ff',
        },
    };
    
    return (
        <React.Fragment>           
        <div className="col-md-6 col-lg-3 d-flex align-items-stretch ">
            <div className="card border" >
                <img
                    className=" blog-card card-img-top rounded-corners "
                    src={props.blogs.imageUrl}
                    alt={props.blogs.id}
                />
                <div className="card-body">
                    <h3 className="card-title" >{props.blogs.title}</h3>
                    <p className="card-content">{props.blogs.content}</p>
                </div>

                <div className="card-footer">
                    <h6 className="text-muted"><strong>Published:</strong> {new Date(props.blogs.datePublished).toDateString()} </h6>
                </div>
                <button 
                    type="button"
                    className="card-button btn btn-outline-info ms-2 width: 100%"
                    style={readMoreButton}
                    onClick={onReadMoreClick}>                   
                    Read More!
                </button>
            </div>
        </div>
        </React.Fragment>
    );
}

BlogsCard.propTypes = {
    blogs: PropTypes.shape({
        id: PropTypes.number,
        type: PropTypes.number,
        author: PropTypes.number,
        title: PropTypes.string,
        subject: PropTypes.string,
        content: PropTypes.string,
        imageUrl: PropTypes.string,
        datePublished: PropTypes.string,
    }),
    onButtonClicked: PropTypes.func.isRequired,

};

export default React.memo(BlogsCard);
