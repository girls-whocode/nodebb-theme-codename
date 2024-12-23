
					{{{ each widgets.footer }}}
						{{widgets.footer.html}}
					{{{ end }}}
            	</main>
			</div><!-- /.container#content -->
			<!-- IMPORT partials/mobile-footer.tpl -->
			{{{ if !isSpider }}}
			<div>
				<div component="toaster/tray" class="alert-window fixed-bottom mb-5 mb-md-2 me-2 me-md-5 ms-auto" style="width:300px; z-index: 1090;">
					<!-- IMPORT partials/reconnect-alert.tpl -->
				</div>
			</div>
			{{{ end }}}
	</body>
</html>
