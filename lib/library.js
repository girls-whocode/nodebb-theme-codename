'use strict';

const nconf = require.main.require('nconf');
const _ = require.main.require('lodash');
const user = require.main.require('./src/user');
const Widget = {};

Widget.topPosters = async function (widgets) {
    widgets.push({
        widget: 'top_posters', // Unique ID for your widget
        name: 'CNJ Top Posters', // Display name
        description: 'Top posters widget for CodeNameJessica', // Description
        content: 'widgets/top_posters', // Path to the template file
    });
	
    return widgets;
};

Widget.renderTopPostersWidget = async function (widget) {
	const count = Math.max(1, widget.data.numUsers || 24);
	const users = await user.getUsersFromSet('users:postcount', widget.uid, 0, count - 1);
	widget.html = await app.renderAsync('widgets/top_posters', {
		users: users,
		sidebar: widget.location === 'sidebar',
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

module.exports = Widget;
