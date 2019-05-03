{literal}
	<script>
		cj('#Main').addClass('form-horizontal');
		cj('.crm-group .crm-section, .Available_Workshops-content').addClass('control-group');
		cj('label').not('.Available_Workshops-section label').addClass('control-label');
		cj('.crm-group .content, .price-set-row').addClass('controls');

		cj('#priceset .content').not('.Available_Workshops-content').addClass('pull-left');
		cj('#priceset .content').not('.Available_Workshops-content,.payment_processor-section').css({width:'160px','text-align':'right'});

		//Fix for Available_Workshops checkboxes
		// cj('.Available_Workshops-content .control-group').removeClass('content Available_Workshops-content')
		cj('.Available_Workshops-section div.label').removeClass('label').addClass('grouplabel');
		cj('.price-set-row label').each(function() {
			cj(this).addClass('checkbox');
			var fieldName = cj(this).attr('for').replace(/([;&,\.\+\*\~':"\!\^#$%@\[\]\(\)=>\|])/g, '\\$1');
			var contentField = cj('#'+fieldName).detach();
			cj(this).prepend(contentField);
		});

		//Fix Yes/No for client programs
		cj('.payment_processor-section  .controls').removeClass('content');
		cj('.payment_processor-section  div.label').removeClass('label').addClass('grouplabel');
		var paymentoptsLabel = cj('.payment_processor-section  label').html();
		cj('.payment_processor-section  div.label').html(paymentoptsLabel);
		cj('.payment_processor-section  .label label').detach();
		cj('.payment_processor-section  .controls label').each(function() {
			cj(this).addClass('radio');
			cj(this).css('text-align','left');
			var fieldName = cj(this).attr('for');
			var contentField = cj('#'+fieldName).detach();
			cj(this).prepend(contentField);
			cj('#'+fieldName).removeClass('form-radio');
			cj(this).after('<div class="clear"></div>');
		});

		cj('.payment_processor-section   span.crm-clear-link').hide();
	</script>
{/literal}