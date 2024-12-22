'use strict';

// Utility functions
const decodeHtmlEntities = (str) => {
    if (!str) return '';
    const textArea = document.createElement('textarea');
    textArea.innerHTML = str;
    return textArea.value;
};

const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
    return new Date(dateString).toLocaleDateString(undefined, options);
};

const getInitial = (name) => {
    if (!name) return '?';
    return name.charAt(0).toUpperCase();
};
