{strip}
{foreach from=$users item=user}
	<li class="{cycle values='even,odd'}">
		<span class="username">{$user}</span>
	</li>
{/foreach}
{/strip}
