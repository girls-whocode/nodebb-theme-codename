'use strict';

const nconf = require.main.require('nconf');
const validator = require.main.require('validator');
const benchpressjs = require.main.require('benchpressjs');
const _ = require.main.require('lodash');
const db = require.main.require('./src/database');
const categories = require.main.require('./src/categories');
const user = require.main.require('./src/user');
const plugins = require.main.require('./src/plugins');
const topics = require.main.require('./src/topics');
const posts = require.main.require('./src/posts');
const groups = require.main.require('./src/groups');
const utils = require.main.require('./src/utils');
const meta = require.main.require('./src/meta');
const privileges = require.main.require('./src/privileges');

const library = module.exports;
const Widget = module.exports;

let app;

function getValuesArray(widget, field) {
	const values = widget.data[field] || '';
	return values.split(',').map(c => parseInt(c, 10)).filter(Boolean);
}

function isVisibleInCategory(widget) {
	const cids = getValuesArray(widget, 'cid');
	return !(
		cids.length &&
		(widget.templateData.template.category || widget.templateData.template.topic) &&
		!cids.includes(parseInt(widget.templateData.cid, 10))
	);
}

function isVisibleInTopic(widget) {
	const tids = getValuesArray(widget, 'tid');
	return !(
		tids.length &&
		widget.templateData.template.topic &&
		!tids.includes(parseInt(widget.templateData.tid, 10))
	);
}

library.defineWidgetAreas = async function (areas) {
	const locations = ['header', 'sidebar', 'footer', 'bottom'];
	const templates = [
		'categories.tpl', 'category.tpl', 'topic.tpl', 'users.tpl',
		'unread.tpl', 'recent.tpl', 'popular.tpl', 'top.tpl', 'tags.tpl', 'tag.tpl',
		'login.tpl', 'register.tpl',
	];
	function capitalizeFirst(str) {
		return str.charAt(0).toUpperCase() + str.slice(1);
	}
	templates.forEach((template) => {
		locations.forEach((location) => {
			areas.push({
				name: `${capitalizeFirst(template.split('.')[0])} ${capitalizeFirst(location)}`,
				template: template,
				location: location,
			});
		});
	});

	areas = areas.concat([
		{
			name: 'Main post header',
			template: 'topic.tpl',
			location: 'mainpost-header',
		},
		{
			name: 'Main post footer',
			template: 'topic.tpl',
			location: 'mainpost-footer',
		},
		{
			name: 'Sidebar Footer',
			template: 'global',
			location: 'sidebar-footer',
		},
		{
			name: 'Brand Header',
			template: 'global',
			location: 'brand-header',
		},
		{
			name: 'About me (before)',
			template: 'account/profile.tpl',
			location: 'profile-aboutme-before',
		},
		{
			name: 'About me (after)',
			template: 'account/profile.tpl',
			location: 'profile-aboutme-after',
		},
	]);

	return areas;
};

Widget.init = async function (params) {
	app = params.app;
};

Widget.renderHTMLWidget = async function (widget) {
	if (!isVisibleInCategory(widget) || !isVisibleInTopic(widget)) {
		return null;
	}
	const tpl = widget.data ? widget.data.html : '';
	widget.html = await benchpressjs.compileRender(String(tpl), widget.templateData);
	return widget;
};

Widget.renderTextWidget = async function (widget) {
	if (!isVisibleInCategory(widget)) {
		return null;
	}
	const parseAsPost = !!widget.data.parseAsPost;
	const text = String(widget.data.text);

	if (parseAsPost) {
		widget.html = await plugins.hooks.fire('filter:parse.raw', text);
	} else {
		widget.html = text.replace(/\r\n/g, '<br />');
	}
	return widget;
};

Widget.renderLatestUsersWidget = async function (widget) {
	const count = Math.max(1, widget.data.numUsers || 24);
	const users = await user.getUsersFromSet('users:joindate', widget.uid, 0, count - 1);
	widget.html = await app.renderAsync('widgets/latestusers', {
		users: users,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderTopPostersWidget = async function (widget) {
	const count = Math.max(1, widget.data.numUsers || 24);
	const users = await user.getUsersFromSet('users:postcount', widget.uid, 0, count - 1);
	widget.html = await app.renderAsync('widgets/topposters', {
		users: users,
		sidebar: widget.location === 'sidebar',
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderForumStatsWidget = async function (widget) {
	const socketRooms = require.main.require('./src/socket.io/admin/rooms');
	const [global, onlineCount, guestCount] = await Promise.all([
		db.getObjectFields('global', ['topicCount', 'postCount', 'userCount']),
		db.sortedSetCount('users:online', Date.now() - (meta.config.onlineCutoff * 60000), '+inf'),
		socketRooms.getTotalGuestCount(),
	]);

	const stats = {
		topics: utils.makeNumberHumanReadable(global.topicCount ? global.topicCount : 0),
		posts: utils.makeNumberHumanReadable(global.postCount ? global.postCount : 0),
		users: utils.makeNumberHumanReadable(global.userCount ? global.userCount : 0),
		online: utils.makeNumberHumanReadable(onlineCount + guestCount),
		statsClass: widget.data.statsClass,
	};
	widget.html = await app.renderAsync('widgets/forumstats', stats);
	return widget;
};

Widget.renderRecentPostsWidget = async function (widget) {
	let cid;

	if (widget.data.cid) {
		cid = widget.data.cid;
	} else if (widget.templateData.template.category) {
		cid = widget.templateData.cid;
	} else if (widget.templateData.template.topic && widget.templateData.category) {
		cid = widget.templateData.category.cid;
	}
	const numPosts = widget.data.numPosts || 4;
	let postsData;
	if (cid) {
		postsData = await categories.getRecentReplies(cid, widget.uid, numPosts);
	} else {
		postsData = await posts.getRecentPosts(widget.uid, 0, Math.max(0, numPosts - 1), 'alltime');
	}
	const data = {
		posts: postsData,
		numPosts: numPosts,
		cid: cid,
		relative_path: nconf.get('relative_path'),
	};
	widget.html = await app.renderAsync('widgets/recentposts', data);
	return widget;
};

Widget.renderRecentTopicsWidget = async function (widget) {
	const numTopics = (widget.data.numTopics || 8) - 1;
	let cids = getValuesArray(widget, 'cid');

	let key;
	if (!cids.length) {
		cids = await categories.getCidsByPrivilege('categories:cid', widget.uid, 'topics:read');
	}
	if (cids.length) {
		if (cids.length === 1) {
			key = `cid:${cids[0]}:tids:lastposttime`;
		} else {
			key = cids.map(cid => `cid:${cid}:tids:lastposttime`);
		}
	}
	const data = await topics.getTopicsFromSet(key, widget.uid, 0, Math.max(0, numTopics));
	data.topics.forEach((topicData) => {
		if (topicData && !topicData.teaser) {
			topicData.teaser = {
				user: topicData.user,
			};
		}
	});
	widget.html = await app.renderAsync('partials/recent', {
		topics: data.topics,
		numTopics: numTopics,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderModeratorsWidget = async function (widget) {
	let cid;
	const widgetData = [
		{
			widget: 'topposters',
			name: 'Top Posters',
			description: 'List of users with the most posts.',
			content: 'admin/partials/widgets/topposters',
		}
	];
}

Widget.renderPopularTags = async function (widget) {
	const numTags = widget.data.numTags || 8;
	let tags = [];
	if (widget.templateData.template.category) {
		tags = await topics.getCategoryTagsData(widget.templateData.cid, 0, numTags - 1);
	} else {
		let cids = await categories.getCidsByPrivilege('categories:cid', widget.uid, 'topics:read');
		cids = cids.filter(cid => cid !== -1);
		tags = await topics.getCategoryTagsData(cids, 0, numTags - 1);
	}
	let maxCount = 1;
	tags.forEach((t) => {
		if (t.score > maxCount) {
			maxCount = t.score;
		}
	});
	tags.forEach((t) => {
		t.widthPercent = ((t.score / maxCount) * 100).toFixed(2);
	});

	widget.html = await app.renderAsync('widgets/populartags', {
		tags: tags,
		template: widget.templateData.template,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderPopularTopics = async function (widget) {
	const numTopics = widget.data.numTopics || 8;
	const data = await topics.getSortedTopics({
		uid: widget.uid,
		start: 0,
		stop: numTopics - 1,
		term: widget.data.duration || 'alltime',
		sort: 'posts',
	});
	widget.html = await app.renderAsync('widgets/populartopics', {
		topics: data.topics,
		numTopics: numTopics,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderTopTopics = async function (widget) {
	const numTopics = widget.data.numTopics || 8;
	const data = await topics.getSortedTopics({
		uid: widget.uid,
		start: 0,
		stop: numTopics - 1,
		term: widget.data.duration || 'alltime',
		sort: 'votes',
	});
	widget.html = await app.renderAsync('widgets/toptopics', {
		topics: data.topics,
		numTopics: numTopics,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderSuggestedTopics = async function (widget) {
	const numTopics = Math.max(0, (widget.data.numTopics || 8) - 1);
	const cutoff = Math.max(0, parseInt(widget.data.cutoff, 10) || 0);
	async function getCategoryTopics(term, sort) {
		const data = await topics.getSortedTopics({
			cids: widget.templateData.cid,
			uid: widget.uid,
			start: 0,
			stop: 2 * numTopics,
			term: term,
			sort: sort,
		});
		return data.topics;
	}
	let topicData;
	if (widget.templateData.template.topic) {
		topicData = await topics.getSuggestedTopics(widget.templateData.tid, widget.uid, 0, numTopics, cutoff);
	} else if (widget.templateData.template.category) {
		topicData = await getCategoryTopics('month', 'votes');
		if (!topicData.length) {
			topicData = await getCategoryTopics('alltime', 'recent');
		}
		topicData = _.shuffle(topicData).slice(0, numTopics + 1);
		topicData = topicData.filter(topic => topic && !topic.deleted);
	} else {
		const data = await topics.getTopicsFromSet('topics:recent', widget.uid, 0, numTopics);
		topicData = data ? data.topics : [];
		topicData = topicData.filter(topic => topic && !topic.deleted);
	}

	widget.html = await app.renderAsync('widgets/suggestedtopics', {
		topics: topicData,
		config: widget.templateData.config,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.renderUserPost = async function (widget) {
	const numPosts = Math.max(1, (widget.data.numPosts || 1));
	const type = widget.data.postType || 'last';
	let { uid } = widget;
	if (widget.templateData.template['account/profile']) {
		uid = widget.templateData.uid;
	} else if (widget.data.uid) {
		uid = widget.data.uid;
	}
	let pids = [];
	const cids = await categories.getCidsByPrivilege('categories:cid', widget.uid, 'topics:read');
	const sets = cids.map(c => `cid:${c}:uid:${uid}:pids`);
	const now = Date.now();
	if (type === 'last') {
		pids = await db.getSortedSetRevRangeByScore(sets, 0, numPosts, now, '-inf');
	} else if (type === 'first') {
		pids = await db.getSortedSetRange(sets, 0, numPosts, now, '-inf');
	} else if (type === 'best') {
		pids = await db.getSortedSetRevRange(
			cids.map(c => `cid:${c}:uid:${uid}:pids:votes`),
			0,
			numPosts,
			now,
			'-inf'
		);
	}
	const postObjs = await posts.getPostSummaryByPids(pids, widget.uid, { stripTags: false });
	if (!postObjs.length) {
		return null;
	}
	widget.html = await app.renderAsync('widgets/userpost', {
		posts: postObjs,
		config: widget.templateData.config,
		relative_path: nconf.get('relative_path'),
	});
	return widget;
};

Widget.defineWidgets = async function (widgets) {
	const widgetData = [
		{
			widget: 'html',
			name: 'HTML',
			description: 'Any text, html, or embedded script.',
			content: 'admin/partials/widgets/html',
		},
		{
			widget: 'text',
			name: 'Text',
			description: 'Text, optionally parsed as a post.',
			content: 'admin/partials/widgets/text',
		},
		{
			widget: 'search',
			name: 'Search',
			description: 'A search widget',
			content: 'admin/partials/widgets/search',
		},
		{
			widget: 'onlineusers',
			name: 'Online Users',
			description: 'List of online users',
			content: 'admin/partials/widgets/onlineusers',
		},
		{
			widget: 'activeusers',
			name: 'Active Users',
			description: 'List of active users in a category/topic',
			content: 'admin/partials/widgets/activeusers',
		},
		{
			widget: 'latestusers',
			name: 'Latest Users',
			description: 'List of latest registered users.',
			content: 'admin/partials/widgets/latestusers',
		},
		{
			widget: 'topposters',
			name: 'Top Posters',
			description: 'List of users with the most posts.',
			content: 'admin/partials/widgets/topposters',
		},
		{
			widget: 'moderators',
			name: 'Moderators',
			description: 'List of moderators in a category.',
			content: 'admin/partials/widgets/moderators',
		},
		{
			widget: 'forumstats',
			name: 'Forum Stats',
			description: 'Lists user, topics, and post count.',
			content: 'admin/partials/widgets/forumstats',
		},
		{
			widget: 'recentposts',
			name: 'Recent Posts',
			description: 'Lists the latest posts on your forum.',
			content: 'admin/partials/widgets/recentposts',
		},
		{
			widget: 'recenttopics',
			name: 'Recent Topics',
			description: 'Lists the latest topics on your forum.',
			content: 'admin/partials/widgets/recenttopics',
		},
		{
			widget: 'recentview',
			name: 'Recent View',
			description: 'Renders the /recent page',
			content: 'admin/partials/widgets/defaultwidget',
		},
		{
			widget: 'categories',
			name: 'Categories',
			description: 'Lists the categories on your forum',
			content: 'admin/partials/widgets/categories',
		},
		{
			widget: 'populartags',
			name: 'Popular Tags',
			description: 'Lists popular tags on your forum',
			content: 'admin/partials/widgets/populartags',
		},
		{
			widget: 'populartopics',
			name: 'Popular Topics',
			description: 'Lists popular topics on your forum',
			content: 'admin/partials/widgets/populartopics',
		},
		{
			widget: 'toptopics',
			name: 'Top Topics',
			description: 'Lists top topics on your forum',
			content: 'admin/partials/widgets/toptopics',
		},
		{
			widget: 'mygroups',
			name: 'My Groups',
			description: 'List of groups that you are in',
			content: 'admin/partials/widgets/mygroups',
		},
		{
			widget: 'newgroups',
			name: 'New Groups',
			description: 'List of newest groups',
			content: 'admin/partials/widgets/mygroups',
		},
		{
			widget: 'suggestedtopics',
			name: 'Suggested Topics',
			description: 'Lists of suggested topics.',
			content: 'admin/partials/widgets/suggestedtopics',
		},
		{
			widget: 'userpost',
			name: 'User Post',
			description: 'Display a users first/last/best post on their profile or by user id.',
			content: 'admin/partials/widgets/userpost',
		},
	];

	await Promise.all(widgetData.map(async (widget) => {
		widget.content = await app.renderAsync(widget.content, {});
	}));

	widgets = widgets.concat(widgetData);
	const groupNames = await db.getSortedSetRevRange('groups:visible:createtime', 0, -1);
	let groupsData = await groups.getGroupsData(groupNames);
	groupsData = groupsData.filter(Boolean);
	groupsData.forEach((group) => {
		group.name = validator.escape(String(group.name));
	});

	const html = await app.renderAsync('admin/partials/widgets/groupposts', { groups: groupsData });
	widgets.push({
		widget: 'groupposts',
		name: 'Group Posts',
		description: 'Posts made my members of a group',
		content: html,
	});

	return widgets;
};