function New-HB-Form-Question
{
	param (
		[string]$form_id,
		[string]$question,
		[string]$question_id,
		[string]$answer,
		[string]$answer_value,
		[string]$field_type,
		[string]$entity_type
	)

	$newObject = @{
		form_id      = $form_id
		question     = $question
		question_id  = $question_id
		answer       = $answer
		answer_value = $answer_value
		field_type   = $field_type
		entity_type  = $entity_type
		hbfield      = @{
			question = $question
			field    = @{
				id               = $question_id
				defLabel         = $question
				transLabel       = 'x'
				binding          = "global.$form_id.$question_id"
				noInvisibleValue = $false
				design           = @{
					isVisible   = $true
					isMandatory = $false
					isReadOnly  = $false
					showIfEmpty = $false
					extraClass  = ' '
				}
				control          = @{
					type = $field_type
				}
				uid              = ''
			}
			value    = $answer_value
		}
	}

	return $newObject

}

<# Example usage

	# Define empty array
	$questions = @()

	# Add question to array. Run as many times as necessary
	$questions += New-HB-Form-Question `
		-form_id 'form_1' `
		-question 'Who is the leaver?' `
		-question_id 'h_custom_h' `
		-answer "$leaver_user_name" `
		-answer_value "$leaver_user_username" `
		-field_type 'text' `
		-entity_type 'request'

	# When ready to run the API to log a ticket, include the questions converted to JSON
	# (Below is a custom function to make it easy to run the logServiceRequest API)
		$leavers_raise_request = New-HB-ServiceRequest `
			-instanceName $hornbill_instanceName `
			-instanceZone $hornbill_instanceZone `
			-instanceKey $hornbill_APIKey `
			-summary $leavers_summary `
			-serviceName "Leavers" `
			-catalogName "Log a Leaver request" `
			-sourceType "Business World On" `
			-teamId "HornbillTesting" `
			-priorityName "Priority 4" `
			-questions ($questions | ConvertTo-Json -Compress)
#>
