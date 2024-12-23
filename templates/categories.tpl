				<div data-widget-area="header">
					{{{ each widgets.header }}}
						{{widgets.header.html}}
					{{{ end }}}
				</div>
				<div class="nodebbWidth nodebbWidth--main-content">
					<div class="nodebbContentWrap">
						<div class="nodebbLayout__columns">
							<section class="nodebbLayout__primary-column">
								<section class="cWidgetContainer cWidgetContainer--main" data-role="widgetReceiver">
									<section data-role="widgetReceiver" data-orientation="horizontal" data-widgetarea="header" data-widget-layout="table" data-widget-area-id="1" data-widget-full-width-items="" data-widget-show-images="1" data-widget-orientation="horizontal" data-restrict-nesting="1" class="cWidgetContainer cWidgetContainer--isWidget" group-data="">
										<div class="nodebbWidget__content--wrap">
											<div data-blocktitle="Custom Blocks" data-blockid="app_cms_Blocks_4510589" data-blockerrormessage="This block cannot be shown. This could be because it needs configuring, is unable to show on this page, or will show after reloading this page." data-menustyle="menu" data-blockconfig="1" data-controller="core.front.widgets.block" class="nodebbWidget nodebbWidget--horizontal">
												<div class="fullwidth cnjNodeBB">
													<div class="cnjNodeBB-wrapper">
														<div class="cnjNodeBB-cardWrapper">
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
											</div>
										</div>
									</section>
									<!-- IMPORT partials/recent.tpl -->
								</section>
							</section>
							<!-- An if statement needs to go here if sidebar is active -->
							<aside id="nodebbLayout_sidebar" data-widget-area="sidebar" class="nodebbLayout__secondary-column" data-controller="core.front.widgets.sidebar" group-data="">
								<div class="nodebbLayout__secondary-sticky-outer">
									<div class="nodebbLayout__secondary-sticky-inner" data-nodebb-hook="sidebar">
										<section id="sidebar" data-orientation="vertical" data-widgetarea="sidebar" data-widget-layout="wrap" data-widget-area-id="0" data-restrict-nesting="1" class="cWidgetContainer cWidgetContainer--main">
											<section id="top_posters" data-role="widgetReceiver" data-orientation="vertical" data-widgetarea="sidebar" data-widget-layout="featured" data-widget-area-id="4" data-widget-full-width-items="" data-widget-show-images="1" data-widget-orientation="vertical" data-restrict-nesting="1" class="cWidgetContainer cWidgetContainer--isWidget" style="--i-widget--gap: 0px; --i-widget--size: 100%; --i-widget--padding-block: 0; --i-widget--padding-inline: 0;">
												<!-- IMPORT widgets/topposters.tpl -->
											</section>
										</section>
									</div>
								</div>
							</aside>
							<!-- end the sidebar if statement -->
						</div>
					</div>
				</div>
