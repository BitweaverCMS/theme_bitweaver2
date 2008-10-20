{strip}
{include file="bitpackage:fisheye/gallery_nav.tpl"}

<div class="display fisheye">
	<div class="floaticon">
		{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='icon' serviceHash=$gContent->mInfo}
		{if $gContent->hasUserPermission('p_fisheye_edit')}
			<a title="{tr}Edit{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}edit_image.php?image_id={$gContent->mImageId}">{biticon ipackage="icons" iname="accessories-text-editor" iexplain="Edit Image"}</a>
			<a title="{tr}Delete{/tr}" href="{$smarty.const.FISHEYE_PKG_URL}edit_image.php?image_id={$gContent->mImageId}&amp;delete=1">{biticon ipackage="icons" iname="edit-delete" iexplain="Delete Image"}</a>
		{/if}
	</div>

	{formfeedback hash=$feedback}

	<div class="header">
		<h1>{$gContent->getTitle()|default:$gContent->mInfo.image_file.filename|escape}</h1>
	</div>

	<div class="body">
		{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='body' serviceHash=$gContent->mInfo}
		{box class="box image"}
			<img src="{$gContent->mInfo.display_url}{$refresh}" alt="{$gContent->getTitle()|default:$gContent->mInfo.image_file.filename|escape}" title="{$gContent->mInfo.data|default:$gContent->mInfo.filename|escape}" />
			<p class="sizes">
				{foreach name=size key=size from=$gContent->mInfo.image_file.thumbnail_url item=url}
					{if $url != $gContent->mInfo.display_url}<a href="{$gContent->getDisplayUrl(0,$size)|escape}">{/if}{tr}{$size}{/tr}{if $url != $gContent->mInfo.display_url}</a>{/if}
					{if !$smarty.foreach.size.last}&nbsp;|&nbsp;{/if}
				{/foreach}
				{if $gContent->hasUpdatePermission() || $gGallery && $gGallery->getPreference('link_original_images')}
					&nbsp;|&nbsp;
					<a href="{$gContent->mInfo.image_file.source_url|escape}">{tr}Original{/tr}</a>
					{if $gContent->mInfo.width && $gContent->mInfo.height}
						&nbsp;{$gContent->mInfo.width}x{$gContent->mInfo.height}
					{/if}
				{/if}
			</p>

			{if $gBitSystem->isFeatureActive('fisheye_image_list_description') and $gContent->mInfo.data ne ''}
				<p>{$gContent->mInfo.data|escape}</p>
			{/if}
		{/box}

		{if $gBitUser->hasPermission( 'p_liberty_attach_attachments' )}
			<p class="formhelp">
				{tr}Attachment{/tr}: {ldelim}attachment id={$gContent->mInfo.image_file.attachment_id}{rdelim}
			</p>
		{/if}
	</div>	<!-- end .body -->

	{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='view' serviceHash=$gContent->mInfo}

	{if $gGallery && $gGallery->getPreference('allow_comments') eq 'y'}
		{include file="bitpackage:liberty/comments.tpl"}
	{/if}

</div>	<!-- end .fisheye -->
{/strip}
