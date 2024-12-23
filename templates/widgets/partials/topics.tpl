{{{ each topics }}}
<li id="recent_topics" class="nodebbData__item">
    <!-- Topic Title -->
    <a href="{relative_path}/topic/{./slug}" class="nodebbLinkPanel">
        <span>{./title}</span>
    </a>
    
    <!-- User Avatar or Fallback -->
    <figure class="nodebbData__icon">

        <a class="text-decoration-none" href="{{{ if ./teaser.user.userslug }}}{relative_path}/user/{./teaser.user.userslug}{{{ else }}}#{{{ end }}}">
            {buildAvatar(./teaser.user, "24px", true, "avatar-tooltip not-responsive")}
        </a>
        <div class="post-author d-flex align-items-center gap-1">
            <a class="lh-1 fw-semibold" href="{config.relative_path}/user/{./teaser.user.userslug}">{./teaser.user.displayname}</a>
        </div>
    </figure>

    <!-- Metadata -->
    <span class="timeago text-muted lh-1" title="{./teaser.timestampISO}"></span>
    <div class="d-flex justify-content-between">
        <div class="btn btn-link btn-sm text-body pe-none"><i class="fa-fw fa-heart text-xs fa-regular text-muted"></i> {humanReadableNumber(./votes)}</div>
        <div class="btn btn-link btn-sm text-body pe-none"><i class="fa-fw fa-regular fa-message text-xs text-muted"></i> {humanReadableNumber(./postcount)}</div>
        <div class="btn btn-link btn-sm text-body pe-none"><i class="fa-fw fa-regular fa-eye text-xs text-muted"></i> {humanReadableNumber(./viewcount)}</div>
    </div>

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
