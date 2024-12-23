'use strict';

$(document).ready(function() {
	setupNProgress();
	
	$(window).on('action:ajaxify.start', function () {
		require(['bootstrap'], function (boostrap) {
			const offcanvas = boostrap.Offcanvas.getInstance('#offcanvas');
			if (offcanvas) {
				offcanvas.hide();
			}
		});
	});

	function setupNProgress() {
		require(['nprogress'], function (NProgress) {
			if (NProgress) {
				$(window).on('action:ajaxify.start', function () {
					NProgress.set(0.7);
				});

				$(window).on('action:ajaxify.end', function () {
					NProgress.done();
				});
			}
		});
	}
});