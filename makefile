pre-action:
	dart minha_app/scripts/action.dart -b $(brand) -e $(env) -p $(platform) -v $(version_name) -r $(version_code)
get:
	minha_app/scripts/ci.sh --get
clean:
	minha_app/scripts/ci.sh --clean
