# Make form_with behave reasonably
# https://stackoverflow.com/questions/47822826/set-local-true-as-default-for-form-with-in-rails-5/51666415#51666415
Rails.application.config.action_view.form_with_generates_remote_forms = false
