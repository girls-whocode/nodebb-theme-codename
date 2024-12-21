<div class="nodebbWidget nodebbWidget--horizontal" data-blocktitle="Topic Feed" data-blockid="app_forums_topicFeed_9f557b" data-blockerrormessage="This block cannot be shown. This could be because it needs configuring, is unable to show on this page, or will show after reloading this page." data-menustyle="menu" data-blockconfig="1" data-widget-customizable="1" data-widget-layouts="" data-controller="core.front.widgets.block">
    <header class="nodebbWidget__header">
        <h3>Latest Topics</h3>
    </header>
    <div class="nodebbWidget__content">
        <ul class="nodebbData nodebbData--mini-grid nodebbData--carousel nodebbData--topic-feed-widget" id="widget-topic-feed_65456218" tabindex="0">
            <li v-for="(topic, index) in topics" :key="index" data-nodebb-hook="row" class="nodebbData__item">
                <a :href="'https://discussions.codenamejessica.com/topic/' + topic.slug" class="nodebbLinkPanel" aria-hidden="true" tabindex="-1">
                    <span>{{ topic.title }}</span>
                </a>
                <figure class="nodebbData__icon">
                    <a v-if="topic.user.picture" :href="'https://discussions.codenamejessica.com/profile/' + topic.user.id" class="nodebbUserPhoto nodebbUserPhoto--fluid">
                        <img :src="topic.user.picture" :alt="topic.user.username" loading="lazy" />
                    </a>
                    <div v-else class="nodeBBNavNoPhotoTile nodebbUserPhoto--fluid nodebbUserNav__link"
                    :style="{ 
                        backgroundColor: topic.user['icon:bgColor'] || '#555', 
                        width: '28px', 
                        height: '28px', 
                        fontSize: '15px', 
                        lineHeight: '28px', /* Match height for perfect centering */
                        borderRadius: '50%' 
                    }">
                        {{ getInitial(topic.user.username) }}
                    </div>
                </figure>
                <div class="nodebbData__content">
                    <div class="nodebbData__main">
                        <div class="nodebbData__topic">
                            <span class="nodebbContainerTitle" :style="{ '--i-featured': '#0052cc', '--i-featured-text': '#ffffff' }">
                                <div>{{ topic.name }}</div>
                            </span>
                        </div>
                        <div class="nodebbData__title">
                            <h4 data-nodebb-hook="title">
                                <div>
                                    <a :href="'https://discussions.codenamejessica.com/topic/' + topic.tid" class="text-decoration-none">
                                        {{ truncateContent(topic.title, 30) }}
                                    </a>
                                    <span class="viewCountBadge">
                                        <i class="fa fa-eye"></i>{{ topic.viewcount }}
                                    </span>
                                </div>
                            </h4>
                        </div>
                        <div class="nodebbData__meta">
                            <span>{{ topic.user.name }}</span> · 
                            <time :datetime="topic.timestamp">{{ formatDate(topic.timestamp) }}</time>
                        </div>
                    </div>
                    <ul class="nodebbTags nodebbTags--condensed">
                    <li class="nodebbTags__item">
                        <a :href="'https://discussions.codenamejessica.com/category/' + topic.category.slug" class="nodebbTags__tag" rel="tag" :data-tag-label="topic.category.name" data-nodebbtooltip="" :_title="topic.category.name">
                            <i :class="'fa ' + topic.category.icon"></i>
                            <span>{{ topic.category.name }}</span>
                        </a>
                    </li>
                </ul>

                    </div>
            </li>
        </ul>
    </div>
</div>