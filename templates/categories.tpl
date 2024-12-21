				<div data-widget-area="header">
					{{{ each widgets.header }}}
						{{widgets.header.html}}
					{{{ end }}}
				</div>
                <main class="py-4">
                    <div class="nodebbWidth nodebbWidth--main-content">
                        <div class="nodebbContentWrap">
                            <div class="nodebbLayout__columns">
                                <section class="nodebbLayout__primary-column">
                                    <section class="cWidgetContainer cWidgetContainer--main" data-role="widgetReceiver" style="">
										<section data-role="widgetReceiver" data-orientation="horizontal" data-widgetarea="header" data-widget-layout="table" data-widget-area-id="1" data-widget-full-width-items="" data-widget-show-images="1" data-widget-orientation="horizontal" data-restrict-nesting="1" class="cWidgetContainer cWidgetContainer--isWidget" group-data="">
											<div class="nodebbWidget__content--wrap">
												<div data-blocktitle="Custom Blocks" data-blockid="app_cms_Blocks_4510589" data-blockerrormessage="This block cannot be shown. This could be because it needs configuring, is unable to show on this page, or will show after reloading this page." data-menustyle="menu" data-blockconfig="1" data-controller="core.front.widgets.block" class="nodebbWidget nodebbWidget--horizontal">
													<div class="fullwidth cnjNodeBB"><div class="cnjNodeBB-wrapper"><div class="cnjNodeBB-cardWrapper">
														<div class="row py-2">
															<div class="{{{ if widgets.sidebar.length }}}col-lg-9 col-sm-12{{{ else }}}col-lg-12{{{ end }}}">
																{{{ if pagination.pages.length }}}
																<div><!-- IMPORT partials/category/selector-dropdown-left.tpl --></div>
																{{{ end }}}
																<ul class="categories-list list-unstyled" itemscope itemtype="http://www.schema.org/ItemList">
																	{{{ each categories }}}
																		<!-- IMPORT partials/categories/item.tpl -->
																	{{{ end }}}
																</ul>
																<!-- IMPORT partials/paginator.tpl -->
															</div>
														</div>
													</div>
												</div>
											</div>
										</section>
										<!-- IMPORT partials/latest.tpl -->
									</section>
								</section>
                                <aside id="nodebbLayout_sidebar" class="nodebbLayout__secondary-column" data-controller="core.front.widgets.sidebar" group-data="">
                                    <div class="nodebbLayout__secondary-sticky-outer">
                                        <div class="nodebbLayout__secondary-sticky-inner" data-nodebb-hook="sidebar">
                                            <section data-role="widgetReceiver" data-orientation="vertical" data-widgetarea="sidebar" data-widget-layout="wrap" data-widget-area-id="0" data-restrict-nesting="1" class="cWidgetContainer cWidgetContainer--main">
                                                <!-- IMPORT partials/sidebar.tpl -->
                                            </section>
                                        </div>
                                    </div>
                                </aside>
							</div>
						</div>
					</div>
					<div data-widget-area="footer">
						{{{ each widgets.footer }}}
							{{widgets.footer.html}}
						{{{ end }}}
					</div>
