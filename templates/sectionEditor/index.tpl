{**
 * templates/sectionEditor/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Section editor index.
 *
 *}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{url|assign:"currentUrl" page="sectionEditor"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '<h2>{translate key="article.submissions"}</h2>';
</script>

<ul class="nav nav-tabs nav-justified">
	<li role="presentation"{if ($pageToDisplay == "submissionsInReview")} class="active"{/if}><a href="{url path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a></li>
	<li role="presentation"{if ($pageToDisplay == "submissionsInEditing")} class="active"{/if}><a href="{url path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing}</a></li>
	<li role="presentation"{if ($pageToDisplay == "submissionsArchives")} class="active"{/if}><a href="{url path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
</ul>

{if !$dateFrom}
{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
{assign var="dateTo" value="--"}
{/if}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<div class="col-md-12 well">
<form method="post" id="submit" action="{url op="index" path=$pageToDisplay}">
	<div class="col-md-12">
		<div class="col-md-2" style="padding-top: 5px;font-weight: bold;text-align: center;">{translate key="editor.submissions.inSection"}</div>
		<div class="col-md-10"><select name="filterSection" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$filterSection}</select></div>
	</div>
	<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>
	{if $section}<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>{/if}
	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<div class="col-md-12">
		<div class="col-md-2">
			<select name="searchField" size="1">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile" style="text-align: center;"><i class="material-icons">forward</i></div>
		<div class="col-md-2">
			<select name="searchMatch" size="1">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile" style="text-align: center;"><i class="material-icons">forward</i></div>
		<div class="col-md-6" >
			<input type="text" size="15" name="search" value="{$search|escape}" />
		</div>
	</div>
	<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>
	<div class="col-md-12">
		<div class="col-md-3">
			<select name="dateSearchField" size="1">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		<div class="col-md-2" style="text-align: center;padding-top:5px">{translate key="common.between"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" style="display:none"/>
		</div>
		<div class="col-md-1" style="text-align: center;padding-top:5px">{translate key="common.and"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" style="display:none"/>
		</div>
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	<div class="col-md-3 col-md-offset-5" >
		<input type="submit" value="{translate key="common.search"}" class="btn btn-success btn-lg btn-block" style="margin-top:10px" />
	</div>
</form>
</div>

<div class="clearfix"></div>

{include file="sectionEditor/$pageToDisplay.tpl"}

{if ($pageToDisplay == "submissionsInReview")}
<br />
<div id="notes">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionReview.notes"}
</div>
{elseif ($pageToDisplay == "submissionsInEditing")}
<br />
<div id="notes">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionEditing.notes"}
</div>
{/if}

{include file="common/footer.tpl"}

