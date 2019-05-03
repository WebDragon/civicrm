{literal}
	<script>
		cj('#Main').addClass('form-horizontal');
		cj('.crm-group .crm-section').addClass('control-group');
		cj('label').addClass('control-label');
		cj('.crm-group .content').addClass('controls');

		cj('#priceset .content').addClass('pull-left');
		cj('#priceset .content').css({width:'160px','text-align':'right'});
		cj('#priceset .control-label').css({'text-align':'left'});

		if (cj('#state_province-Primary, #onbehalf_state_province-3').val() !== undefined) {
			state_province_id = cj('#state_province-Primary, #onbehalf_state_province-3').val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				// console.log(data);
				cj('#county-Primary, #onbehalf_county-Primary').empty();
				cj('#county-Primary, #onbehalf_county-Primary').append('<option value="">- select state -</option>');
				cj.each(data, function(i, optionHTML) {
					cj('#county-Primary, #onbehalf_county-Primary').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		} 

		cj('#state_province-Primary, #onbehalf_state_province-3').change(function() {
			state_province_id = cj(this).val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				console.log(data);
				cj('#county-Primary, #onbehalf_county-Primary').empty();
				cj('#county-Primary, #onbehalf_county-Primary').append('<option value="">- select state -</option>');
				cj.each(data, function(i, optionHTML) {
					cj('#county-Primary, #onbehalf_county-Primary').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		});
	</script>
{/literal}