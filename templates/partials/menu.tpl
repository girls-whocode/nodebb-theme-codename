                            <div data-nodebb-header-content="navigation" id="elPrimaNav">
                                <ul id="main-nav" class="nodebbNavBar">
                                    {{{each navigation}}}
                                    
                                    <li title="{navigation.title}">
                                        <a class="nav-link navigation-link" data-navigational="true" href="{navigation.route}" {{{ if navigation.id }}}id="{navigation.id}"{{{ end }}} {{{ if navigation.targetBlank }}} target="_blank"{{{ end }}}>
                                            {{{ if navigation.iconClass }}}
                                            <i class="fa fa-fw {navigation.iconClass}" data-content="{navigation.content}"></i>
                                            {{{ end }}}
                                            <span>{navigation.text}</span>
                                        </a>
                                    </li>
                                    
                                    {{{end}}}
                                </ul>
                                <ul class="navbar-nav mb-2 mb-lg-0 hidden-xs">
                                    <li>
                                        <a href="#" id="reconnect" class="nav-link hide" title="[[global:reconnecting-message, {config.siteTitle}]]">
                                            <i class="fa fa-check"></i>
                                        </a>
                                    </li>
                                </ul>
                                <!-- TODO: Test search bar -->
                                {{{ if (config.searchEnabled && user.privileges.search:content) }}}
                                <div class="navbar-nav mb-2 me-2 mb-lg-0 position-relative">
                                    <!-- IMPORT partials/header/search.tpl -->
                                </div>
                                {{{ end }}}
                            </div>
