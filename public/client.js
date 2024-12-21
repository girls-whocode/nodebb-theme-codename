'use strict';

$(document).ready(function () {
    // Enable tooltips
    require(['hooks'], function (hooks) {
        hooks.on('action:ajaxify.contentLoaded', function () {
            $('[data-toggle="tooltip"]').tooltip({
                container: 'body',
            });
        });
    });

    // Example: Fetch categories and log them
    $.get(config.relative_path + '/api/categories', {}, function (categories) {
        const categoriesList = categories.categories;
        console.log('Categories:', categoriesList);
    });

    $.get(config.relative_path + '/api/recent', {}, function (data) {
        if (data && data.topics) {
            const topicsList = data.topics.map((topic) => ({
                ...topic,
                name: decodeHtmlEntities(topic.name),
                title: decodeHtmlEntities(topic.title),
                category: topic.category,
                formattedDate: formatDate(topic.timestamp),
                initial: getInitial(topic.user.username),
            }));

            console.log('Recent Topics:', topicsList);

            // Optionally update DOM dynamically
            const $topicsContainer = $('#widget-topic-feed_65456218');
            $topicsContainer.empty();
            topicsList.forEach((topic) => {
                const topicHtml = `
                    <li class="nodebbData__item">
                        <a href="/topic/${topic.slug}" class="nodebbLinkPanel">
                            <span>${topic.title}</span>
                        </a>
                        <span>${topic.formattedDate}</span>
                    </li>
                `;
                $topicsContainer.append(topicHtml);
            });
        } else {
            console.error('Failed to fetch recent topics.');
        }
    });
});

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
