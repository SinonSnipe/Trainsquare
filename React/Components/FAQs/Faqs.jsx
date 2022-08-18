import React, { useEffect, useState } from 'react';
import { Row, Col, Form } from 'react-bootstrap';
import faqService from '../../services/faqService';
import FaqTemplate from './FaqTemplate';
import Footer from '../../layouts/Footer';
import PageTitle from './PageTitle';
import lookup from '../../services/lookupService';
import logger from 'sabio-debug';

const _logger = logger.extend('Faqs');

function Faqs() {
    const [pageData, setPageData] = useState({
        question: '',
        answer: '',
        faqsArray: [],
        faqComponent: [],
        pageIndex: 0,
        current: 1,
        pageSize: 20,
        totalCount: 0,
        totalPages: 0,
    });
    const [mappedCategories, setCategory] = useState([]);
    const [selectCategory, setSelectCategory] = useState('');

    // _logger('mapped', mappedCategories);

    useEffect(() => {
        faqService.getAllFaq(pageData.pageIndex, pageData.pageSize).then(onGetAllSuccess).catch(onGetAllError);
    }, []);

    const onGetAllSuccess = (data) => {
        setPageData((prevState) => {
            let faqArr = data.item.pagedItems;
            const faqCount = data.item.totalCount;
            const faqPages = data.item.totalPages;
            const current = data.item.pageIndex + 1;
            const pd = { ...prevState };
            pd.totalCount = faqCount;
            pd.totalPages = faqPages;
            pd.current = current;
            pd.faqsArray = faqArr;
            pd.faqComponent = faqArr.map(mapFaqs);

            return pd;
        });
    };
    const onGetAllError = (error) => {
        _logger(error);
    };

    const mapFaqs = (anFaq) => {
        _logger('mapper', anFaq);
        return (
            <FaqTemplate faq={anFaq} key={anFaq.id}>
                {' '}
            </FaqTemplate>
        );
    };

    useEffect(() => {
        lookup(['FaqCategories']).then(onLookupSuccess).catch(onLookupError);
    }, []);

    const onLookupSuccess = (response) => {
        let mappedCategories = response.item.faqCategories?.map(mapCategory);
        setCategory(mappedCategories);
    };
    const onLookupError = (error) => {
        _logger(error);
    };

    const mapCategory = (category) => (
        <option value={category.id} key={category.id}>
            {category.name}
        </option>
    );

    const handleSelect = (e) => {
        e.preventDefault();
        const currentCategory = e.target.value;
        setSelectCategory(currentCategory);
        setPageData((prevState) => {
            const pd = { ...prevState };
            const updatedList = pd.faqsArray.filter((faq) => {
                if (faq.categoryId === parseInt(currentCategory)) {
                    return true;
                }
                return false;
            });
            pd.faqComponent = updatedList.map(mapFaqs);
            return pd;
        });
    };

    return (
        <div className="container-fluid">
            <PageTitle breadCrumbItems={[{ label: 'FAQs', path: '/faqs', active: true }]} />
            <Row>
                <Col>
                    <div className="text-center">
                        <h3 className="">Frequently Asked Questions</h3>
                        <p className="text-muted mt-3">
                            {' '}
                            Search the most frequently asked questions below.
                            <br /> If you do not find what you are looking for, send us an email.
                        </p>

                        <button type="button" className="btn btn-success btn-sm mt-2">
                            <i className="mdi mdi-email-outline me-1"></i>{' '}
                            <a href="/faqs/submit" className="text-white">
                                Email us your question
                            </a>
                        </button>
                        <Form.Select
                            type="button"
                            className="form-control my-2"
                            value={selectCategory}
                            onChange={handleSelect}>
                            <option> Filter by Category</option>
                            {mappedCategories}
                        </Form.Select>
                    </div>
                </Col>
            </Row>
            <Row>{pageData.faqComponent}</Row>
            <div className="d-flex align-items-stretch">
                <Footer />
            </div>
        </div>
    );
}

export default Faqs;
