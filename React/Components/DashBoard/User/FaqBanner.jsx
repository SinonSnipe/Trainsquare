import React from 'react';
import { Link } from 'react-router-dom';
import '../userDashboard.css';
import faqIcon from '../../../../assets/images/dashboard/user/faq-icon.png';

function FaqBanner() {
    return (
        <Link to="/faqs" className="faqBanner">
            <img src={faqIcon} alt="faqIcon" style={{ width: 75 }} />
        </Link>
    );
}

export default FaqBanner;
