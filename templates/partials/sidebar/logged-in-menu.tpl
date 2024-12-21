<li id="user_label" title="{user.username}" role="menuitem">
	<!-- IMPORT partials/sidebar/user-menu.tpl -->
</li>
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
