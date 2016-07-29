$(document).on('ready', function(){
		braintree.setup(gon.client_token, "dropin", {
		  container: "dropin"
		});
})
