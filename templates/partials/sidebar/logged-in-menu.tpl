<li class="d-flex justify-content-between align-items-center {navigation.class} dropend" id="user_label" title="{user.username}" role="menuitem">
    <a class="navigation-link align-items-center dropdown-toggle btn btn-sm btn-ghost" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    <!-- IMPORT partials/sidebar/user-menu.tpl -->
    </a>
    <ul class="dropdown-menu p-1" role="menu">
        {{{ if (config.searchEnabled && user.privileges.search:content) }}}
        <li>
            <!-- IMPORT partials/sidebar/search.tpl -->
        </li>
        {{{ end }}}

        <li>
            <!-- IMPORT partials/sidebar/notifications.tpl -->
        </li>

        {{{ if canChat }}}
        <li>
            <!-- IMPORT partials/sidebar/chats.tpl -->
        </li>
        {{{ end }}}

        <li>
            <!-- IMPORT partials/sidebar/drafts.tpl -->
        </li>

        <li>
            <button class="nodebbUserNav__link" id="logoutButton">
                <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i>
                <span class="nodebbUserNav__text">Log Out</span>
            </button>
        </li>
    </ul>
</li>
