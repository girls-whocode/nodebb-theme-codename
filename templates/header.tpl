<!DOCTYPE html>
<html lang="{function.localeToHTML, userLang, defaultLang}" {{{if languageDirection}}}data-dir="{languageDirection}" style="direction: {languageDirection};"{{{end}}}>
<head>
	<title>{browserTitle}</title>
	{{{each metaTags}}}{function.buildMetaTag}{{{end}}}
    <link rel="stylesheet" type="text/css" href="{relative_path}/assets/client{{{if bootswatchSkin}}}-{bootswatchSkin}{{{end}}}{{{ if (languageDirection=="rtl") }}}-rtl{{{ end }}}.css?{config.cache-buster}" />
    {{{each linkTags}}}{function.buildLinkTag}{{{end}}}
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/root.css" />
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/components.css" />
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/global.css" />
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/framework.css" />
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/codename.css" />
	<link rel="stylesheet" type="text/css" href="/assets/plugins/nodebb-theme-codename/static/css/utilities.css" />

    <script data-id="color-scheme-script">
        (() => document.documentElement.setAttribute('data-nodebb-scheme', 
        (window.matchMedia('(prefers-color-scheme:dark)').matches) ? 'dark' : 'dark'))();
    </script>

	<script>
		var config = JSON.parse('{{configJSON}}');
		var app = {
			user: JSON.parse('{{userJSON}}')
		};

		document.documentElement.style.setProperty('--panel-offset', `${localStorage.getItem('panelOffset') || 0}px`);
	</script>

	{{{if useCustomHTML}}}
	    {{customHTML}}
	{{{end}}}
	{{{if useCustomCSS}}}
	    <style>{{customCSS}}</style>
	{{{end}}}

    <style>
        img {
            display: block;
            width: 100%; /* or a fixed width */
            height: auto; /* or a fixed height */
            object-fit: cover; /* Ensures images scale nicely */
            opacity: 1; /* Default to visible */
            transition: opacity 0.3s ease-in-out;
            border-radius: 5px !important;
        }

        img[data-loaded="false"] {
            opacity: 0; /* Hide only if explicitly marked as not loaded */
        }

        p {
            color: #cccccc;
        }

        .text-xs {
            color: #999999 !important;
        }

        .ff-secondary {
            color: #ffffff !important;
        }
    </style>
</head>

<body class="nodebbApp nodebbApp_front nodebbApp_noTouch {bodyClass} skin-{{{if bootswatchSkin}}}{bootswatchSkin}{{{else}}}noskin{{{end}}}">
    <a class="visually-hidden-focusable position-absolute top-0 start-0 p-3 m-3 bg-body" style="z-index: 1021;" href="#content">[[global:skip-to-content]]</a>
    <div id="content">
        <header data-nodebb-hook="header" class="nodebbHeader nodebbResponsive_header--desktop">
            <div hidden="hidden" class="nodebbHeader__top">
                <div class="nodebbWidth nodebbHeader__align">
                    <div data-nodebb-header-position="1" class="nodebbHeader__start"></div>
                    <div data-nodebb-header-position="2" class="nodebbHeader__center"></div>
                    <div data-nodebb-header-position="3" class="nodebbHeader__end"></div>
                </div>
            </div>
            <div data-nodebb-hook="primaryHeader" class="nodebbHeader__primary container-fluid">
                <div class="nodebbWidth nodebbHeader__align">
                    <!-- IMPORT partials/header/brand.tpl -->
                    <div data-nodebb-header-position="5" class="nodebbHeader__center">
                        <!-- IMPORT partials/menu.tpl -->
                    </div>
                    <div data-nodebb-header-position="6" class="nodebbHeader__end">
                        <div data-nodebb-header-content="user" id="elUserNav">
                            <ul id="elUserNav" class="nodebbUserNav">
                                <li data-el="profile">
                                    <a href="https://discussions.codenamejessica.com/user/jessica" rel="nofollow" class="nodebbUserPhoto nodebbUserPhoto--fluid nodebbUserNav__link" title="Go to jessica's profile">
                                        <img src="/assets/uploads/profile/uid-1/1-profileavatar-1734441477713.jpeg" alt="jessica" class="nodebbUserNav__avatar">
                                    </a>
                                </li>
                                <li data-el="logout">
                                    <button class="nodebbUserNav__link" id="logoutButton">
                                        <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i>
                                        <span class="nodebbUserNav__text">Log Out</span>
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div data-nodebb-hook="secondaryHeader" class="nodebbHeader__secondary">
                <div class="nodebbWidth nodebbHeader__align"><div data-nodebb-header-position="7" class="nodebbHeader__start">
                    <div data-nodebb-header-content="breadcrumb">
                        <nav aria-label="Breadcrumbs" class="nodebbBreadcrumb nodebbBreadcrumb--top">
                            <ol itemscope="itemscope" itemtype="https://schema.org/BreadcrumbList">
                                <!-- IMPORT partials/breadcrumb.tpl -->
                            </ol>
                        </nav>
                    </div>
                </div>
                <div data-nodebb-header-position="8" class="nodebbHeader__center"></div>
                <div data-nodebb-header-position="9" class="nodebbHeader__end">
                    <div data-nodebb-header-content="search">
                        {{{ if (config.searchEnabled && user.privileges.search:content) }}}
                        <div class="navbar-search visible-xs">
                            <form action="{config.relative_path}/search" method="GET">
                                <button type="button" class="btn btn-link"><i class="fa fa-lg fa-fw fa-search" title="[[global:header.search]]"></i></button>
                                <input autocomplete="off" type="text" class="form-control hidden" name="term" placeholder="[[global:search]]"/>
                                <button class="btn btn-primary hidden" type="submit"></button>
                                <input type="text" class="hidden" name="in" value="{config.searchDefaultInQuick}" />
                            </form>
                            <div class="quick-search-container dropdown-menu d-block mt-2 hidden">
                                <div class="quick-search-results-container"></div>
                            </div>
                        </div>
                        {{{ end }}}
                    </div>
                </div>
            </div>
        </header>
        <main id="panel" class="d-flex flex-column gap-3 flex-grow-1 mt-3" style="min-width: 0;">
