import React, { useState, useEffect, useCallback} from "react";
import { useNavigate } from "react-router-dom";
import debug from "sabio-debug";
import BlogCard from "./BlogCard";
import { Form } from 'react-bootstrap';
import toastr from "../../../utils/toastr";
import lookup from "../../../services/lookupService";
import *  as blogAdminService from "../../../services/blogAdminService";
const _logger = debug.extend("BlogsAdmin");

function BlogsAdmin() {
    const navigate = useNavigate();

    const [pageData, setPageData] = useState({
        blogs: [],
        blogsComponents: [],
        pageIndex: 0,
        pageSize: 15,
        query: "",
        count: 0,
        current: 1,
    });

    const [searchPost, setSearchPost] = useState("");
    const [typeContent, setTypeContent] = useState([]);
    const [selectedType, setSelectedType] = useState("");

    const updateContent = (e) => {
        setSearchPost(e.target.value);
    };

    const onGetAuthorQuerySuccess = (response) => {
        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.blogs = response.item.pagedItems;
            pd.blogsComponents = response.item.pagedItems.map(mapBlog);
            return pd;
        });
    };

    const onGetAuthorQueryError = (err) => {
        _logger(err, "error");
    };

    const searchHandler = (e) => {
        e.preventDefault();
            blogAdminService
            .getByAuthor(pageData.pageIndex, pageData.pageSize, searchPost)
            .then(onGetAuthorQuerySuccess)
            .catch(onGetAuthorQueryError)
    };
    

    const onGetAllSuccess = (response) => {

        setPageData((prevState) => {
            const pd = { ...prevState };
            pd.blogs = response.item.pagedItems;

            if(selectedType === "") {
                pd.blogsComponents = response.item.pagedItems.map(mapBlog);
            } else {
                const filteredPagedItems = response.item.pagedItems.filter((item) => item.type.name === selectedType);
                pd.blogsComponents = filteredPagedItems.map(mapBlog);
            }
            return pd;
        });
    };

    const onGetAllError = (err) => {
        _logger(err, "error");
    };

    const onPostDelete = useCallback((myBlog, eObj) => {
        _logger("Delete ID", myBlog.id, { myBlog, eObj });
        const idTobeDeleted = myBlog.id;

        setPageData(prevState => {
            const pd = { ...prevState };
            pd.blogs = [...pd.blogs];

            const idxOf = pd.blogs.findIndex((currentBlog) => {
                let result = false;

                if (currentBlog.id === idTobeDeleted) {
                    result = true;

                    toastr.success("Post has been deleted!");
                }

                return result;
            });

            if (idxOf >= 0) {
                pd.blogs.splice(idxOf, 1);
                pd.blogsComponents = pd.blogs.map(mapBlog)
            }

            return pd;
        })
    }, []);

    const addPostLocally = () => {
        navigate(`/blogsadmin/new`);
    };

    const mapBlog = (aPost) => {
        return (
            <BlogCard
                currentPost={aPost}
                key={aPost.id}
                onDelete={onPostDelete}
            >
            </BlogCard>
        );
    };

    const onLookupSuccess = (response) => {
        let newType = response.item.blogTypes
        setTypeContent(newType);

    }

    const onLookupError = (response) => {
        _logger(response, "error retrieving lookup table")
    };

    const mapType = (type, index) => (
        <option
         key={`${type}_${index}`}
        >{type.name}
        </option>
    );
  
    const handleFilterChange = (e) => {
        e.preventDefault()
        const currentType = e.target.value;
        setSelectedType(currentType);

    }; 

    useEffect(() => {
        lookup(["BlogTypes"])
        .then(onLookupSuccess)
        .catch(onLookupError);
    }, []);

    useEffect(() => {
        blogAdminService
            .getAll(pageData.pageIndex, pageData.pageSize)
            .then(onGetAllSuccess)
            .catch(onGetAllError);
    }, [selectedType]);

    return (
        <React.Fragment>
            <div className="container-fluid">
                <form className="form-inline my-2 my-lg-0">
                    <h1>MY BLOGS</h1>
                </form>
                <form className="form-inline my-2 mylg-0">
                    <div className="btn-toolbar justify-content-between" role="toolbar" aria-label="Toolbar with button groups">
                        <div className="btn-group" role="group" aria-label="First group">
                            <button
                                type="button"
                                className="btn btn-primary ms-2 me-2"
                                onClick={addPostLocally}>
                                Add Post
                            </button>
                        </div>
                    <div className="input-group">
                        <div className="input-group-prepend">
                        </div>
                            <input
                                className="form-control rounded"
                                type="search"
                                placeholder="Search..."
                                aria-label="Search"
                                aria-describedby="search-addon"
                                value={searchPost}
                                onChange={updateContent}
                                name="search"
                               
                            />
                             <div className="input-group-append">
                            <button
                                className="btn btn-info"
                                type="submit"
                                onClick={searchHandler}                               
                            >Search
                            </button>
                        </div>
                    </div>
                    </div>
                </form>

                <form className="form-inline my-2 my-lg-0">
                    <div className="form-group">
                        <label htmlFor="StatusId">Blog Category</label> 
                        <Form.Select 
                            aria-label="Default select example" 
                            name="typeId" 
                            className="form-control"
                            value={selectedType}
                            onChange={handleFilterChange}
                        >   
                            <option value="">Select Type of Post</option>
                            {typeContent?.map(mapType)}
                        </Form.Select>   
                    </div>
                </form>
                <br/>
                <div className="row">
                    {pageData.blogsComponents}
                </div>
            </div>
        </React.Fragment>
    );
};

export default React.memo(BlogsAdmin);