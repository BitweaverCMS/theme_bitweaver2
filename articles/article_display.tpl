{* $Header: /cvsroot/bitweaver/_bit_styles/bitweaver2/articles/article_display.tpl,v 1.1 2007/03/16 04:59:39 laetzer Exp $ *}
{strip}
{if !$showDescriptionsOnly}
	{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='nav' serviceHash=$article}
{/if}

<div class="{$outer_div|default:"post"}">
	<div class="floaticon">
		{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='icon' serviceHash=$article}
		{if $gBitUser->hasPermission( 'p_articles_read_history' ) && !$version && $article.version>1}
			{smartlink ititle="View History" ipackage=articles ifile="article_history.php" ibiticon="icons/appointment-new" article_id=$article.article_id}
		{/if}
		{if $gBitUser->hasPermission('p_articles_admin') || $gBitUser->getField('user_id') == $article.user_id}
			<a href="{$smarty.const.ARTICLES_PKG_URL}edit.php?article_id={$article.article_id}">{biticon ipackage="icons" iname="accessories-text-editor" iexplain=edit}</a>
		{/if}
		{*<a style="display:none;" href="{$smarty.const.ARTICLES_PKG_URL}print.php?article_id={$article.article_id}">{biticon ipackage="icons" iname="document-print" iexplain=print}</a>*}
		{if $gBitUser->hasPermission( 'p_articles_remove' )}
			{smartlink ititle="Remove" ipackage=articles ifile="list.php" ibiticon="icons/edit-delete" action=remove remove_article_id=$article.article_id status_id=$smarty.request.status_id}
		{/if}
	</div><!-- end .footer -->

	<div class="header">
			{if $showDescriptionsOnly and $article.has_more}
				<h1><a href="{$article.display_url}">{$article.title|escape}</a></h1>
			{else}
				<h1>{$article.title|escape}</h1>			
			{/if}
		{if $article.show_author eq 'y' || $article.show_pubdate eq 'y'}
			<div class="date">
				{if $article.show_author eq 'y'}
					{* can't really use the link here since it only works when the user uses his login name *}
					{displayname user=$article.author_name nolink=true}&nbsp;
				{/if}

				{if $article.show_pubdate eq 'y'}
					&bull; {$article.publish_date|reltime}
				{/if}
				<span class="info">
					{if $article.show_reads eq 'y'}
						{assign var=spacer value=TRUE}
						{$article.hits|default:0} {tr}reads{/tr}
					{/if}
				</span>
			</div><!-- end .date -->
		{/if}
	</div>

	<div class="body"{if $gBitUser->getPreference( 'users_double_click' ) and $gBitUser->hasPermission( 'p_articles_edit' )} ondblclick="location.href='{$smarty.const.ARTICLES_PKG_URL}edit.php?article_id={$article.article_id}';"{/if}>
		<div class="content">
			{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='body' serviceHash=$article}
			{if $article.show_image eq 'y' && $article.image_url}
				<div class="image">
					{if $showDescriptionsOnly and $article.has_more}<a href="{$article.display_url}">{/if}
						<img class="icon" alt="{$article.topic_name|default:$article.title|escape}" title="{$article.topic_name|default:$article.title|escape}" src="{$article.image_url}"/>
					{if $showDescriptionsOnly and $article.has_more}</a>{/if}
				</div>
			{/if}

			{if $article.use_ratings eq 'y'}
				<span class="rating">
					{repeat count=$article.rating}
						{biticon ipackage=articles iname=rating iexplain="Article Rating"}
					{/repeat}
					{math assign=rating_off equation="5-x" x=$article.rating}
					{repeat count=$rating_off}
						{biticon ipackage=articles iname=rating_off iexplain="Article Rating"}
					{/repeat}
				</span>
			{/if}

			{if $showDescriptionsOnly}
				{$article.parsed_description}
			{else}
				{$article.parsed_data}
			{/if}
	
			{if $showDescriptionsOnly and $article.has_more}
				{* if $spacer}&nbsp; &bull; &nbsp;{/if}
				{assign var=spacer value=TRUE *}
				<em class="more"><a href="{$article.display_url}">&nbsp;{tr}read more{/tr}</a></em>
			{/if}

		</div>

		<div class="footer">
			{if $article.allow_comments eq 'y'}
				{if $spacer}&nbsp; &bull; &nbsp;{/if}
				{if $showDescriptionsOnly}<a href="{$article.display_url}#editcomments">{/if}
					{tr}{$article.num_comments} Comment(s){/tr}
				{if $showDescriptionsOnly}</a>{/if}
			{/if}
		</div>

		{if $article.status_id == $smarty.const.ARTICLE_STATUS_PENDING && !$preview}
			<div class="row">
				{formlabel label="Approve or deny Submission"}
				{forminput}
					{if $gBitUser->hasPermission( 'p_articles_approve_submission' )}
						<a href="{$smarty.const.ARTICLES_PKG_URL}list.php?status_id={$article.status_id}&amp;article_id={$article.article_id}&amp;content_id={$article.content_id}&amp;set_status_id=300&amp;action=approve">{biticon ipackage=icons iname="large/dialog-ok" iexplain="Approve Article"}</a> &nbsp;
					{/if}

					{if $gBitUser->hasPermission( 'p_articles_remove' ) || $gBitUser->hasPermission( 'p_articles_remove_submission' )}
						<a href="{$smarty.const.ARTICLES_PKG_URL}list.php?status_id={$article.status_id}&amp;remove_article_id={$article.article_id}&amp;action=remove">{biticon ipackage=icons iname="large/dialog-cancel" iexplain="Remove Article"}</a>
					{/if}
				{/forminput}
			</div>
		{/if}

	</div><!-- end .body -->
</div><!-- end .article -->

{if $print_page ne 'y' and $article.allow_comments eq 'y' and !$preview && !$showDescriptionsOnly and $article.status_id eq $smarty.const.ARTICLE_STATUS_APPROVED}
	{include file="bitpackage:liberty/comments.tpl"}
{/if}

{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='view' serviceHash=$article}
{/strip}
