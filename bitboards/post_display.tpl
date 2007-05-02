{strip}
{assign var='gContent' value=$comment}

{if $gBitUser->getPreference('boards_show_avatars','y') == y}
<div class="userinfo">
		{if $comment.user_id == $smarty.const.ANONYMOUS_USER_ID}
			<strong>{$comment.anon_name|escape}</strong>
		{else}
			<strong>{displayname hash=$comment}</strong>
			<br />
			{if $comment.user_id != $smarty.const.ANONYMOUS_USER_ID && !empty($comment.user_avatar_url)}
				<a href="{$comment.user_url}"><img src="{$comment.user_avatar_url}" title="{tr}Avatar{/tr}" alt="{tr}Avatar{/tr}" /></a>
				<br />
			{/if}
			<small>{tr}Joined: {/tr}{$comment.registration_date|bit_short_date}</small><br />
		{/if}
</div>
{/if}
<div class="body" id="{$comment.comment_id|escape}">
	<div class="content" {if $comments_style eq 'threaded' || $gBitUser->getPreference('boards_show_avatars','y') == y}style="{if $comments_style eq 'threaded'}padding-left:{math equation="level * marginIncrement +3 " level=$comment.level marginIncrement=20}px;{/if}{if $gBitUser->getPreference('boards_show_avatars','y') == y}margin-left: 14.5em;{/if}"{/if}>
		{if !$post_is_preview}


		<div class="header">
			{if $comment.title neq ""}<h2>{$comment.title|escape}</h2>{/if}
			<div class="date">
			<div class="floaticon">
				{if $print_page ne 'y' && $comment.deleted==0 }
					{if !$topic_locked && $gBitUser->hasPermission( 'p_liberty_post_comments' )}
						<a href="{$comments_return_url}&amp;post_comment_reply_id={$comment.content_id}&amp;post_comment_request=1#editcomments" rel="nofollow">{biticon ipackage="icons" iname="mail-reply-sender" iexplain="Reply to this Post" iforce="icon"}</a>
					{/if}
					{if !$topic_locked && $gBitUser->hasPermission( 'p_liberty_post_comments' )}
						<a href="{$comments_return_url}&amp;post_comment_reply_id={$comment.content_id}&amp;post_comment_request=1&amp;quote=y#editcomments" rel="nofollow">{biticon ipackage="icons" iname="mail-reply-all" iexplain="Reply with Quote to this Post" iforce="icon"}</a>
					{/if}
					{if $comment.editable}
						<a href="{$comments_return_url}&amp;post_comment_id={$comment.comment_id}&amp;post_comment_request=1#editcomments" rel="nofollow">{biticon ipackage="icons" iname="accessories-text-editor" iexplain="Edit" iforce="icon"}</a>
					{/if}
					{if $gBitUser->hasPermission( 'p_liberty_admin_comments' )}
						<a href="{$comments_return_url}&amp;delete_comment_id={$comment.comment_id}" rel="nofollow">{biticon ipackage="icons" iname="edit-delete" iexplain="Remove" iforce="icon"}</a>
					{/if}
					{if $gBitUser->hasPermission( 'p_boards_edit' ) && (($comment.user_id<0 && $comment.is_approved==0)||$comment.user_id>=0) && !$comment.is_warned}
						{if $comment.user_id<0 && $comment.is_approved==0}
							<a title="{tr}Approve this post{/tr}" href="{$smarty.const.BOARDS_PKG_URL}post.php?t={$thread->mRootId}&amp;action=1&amp;comment_id={$comment.comment_id}">
								{biticon ipackage="icons" iname="list-add" iexplain="Approve Post" iforce="icon"}
							</a>

							<a title="{tr}Reject this post{/tr}" href="{$smarty.const.BOARDS_PKG_URL}post.php?t={$thread->mRootId}&amp;action=2&amp;comment_id={$comment.comment_id}">
								{biticon ipackage="icons" iname="list-remove" iexplain="Reject Post" iforce="icon"}
							</a>
						{elseif !$comment.is_warned && $comment.user_id>=0}
							<a onclick="
									this.oldonclick=this.onclick;
									document.getElementById('warn_block_{$comment.comment_id|escape:"url"}').style['display']='inline';
									this.onclick=new Function('
										document.getElementById(\'warn_block_{$comment.comment_id|escape:"url"}\').style[\'display\']=\'none\';
										this.onclick=this.oldonclick;
										return false;
									');
									return false;
								" title="{tr}Warn the poster about this post{/tr}" href="{$smarty.const.BOARDS_PKG_URL}post.php?t={$thread->mRootId}&amp;action=3&amp;comment_id={$comment.comment_id}"
							>{biticon ipackage="icons" iname="dialog-warning" iexplain="Warn Post" iforce="icon"}</a>

							<div style="display:none;" id="warn_block_{$comment.comment_id|escape:"url"}">
								{form action="`$thread_mInfo.display_url`"}
									<input type="hidden" value="3" name="action" />
									<input type="hidden" value="{$thread_mInfo.th_thread_id}" name="t" />
									<input type="hidden" value="{$comment.comment_id}" name="comment_id" />
									<textarea style="vertical-align: top;" rows="3" cols="10" name="warning_message" onclick="this.value=''; this.innerHTML=''; this.onclick=null;">
										Enter Warning Message
									</textarea>
									<input type="submit" value="Warn" />
								{/form}
							</div>
						{/if}
					{/if}
				{/if}<!-- end print_page -->
			</div><!-- end .floaticon -->
		{/if}				
				{if $gBitUser->getPreference('boards_show_avatars','y')==n}
					{tr}Posted by{/tr}: {if $comment.user_id < 0}{$comment.unreg_uname|escape}{else}{displayname hash=$comment}{/if}, {else}
					{tr}Posted{/tr}: {/if}
						{$comment.created|reltime}, {if $comment.created != $comment.last_modified}
					{tr}Last modification by{/tr}:
					{if $comment.user_id < 0}
						{$comment.unreg_uname|escape}
					{else}
						{displayname user=$comment.modifier_user user_id=$comment.modifier_user_id real_name=$comment.modifier_real_name}
					{/if}, {$comment.last_modified|reltime}
				{/if}
			<span class="clear"><!-- --></span>
			</div>
		</div><!-- end .header -->

		{include file="bitpackage:liberty/services_inc.tpl" serviceLocation='body' serviceHash=$comment}

		{if $gBitUser->isRegistered() and $comment.is_warned}
			<div class="warning">
				{assign var=comment_id value=$comment.comment_id}
				<a onclick="
					var e = document.getElementById('warned_message_{$comment.comment_id|escape:"url"}');
					var url = '{$smarty.const.BOARDS_PKG_URL}ajax.php?req=10&comment_id={$comment_id}&amp;seq=' + new Date().getTime();
					var element = 'warned_message_{$comment.comment_id|escape:"url"}';
					var params = null;
					{literal}
						var ajax = new Ajax.Updater(
						{success: element},
						url, {method: 'get', parameters: params, onFailure: reportError}
						);
					{/literal}
					e.style.display='block';
					this.oldonclick=this.onclick;
					this.onclick=new Function('
							document.getElementById(\'warned_message_{$comment.comment_id|escape:"url"}\').style.display=\'none\';
							this.onclick=this.oldonclick;
							return false;
						');
					return false;
					" href="{$thread_mInfo.display_url}&amp;warning[{$comment_id}]={if empty($warnings.$comment_id)}show{else}hide{/if}"
				>{biticon ipackage="icons" iname="dialog-error" iexplain="Warned Post"}</a>

				<div id="warned_message_{$comment.comment_id|escape:"url"}">
					{if !empty($warnings.$comment_id)}{$comment.is_warned_message}{/if}
				</div>

				{if empty($warnings.$comment_id)}
					<script>/*<![CDATA[*/
						var warned_message_{$comment.comment_id|escape:"url"} = document.getElementById('warned_message_{$comment.comment_id|escape:"url"}');
						warned_message_{$comment.comment_id|escape:"url"}.style.display='none';
					/*]]>*/</script>
				{/if}
			</div>
		{/if}

		{$comment.parsed_data}
	</div><!-- end .content -->
</div>


<div class="signature"> </div>
{/strip}
