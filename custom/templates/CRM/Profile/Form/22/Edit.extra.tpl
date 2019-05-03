{literal}
	<script>
		cj('#Edit').addClass('form-horizontal');
		cj('.crm-section').addClass('control-group');
		cj('label').not(':#editrow-preferred_communication_method label, :#editrow-do_not_phone label, :#editrow-custom_20 label, :#editrow-custom_24 label').addClass('control-label');
		cj('.crm-section .content').not('#editrow-custom_19, #editrow-custom_20 .content').addClass('controls');
		cj('#Edit div').not('#editrow-custom_19, #editrow-custom_20 .content').removeClass('edit-value content');
		
		// cj('.form-layout-compressed .content').css({'margin-left':'10px'});


		
		//Fix inline checkbox for Do Not Phone at Work
		cj('#editrow-do_not_phone div.label').removeClass('label').addClass('controls');
		cj('#editrow-do_not_phone label').addClass('checkbox');
		var doNotPhoneContent = cj('#editrow-do_not_phone .content input').detach();
		cj('#editrow-do_not_phone label').prepend(doNotPhoneContent);
		
		//Fix inline checkboxes for comm prefs
		// cj('#editrow-preferred_communication_method .controls').removeClass('edit-value content')
		// cj('#editrow-preferred_communication_method div.label').removeClass('label').addClass('grouplabel');
		commPrefsLabel = cj('#editrow-preferred_communication_method div.label label').addClass('control-label').detach();
		cj('#editrow-preferred_communication_method div.label').remove();
		cj('#editrow-preferred_communication_method').prepend(commPrefsLabel);
		cj('#editrow-preferred_communication_method .controls').css('margin-left','200px');
		cj('#editrow-preferred_communication_method .controls label').each(function() {
			cj(this).addClass('checkbox');
			var fieldName = cj(this).attr('for').replace(/([;&,\.\+\*\~':"\!\^#$%@\[\]\(\)=>\|])/g, '\\$1');
			var contentField = cj('#'+fieldName).detach();
			cj(this).prepend(contentField);
		});

		//Fix inline checkboxes for interests
		cj('#editrow-custom_20').children().closest('.content').addClass('controls').removeClass('edit-value content');
		var InterestsLabel = cj('#editrow-custom_20 label').html();
		cj('#editrow-custom_20').prepend('<label class="control-label">'+InterestsLabel+'</label>');
		cj('#editrow-custom_20').children().closest('.label').remove();
		cj('#editrow-custom_20 .controls').css('margin-left','200px');
		cj('#editrow-custom_20 table.form-layout-compressed').find('tr').find('.labels').each(function(){
			interestOption = cj(this).html();
			cj('#editrow-custom_20 .controls').append(interestOption+'<br/>');
			cj(this).remove();	
		});
		
		relatedFields = {
			'health_screening': 'custom_21',
			'healthlink_contributor': 'custom_22',
			'other': 'custom_23'
		};

		cj.each(relatedFields, function(i, value) {
			// Move Label
			var relatedLabel = cj('#editrow-custom_20 table.form-layout-compressed').find('.subsection').find('label[for="'+value+'"]').detach();
			var relatedInput = cj('#editrow-custom_20 table.form-layout-compressed').find('#'+value).detach();
			cj('#relatedField-'+value).remove();
			cj('#editrow-custom_20 label[for="custom_20_'+i+'"]').after('<div class="subsection" style="display:none" id="relatedField-'+value+'"></div>');
			cj('#relatedField-'+value).append(relatedLabel);
			cj('#relatedField-'+value+' label').after('<br/>');
			cj('#relatedField-'+value).append(relatedInput)
		});

		cj('#editrow-custom_20 table').remove();


		//Fix Yes/No for client programs
		// cj('#editrow-custom_24 .controls').removeClass('edit-value content');
		cj('#editrow-custom_24 div.label').removeClass('label').addClass('grouplabel');
		var InterestsLabel = cj('#editrow-custom_24 label').html();
		cj('#editrow-custom_24 div.label').html(InterestsLabel);
		cj('#editrow-custom_24 .label label').detach();
		cj('#editrow-custom_24 .controls label').each(function() {
			cj(this).addClass('radio');
			var fieldName = cj(this).attr('for');
			var contentField = cj('#'+fieldName).detach();
			cj(this).prepend(contentField);
			cj('#'+fieldName).removeClass('form-radio');
			cj(this).after('<div class="clear"></div>');
		});

		cj('#editrow-custom_24 span.crm-clear-link').hide();



		// cj('#editrow-custom_19, .crm-submit-buttons, .grouplabel').css({'margin-left':'140px'});
		countiesToWorkIn = cj('#editrow-custom_19 div.label label').detach();
		cj('#editrow-custom_19 div.label').remove();
		cj('#editrow-custom_19').prepend(countiesToWorkIn);


		cj('#relatedField-custom_21,#relatedField-custom_22,#relatedField-custom_23').hide();

		cj('input[name="custom_20[health_screening]"]').change(function() {
			cj('#relatedField-custom_21').toggle();
		});

		cj('input[name="custom_20[healthlink_contributor]"]').change(function() {
			cj('#relatedField-custom_22').toggle();
		});

		cj('input[name="custom_20[other]"]').change(function() {
			cj('#relatedField-custom_23').toggle();
		});

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


		// cj().crmAPI ('constant','get',{name:'county'});

	</script>
{/literal}