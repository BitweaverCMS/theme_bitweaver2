{strip}
<div class="body"{if $gBitUser->getPreference( 'users_double_click' ) and $gBitUser->hasPermission( 'p_wiki_edit_page' )} ondblclick="location.href='{$smarty.const.WIKI_PKG_URL}edit.php?page_id={$pageInfo.page_id}';"{/if}>
	<div class="content">
		{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='body' serviceHash=$gContent->mInfo}
		{if $gBitSystem->isFeatureActive( 'liberty_auto_display_attachment_thumbs' )}
			{include file="bitpackage:liberty/storage_thumbs.tpl"}
		{/if}
		{$pageInfo.parsed_data}
	</div>

	{if $gBitUser->isRegistered()}
		{include file="bitpackage:wiki/page_date_bar.tpl"}
	{/if}	

</div> <!-- end .body -->
{/strip}