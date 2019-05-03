{literal}
	<script>
		cj('#Main').addClass('form-horizontal');
		cj('.crm-section, .Module_Review_Fee-content').addClass('control-group');
		cj('label').not('.Module_Review_Fee-section label').addClass('control-label');
		cj('.content, .price-set-row').addClass('controls');
		cj('.controls').not('.Module_Review_Fee-content').removeClass('content');


		//Fix for custom field 27
		custom27_label = cj('.form-layout-compressed').find('label[for=custom_27]').detach();
		custom27_field = cj('.form-layout-compressed').find('#custom_27').detach();
		cj('.form-layout-compressed').after('<div class="control-group" id="custom27_group"></div>');
		cj('#custom27_group').append(custom27_label);
		cj('#custom27_group').append('<div class="controls"></div>');
		cj('#custom27_group .controls').append(custom27_field);
		cj('#custom_27').addClass('input-mini');

		//Fix for custom field 28
		custom28_label = cj('.form-layout-compressed').find('.label label').detach();
		custom28_field = cj('.form-layout-compressed').find('input[name="custom_28"]').detach();
		cj('#custom27_group').after('<div class="control-group" id="custom28_group"></div>');
		cj('#custom28_group').append(custom28_label);
		cj('#custom28_group').append('<div class="controls controls-row"></div>');
		cj('#custom28_group .controls').css('padding-left', '10px');
		cj.each(custom28_field, function(i,value) {
			var id = cj(this).attr('id');
			cj('label[for="'+id+'"]').removeClass('control-label').addClass('radio span3').append(value);
			cj('#'+id).removeClass('form-radio');
		});
		custom28_optlabels = cj('.form-layout-compressed').find('label').detach();
		cj('#custom28_group .controls').append(custom28_optlabels);

		cj('.form-layout-compressed').remove();
		


		cj('#priceset .content').not('.Module_Review_Fee-content').addClass('pull-left');
		cj('#priceset .content').not('.Module_Review_Fee-content, .payment_processor-section').css({width:'160px','text-align':'right'});

		//Fix for Module_Review_Fee checkboxes
		// cj('.Module_Review_Fee-content .control-group').removeClass('content Module_Review_Fee-content')
		cj('.Module_Review_Fee-section div.label').removeClass('label').addClass('grouplabel');
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