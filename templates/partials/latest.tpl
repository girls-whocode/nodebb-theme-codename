<div class="nodebbWidget nodebbWidget--horizontal" data-blocktitle="Topic Feed" data-blockid="app_forums_topicFeed_9f557b" data-menustyle="menu" data-blockconfig="1" data-widget-customizable="1" data-controller="core.front.widgets.block">
    <header class="nodebbWidget__header">
        <h3>Latest Topics</h3>
    </header>
    <div class="nodebbWidget__content">
        <ul class="nodebbData nodebbData--mini-grid nodebbData--carousel nodebbData--topic-feed-widget" id="widget-topic-feed_65456218" tabindex="0">
            {{{ each topicsList }}}
            <li class="nodebbData__item">
                <!-- Topic Title -->
                <a href="/topic/{slug}" class="nodebbLinkPanel">
                    <span>{title}</span>
                </a>
                
                <!-- User Avatar or Fallback -->
                <figure class="nodebbData__icon">

                    {{{ if user.picture }}}
                    <a href="/user/{user.username}" class="nodebbUserPhoto nodebbUserPhoto--fluid">
                        <img src="{user.picture}" alt="{user.username}" loading="lazy" />
                    </a>
                    {{{ else }}}
                    <div class="nodeBBNavNoPhotoTile nodebbUserPhoto--fluid nodebbUserNav__link"
                         style="background-color: {user.icon:bgColor || '#555'}; 
                                width: 28px; 
                                height: 28px; 
                                font-size: 15px; 
                                line-height: 28px; 
                                border-radius: 50%;">
                        {user.icon:text}
                    </div>
                    {{{ end }}}
                </figure>

                <!-- Metadata -->
                <span>{formattedDate}</span>
                <span>Views: {viewcount}</span>

                <!-- Category -->
                <ul class="nodebbTags nodebbTags--condensed">
                    <li class="nodebbTags__item">
                        <a href="/category/{category.slug}" 
                           class="nodebbTags__tag" 
                           rel="tag" 
                           title="{category.name}">
                            <i class="fa {category.icon}"></i>
                            <span>{category.name}</span>
                        </a>
                    </li>
                </ul>
            </li>
            {{{ end }}}
        </ul>
    </div>
</div>
