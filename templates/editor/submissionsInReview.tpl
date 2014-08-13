{**
 * templates/editor/submissionsInReview.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in review.
 *}

<div id="submissions">
<table width="100%" class="table table-condensed table-hover">
	<thead>
		<tr class="heading" valign="bottom">
			<td width="5%">{sort_search key="common.id" sort="id"}</td>
			<td width="5%"><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_search key="submissions.submitted" sort="submitDate"}</td>
			<td width="5%">{sort_search key="submissions.sec" sort="section"}</td>
			<td width="15%">{sort_search key="article.authors" sort="authors"}</td>
			<td width="30%">{sort_search key="article.title" sort="title"}</td>
			<td width="30%">
				{translate key="submission.peerReview"}
				<table width="100%" class="nested">
					<tr valign="top">
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.ask"}</td>
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.due"}</td>
						<td width="34%" style="padding: 0 4px 0 0; font-size: 1.0em">{translate key="submission.done"}</td>
					</tr>
				</table>
			</td>
			<td width="5%">{translate key="submissions.ruling"}</td>
			<td width="5%">{translate key="article.sectionEditor"}</td>
		</tr>
	</thead>
	<tbody>
		{iterate from=submissions item=submission}
		{assign var="highlightClass" value=$submission->getHighlightClass()}
		{assign var="fastTracked" value=$submission->getFastTracked()}
		<tr onclick="window.location = '{url op="submissionReview" path=$submission->getId()}'" valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
			<td>{$submission->getId()}</td>
			<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
			<td>{$submission->getSectionAbbrev()|escape}</td>
			<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
			<td><a href="{url op="submissionReview" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></td>
			<td>
				<table width="100%">
				{foreach from=$submission->getReviewAssignments() item=reviewAssignments}
					{foreach from=$reviewAssignments item=assignment name=assignmentList}
						{if not $assignment->getCancelled() and not $assignment->getDeclined()}
						<tr valign="top">
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateNotified()}{$assignment->getDateNotified()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
							<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateCompleted() || !$assignment->getDateConfirmed()}&mdash;{else}{$assignment->getWeeksDue()|default:"&mdash;"}{/if}</td>
							<td width="34%" style="padding: 0 4px 0 0; font-size: 1.0em">{if $assignment->getDateCompleted()}{$assignment->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
						</tr>
						{/if}
					{foreachelse}
					<tr valign="top">
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
						<td width="34%" style="padding: 0 0 0 0; font-size: 1.0em">&mdash;</td>
					</tr>
					{/foreach}
				{foreachelse}
					<tr valign="top">
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
						<td width="33%" style="padding: 0 4px 0 0; font-size: 1.0em">&mdash;</td>
						<td width="34%" style="padding: 0 0 0 0; font-size: 1.0em">&mdash;</td>
					</tr>
				{/foreach}
				</table>
			</td>
			<td>
				{foreach from=$submission->getDecisions() item=decisions}
					{foreach from=$decisions item=decision name=decisionList}
						{if $smarty.foreach.decisionList.last}
								{$decision.dateDecided|date_format:$dateFormatTrunc}				
						{/if}
					{foreachelse}
						&mdash;
					{/foreach}
				{foreachelse}
					&mdash;
				{/foreach}
			</td>
			<td>
				{assign var="editAssignments" value=$submission->getEditAssignments()}
				{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()|escape} {/foreach}
			</td>
		</tr>
	{/iterate}
	{if $submissions->wasEmpty()}
		<tr>
			<td colspan="8" class="nodata">{translate key="submissions.noSubmissions"}</td>
		</tr>
	{else}
		<tr>
			<td colspan="5" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
			<td colspan="3" align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
		</tr>
	{/if}
	</tbody>
</table>
</div>
<div class="clearfix row col-md-12">
	<h4>{translate key="common.notes"}</h4>
	{translate key="editor.submissionReview.notes"}
</div>

