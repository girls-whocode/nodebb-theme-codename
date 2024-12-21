<!DOCTYPE html>
<html lang="{function.localeToHTML, userLang, defaultLang}" {{{if languageDirection}}}data-dir="{languageDirection}" style="direction: {languageDirection};"{{{end}}}>
<head>
	<title>{browserTitle}</title>
	{{{each metaTags}}}{function.buildMetaTag}{{{end}}}
    <link rel="stylesheet" type="text/css" href="{relative_path}/assets/client{{{if bootswatchSkin}}}-{bootswatchSkin}{{{end}}}{{{ if (languageDirection=="rtl") }}}-rtl{{{ end }}}.css?{config.cache-buster}" />
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
	</script>

	{{{if useCustomHTML}}}
	    {{customHTML}}
	{{{end}}}
	{{{if useCustomCSS}}}
	    <style>{{customCSS}}</style>
	{{{end}}}
</head>

<body class="nodebbApp nodebbApp_front nodebbApp_noTouch {bodyClass} skin-{{{if bootswatchSkin}}}{bootswatchSkin}{{{else}}}noskin{{{end}}}">
    <a class="visually-hidden-focusable position-absolute top-0 start-0 p-3 m-3 bg-body" style="z-index: 1021;" href="#content">[[global:skip-to-content]]</a>
    <div id="app">
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
                            {{{ if config.loggedIn }}}
                            <ul id="logged-in-menu" class="nodebbUserNav">
                                <!-- IMPORT partials/sidebar/logged-in-menu.tpl -->
                            </ul>
	                        {{{ else }}}
	                        <ul id="logged-out-menu" class="list-unstyled d-flex flex-column w-100 gap-2 mt-2" role="menu">
	                            <!-- IMPORT partials/sidebar/logged-out-menu.tpl -->
	                        </ul>
	                        {{{ end }}}
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
        <main id="content" class="d-flex flex-column gap-3 flex-grow-1 mt-3" style="min-width: 0;">
