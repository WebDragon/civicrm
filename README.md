# Customisations

## General notes

- Templatename.extra.tpl is included into Templatename.tpl if discovered. This is an easy way to add snippets (eg JS/CSS) to a template without having to change the core template (simplifies upgrades). [docs](https://docs.civicrm.org/dev/en/latest/framework/templates/#appending-jquery-or-other-code-to-a-template)
- Overrides with an integer in the path apply only to a single entity, eg in the first instance the override will only apply to the Contribute page with id=22. [docs](https://docs.civicrm.org/dev/en/latest/framework/templates/#scenario-the-contact-summary-screen-needs-to-be-changed)
- If a customisation is to `path/to/2/something.php`, the base template to refer to is `path/to/something.php`.
- First thing I'd check would be what you can drop immediately. The ones named `2b` can go. If any of contribution pages 1, 2, 3, 21, 22 or 26 are not actively used, you can drop the matching customisations from your requirements.

## Specific notes

### `CRM/Contribute/Form/Contribution/2/Confirm.php`

- Changes the contribute confirmation process for the contribution page id=2 only.
- Looks like someone was trying to handle zero-payment contributions or defend against negative payments, from the debug and commented code?
- Seems to contain a bailout (`JExit()`) which suggests it's not in active use and might be removed. Check if you are using or receiving payments via Contribute page id=2.

### `CRM/Profile/Form/22/ajax.php`

- Fetches appropriate counties based on the selected province
- Looks like there is exploitable SQLi in this file
- Should be possible to use CiviCRM API to do this. The query in JS would be:

```js
CRM.api3('Address', 'getoptions', {
  "key": "county_id",
  "state_province_id": 1004,
  "field": "county_id"
}).done(function(result) {
  // do something with your API result here
});
```

### `templates/CRM/Contribute/Form/Contribution/1/Confirm.tpl`

- Debug only, can probably be removed?

### `templates/CRM/Contribute/Form/Contribution/1/Main.extra.tpl`

- Adds some CSS classes and rules (could also be done by Smarty templating)
- When State is changed, update the list of available Counties.

### `templates/CRM/Contribute/Form/Contribution/1/Main.tpl`

- Removes sections of template which should only be displayed if `$honor_block_is_active`, `$pledgeBlock`, `$form.is_recur`, `$pcp` anyway. Those changes may not need to exist if the contribute page is configured to not show them?
- Comments out a `<div class="label">&nbsp;</div>` presumably for layout reasons.
- The below change looks like a legit bugfix? But that line [doesn't exist](https://github.com/civicrm/civicrm-core/blob/master/templates/CRM/Contribute/Form/Contribution/Main.tpl) in current CiviCRM.

```diff
-    {include file="CRM/common/paymentBlock.tpl'}
+    {include file="CRM/common/paymentBlock.tpl"}
```

### `templates/CRM/Contribute/Form/Contribution/2/Main.extra.tpl`

- Seems to be all about layout customisations, but there's a lot here!

### `templates/CRM/Contribute/Form/Contribution/2b/Confirm.tpl` & `templates/CRM/Contribute/Form/Contribution/2b/Main.extra.tpl`

- I believe these are unused templates, since `2b` isn't a valid contribute page ID.

### `templates/CRM/Contribute/Form/Contribution/3/Main.extra.tpl`

- Layout changes AFAICT.

### `templates/CRM/Price/Form/Calculate.tpl`

- Special handling to multiply total fee by whatever's in input field custom_27.

### `templates/CRM/Price/Form/PriceSet.extra.tpl`

- Adds an empty script tag. Might be unused or some weird layout workaround for horrid browsers :)

### `templates/CRM/Price/Form/PriceSet.tpl`

- Adds some wrapper elements to labels.

### `templates/CRM/Profile/Form/21/Edit.extra.tpl`

- Adds county selection JS.

### `templates/CRM/Profile/Form/22/Dynamic.tpl`

- Displays related fields. IDK what this is doing to be honest.

### `templates/CRM/Profile/Form/22/Edit.extra.tpl`

- Lots of JS to do layout things. I didn't read this fully :)

### `templates/CRM/Profile/Form/22/Edit.tpl`

- Includes `22/Dynamic.tpl` above.

### `templates/CRM/Profile/Form/26/Edit.extra.tpl`

- County selection again.

### `templates/CRM/Profile/Form/26/Edit.tpl`

- Requires authenticated user to view this form. Suggest checking this from a CiviCRM extension (eg by implementing similar check in [`hook_civicrm_buildForm()`](https://docs.civicrm.org/dev/en/latest/hooks/hook_civicrm_buildForm/)) rather than at template layer.
