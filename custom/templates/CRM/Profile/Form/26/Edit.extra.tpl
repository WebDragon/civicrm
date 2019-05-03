{literal}
	<script>
		if (cj('#state_province-Primary').val() !== undefined) {
			state_province_id = cj('#state_province-Primary').val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				// console.log(data);
				cj('#county-Primary').empty();
				cj('#county-Primary').append('<option value="">- select state -</option>');
				cj.each(data, function(i, optionHTML) {
					cj('#county-Primary').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		} 

		cj('#state_province-Primary').change(function() {
			state_province_id = cj(this).val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				console.log(data);
				cj('#county-Primary').empty();
				cj('#county-Primary').append('<option value="">- select state -</option>');
				cj.each(data, function(i, optionHTML) {
					cj('#county-Primary').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		});
	</script>
{/literal}