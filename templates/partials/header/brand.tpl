{{{ if (brand:logo || (config.showSiteTitle || widgets.brand-header.length)) }}}
                    <div data-nodebb-header-position="4" class="nodebbHeader__start">
                        {{{ if (brand:logo || config.showSiteTitle) }}}
                        <div data-nodebb-header-content="logo">
                            {{{ if brand:logo }}}
                            <a component="brand/anchor" href="{{{ if brand:logo:url }}}{brand:logo:url}{{{ else }}}{relative_path}/{{{ end }}}" title="[[global:header.brand-logo]]" class="nodebbLogo nodebbLogo--desktop">
                                <picture class="nodebbLogo__image nodebbLogo__image--light">
                                    <img component="brand/logo" alt="{{{ if brand:logo:alt }}}{brand:logo:alt}{{{ else }}}[[global:header.brand-logo]]{{{ end }}}" src="{brand:logo}?{config.cache-buster}" data-nodebb-theme-image="logo-light" data-loaded="true">
                                </picture>
                                <picture class="nodebbLogo__image nodebbLogo__image--dark">
                                    <img component="brand/logo" alt="{{{ if brand:logo:alt }}}{brand:logo:alt}{{{ else }}}[[global:header.brand-logo]]{{{ end }}}" src="{brand:logo}?{config.cache-buster}" data-nodebb-theme-image="logo-dark" data-loaded="true">
                                </picture>
                            </a>
                            {{{ end }}}
                            {{{ if config.showSiteTitle }}}
                            <div class="nodebbLogo__text">
                                <a component="siteTitle" class="text-truncate align-self-stretch align-items-center d-flex" href="{{{ if title:url }}}{title:url}{{{ else }}}{relative_path}/{{{ end }}}">
                                    <span data-nodebb-theme-text="set__i-logo-text" class="nodebbLogo__name">{config.siteTitle}</span>
                                </a>
                                <span data-nodebb-theme-text="set__i-logo-slogan" class="nodebbLogo__slogan">{config.siteSlogan}</span>
                            </div>
                            {{{ end }}}
                            {{{ if widgets.brand-header.length }}}
                            <div data-widget-area="brand-header" class="flex-fill gap-3 p-2 align-self-center">
                                {{{each widgets.brand-header}}}
                                {{./html}}
                                {{{end}}}
                            </div>
                            {{{ end }}}
                        </div>
                        {{{ end }}}
                    </div>
{{{ end }}}