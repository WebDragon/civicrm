{literal}

<script>
	if (cj('#state_province-1').val() !== undefined) {
			state_province_id = cj('#state_province-1').val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				// console.log(data);
				cj('#county-1').empty();
				if (typeof(state_province_id) === undefined) {
					cj('#county-1').append('<option value="">- select your state first -</option>');	
				} else {
					cj('#county-1').append('<option value="">- select a county -</option>');
				}
				
				cj.each(data, function(i, optionHTML) {
					cj('#county-1').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		} 

		cj('#state_province-1').change(function() {
			state_province_id = cj(this).val();
			cj.post('ajax.php',{state_province_id: state_province_id},function(data) {
				console.log(data);
				cj('#county-1').empty();
				if (typeof(state_province_id) === undefined) {
					cj('#county-1').append('<option value="">- select your state first -</option>');	
				} else {
					cj('#county-1').append('<option value="">- select a county -</option>');
				}
				cj.each(data, function(i, optionHTML) {
					cj('#county-1').append('<option value="'+optionHTML.id+'">'+optionHTML.name+'</option>');
				});
			}, 'json');
		});
</script>

{/literal}