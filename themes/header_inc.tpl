{* $Header: /cvsroot/bitweaver/_bit_styles/bitweaver2/themes/header_inc.tpl,v 1.9 2007/04/23 06:35:01 laetzer Exp $ *}
{strip}
{if $gBitSystem->isFeatureActive( 'site_style_layout' )}
	<link rel="stylesheet" title="{$style}" type="text/css" href="{$smarty.const.THEMES_PKG_URL}layouts/{$gBitSystem->getConfig('site_style_layout')}.css" media="all" />
{/if}
{if $gBitThemes->mStyles.styleSheet}
	<link rel="stylesheet" title="{$style}" type="text/css" href="{$gBitThemes->mStyles.styleSheet}" media="all" />
{/if}
{if $gBitThemes->mStyles.browserStyleSheet}
	<link rel="stylesheet" title="{$style}" type="text/css" href="{$gBitThemes->mStyles.browserStyleSheet}" media="all" />
{/if}
{if $gBitThemes->mStyles.customStyleSheet}
	<link rel="stylesheet" title="{$style}" type="text/css" href="{$gBitThemes->mStyles.custumStyleSheet}" media="all" />
{/if}
{foreach from=$gBitThemes->mStyles.altStyleSheets item=alt_path key=alt_name}
	<link rel="alternate stylesheet" title="{$alt_name}" type="text/css" href="{$alt_path}" media="screen" />
{/foreach}

{if $loadMultiFile}
	<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/libs/multifile.js"></script>
{/if}

{if $gBitSystem->isFeatureActive('site_top_bar_js') && $gBitSystem->isFeatureActive('site_top_bar') && $gBitSystem->isFeatureActive('site_top_bar_dropdown')}
	<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/libs/fsmenu.js"></script>
{/if}

{if !$gBitSystem->isFeatureActive('site_disable_jstabs')}
	<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/libs/tabpane.js"></script>
{/if}
{/strip}

{if $loadThemesCss}
	{literal}
	<style type="text/css">
		div#themeapprove	{position:fixed; color:#000; z-index:1000000; bottom:10px; right:10px; width:400px; background:#fff; border:3px solid #999; padding:20px; text-align:center; opacity:0.8;}
		div#themeapprove a	{display:block; float:left; margin:10px; padding:20px 71px; background:#eee; border:1px solid #ccc; vertical-align:middle;}
		div#themeapprove a:hover	{background-color:#b83;}
		ul#layoutgala		{list-style:none; margin:0; padding:0;}
		ul#layoutgala li	{list-style:none; float:left; display:inline; margin:0 0 0.5em 0.5em; width:120px; text-align:center}
		ul#layoutgala li a	{height:160px; display:block; line-height:1.2em; padding:0.5em 0;}
	</style>
	{/literal}
{/if}

{* drag and drop javascript doesn't work with fat loaded - hardcode css for now *}
{if $loadDragDrop}
	<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/libs/drag/dragdrop.js"></script>

	{literal}
	<style type="text/css">
		ul.boxy,
		ul.boxy li			{min-height:2em; list-style-type:none; border:#ccc solid 1px; padding:4px 4px 0 4px; margin:0px; border:#ccc 1px solid;}
		ul.boxy				{background:#fff; margin:0px;}
		ul.boxy li			{cursor:move; margin:0 0 4px 0; padding:2px;}
		ul.boxy li			{position:relative; width:250px;}
		.layout ul.boxy li	{position:relative !important; width:auto !important;}
		ul#left li			{background:#bfc;}
		ul#center li		{background:#fda;}
		ul#right li			{background:#cbf;}
	</style>

	<script type="text/javascript">//<![CDATA[
		window.onload = function() {
			var list = $( "left" );
			DragDrop.makeListContainer( list, 'side_columns' );
			list.onDragOver = function() { this.style["background"] = "#feb"; };
			list.onDragOut = function() {this.style["background"] = "none"; };

			list = $( "center" );
			DragDrop.makeListContainer( list, 'center_column' );
			list.onDragOver = function() { this.style["background"] = "#dfe"; };
			list.onDragOut = function() {this.style["background"] = "none"; };

			list = $( "right" );
			DragDrop.makeListContainer( list, 'side_columns' );
			list.onDragOver = function() { this.style["background"] = "#feb"; };
			list.onDragOut = function() {this.style["background"] = "none"; };
		};

		function getSort( id ) {
			order = $( id );
			order.value = DragDrop.serData( id, null );
		}
	//]]></script>
	{/literal}
{elseif !$gBitSystem->getConfig('site_disable_fat')}
	<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/libs/fat.js"></script>
{/if}

{if $gBrowserInfo.browser eq 'ie'}
{literal}
	<!--[if lt IE 7]>
		<script type="text/javascript">
			IE7_PNG_SUFFIX = ".png";
		</script>
		<script type="text/javascript" src="{$smarty.const.UTIL_PKG_URL}javascript/fixes/ie7/ie7-standard-p.js"></script>
	<![endif]-->
	
	<!--[if lt IE 7]>
		<style type="text/css">
			#bitweaver #try ul li a em	{display:none}
			div.bitbox:first-letter	{display:block;float:left;line-height:0.7em}
		</style>
	<![endif]-->	
{/literal}
{/if}

{if $SCRIPT_NAME eq '/articles/index.php'} 
{assign var="images" value=`$smarty.const.BIT_ROOT_URL`themes/styles/bitweaver2/images}
{literal}
<style type="text/css" media="all">
 
	/* splash logo column */ 
	#bitweaver		{clear:both;margin:0;padding:0}
	#bitweaver p		{text-align:center;color:#fff;text-transform:uppercase;padding:0 12px;margin:0 auto;max-width:32em;font-size:0.5em;font-family:'Palatino Linotype',Palatino,Georgia,serif;line-height:1.4em}
	#bitweaver p#logo		{background:url({/literal}{$images}{literal}/bitweaver.gif) no-repeat 50% top;height:212px;margin:0 auto}
	#bitweaver p.stop		{background:url({/literal}{$images}{literal}/bg_p-stop.gif) no-repeat 50% bottom;padding-bottom:48px;padding-top:12px}

	#navigation		{background:url({/literal}{$images}{literal}/bg_navigation_{/literal}{1|rand:3}{literal}.gif) no-repeat left top}
	 
	#bitweaver #try ul li	{color:#fff}
	#bitweaver #try ul li a:hover	{border-style:dotted !important;border-color:#006fbf !important;border-width:1px 0 !important} 
	#bitweaver #try ul #homelink	{} 
	#bitweaver #try ul #demolink	{}
 
	/* link list */
	#dcd			{margin:0 0 40px 12px} 
	#dcd ul			{width:27%;float:left;margin:24px 32px 0 0;padding:60px 0 0 0} 
	#dcd ul li		{list-style-type:none;margin:0 10px;border-bottom:1px solid #fff;max-width:24em} 
	#dcd ul li strong		{background:#ffc;font-weight:500;padding:0 4px 0 0}
	#dcd ul li a		{text-decoration:none;display:block;border-bottom:1px solid #f6f6f6;white-space:nowrap;overflow:hidden}
	#dcd ul.doc li a:hover	{background:url({/literal}{$images}{literal}/bg_a_hover_doc.gif) no-repeat right 50%}
	#dcd ul.com li a:hover	{background:url({/literal}{$images}{literal}/bg_a_hover_com.gif) no-repeat right 50%}
	#dcd ul.dev li a:hover	{background:url({/literal}{$images}{literal}/bg_a_hover_dev.gif) no-repeat right 50%}
	#dcd ul li a:visited	{background:url({/literal}{$images}{literal}/bg_a_visited.gif) no-repeat right 50%}
	#dcd ul.doc li a		{color:#aa9f4f}
	#dcd ul.com li a		{color:#4da653}
	#dcd ul.dev li a		{color:#76aab6}
	#dcd ul.doc li a:hover	{color:#fadc00;border-bottom:1px solid #fadc00}
	#dcd ul.com li a:hover	{color:#00f411;border-bottom:1px solid #00f411}
	#dcd ul.dev li a:hover	{color:#3fceee;border-bottom:1px solid #3fceee}
 
	/* sublogos */ 
	ul.doc			{background:#fff url({/literal}{$images}{literal}/logo_doc.gif) no-repeat left top}
	ul.com			{background:#fff url({/literal}{$images}{literal}/logo_com.gif) no-repeat left top}
	ul.dev			{background:#fff url({/literal}{$images}{literal}/logo_dev.gif) no-repeat left top}
 
	/* arrows */ 
	#dcd ul 	li em.more	{background-color:#f6f6f6;background-repeat:no-repeat;background-position:-1000 -1000;float:right;margin:4px 0;position:relative;left:0.5em} 
	#dcd ul.doc li em.more	{background-image:url({/literal}{$images}{literal}/hl_arrow_doc.gif);background-image:url({/literal}{$images}{literal}/arrow_doc.gif)} 
	#dcd ul.com li em.more	{background-image:url({/literal}{$images}{literal}/hl_arrow_com.gif);background-image:url({/literal}{$images}{literal}/arrow_com.gif)} 
	#dcd ul.dev li em.more	{background-image:url({/literal}{$images}{literal}/hl_arrow_dev.gif);background-image:url({/literal}{$images}{literal}/arrow_dev.gif)} 
 
	#dcd ul.doc li em.more:hover	{background-image:url({/literal}{$images}{literal}/hl_arrow_doc.gif);background-position:right 50%}
	#dcd ul.com li em.more:hover	{background-image:url({/literal}{$images}{literal}/hl_arrow_com.gif);background-position:right 50%}
	#dcd ul.dev li em.more:hover	{background-image:url({/literal}{$images}{literal}/hl_arrow_dev.gif);background-position:right 50%}
 
	#dcd ul li em.more a	{color:#fff;border-bottom-width:0.5em;border-color:#fff;padding:0 0.2em} 
	#dcd ul li em.more a:hover	{color:#fff;border-bottom-width:0.5em;border-color:#fff} 
 
	#dcd ul.doc li em.more a	{background:#AA9F4F} 
	#dcd ul.com li em.more a	{background:#4DA653} 
	#dcd ul.dev li em.more a	{background:#76aab6} 
	#dcd ul.doc li em.more a:hover{background:#fadc00} 
	#dcd ul.com li em.more a:hover{background:#00f411} 
	#dcd ul.dev li em.more a:hover{background:#3fceee} 
 
</style> 
{/literal} 
{/if}