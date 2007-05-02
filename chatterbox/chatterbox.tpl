{strip}
<div class="floaticon">{bithelp}</div>

<div class="display">
	<div class="header">
		<h1>{tr}Chat{/tr}</h1>
	</div>

	<div class="body">
		<table class="chat">
			<tr>
				<th>
					{form id="chatForm" onsubmit="return false;" action="#"}
						<input type="hidden" id="last_id" name="last_id" value="-1" />
						{if $gBitUser->isRegistered()}
							<input type="hidden" name="name" id="chatName" value="{displayname hash=$gBitUser->mInfo nolink=1}" />&lt;{displayname hash=$gBitUser->mInfo nolink=1}&gt;
						{else}
							<input type="text" size="12" maxlength="30" name="name" id="chatName" onblur="checkName();" />
						{/if}
						<input type="text" size="55" name="chatbarText" id="chatbarText" onblur="checkStatus('');" onfocus="checkStatus('active');" />
						<input onclick="sendComment();" type="submit" id="chatSubmit" name="submit" value="submit" />
					{/form}
				</th>
				<th>
					{tr}Active Users{/tr}
				</th>
			</tr>
			<tr>
				<td class="history">
					<ul id="outputChat" class="data">
						<li>After submitting your message, it might take a couple of seconds before it appears</li>
					</ul>
				</td>
				<td class="users">
					<ul id="outputUsers" class="data">
						<li></li>
					</ul>
				</td>
			</tr>
		</table>		

		<script type="text/javascript">/* <![CDATA[ */
			initChatterbox();
		/* ]]> */</script>
	</div><!-- end .body -->
</div><!-- end .chat -->
{/strip}
