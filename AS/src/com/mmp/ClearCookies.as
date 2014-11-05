package com.mmp
{
	import flash.external.ExtensionContext;

	public class ClearCookies
	{
		private static var extContext:ExtensionContext = null;

		private static function getExtension():ExtensionContext
		{
			if (!extContext)
			{	
				extContext = ExtensionContext.createExtensionContext("com.mmp.ClearCookiesANE", null);
				extContext.call("initNativeCode");
			}
			return extContext;
		}
		
		public static function get isSupported():Boolean
		{
			try{
				return getExtension().call("isSupported") as Boolean;
			}catch(e:Error){
				return false;
			}
		}
		
		
		public static function clearAll():void
		{
			getExtension().call("clearAll");
		}
		
		
		public static function clearByDomain(domain:String):void
		{
			getExtension().call("clearByDomain", domain);
		}
		
		
		public static function setAcceptCookies(accept:Boolean):void
		{
			getExtension().call("setAcceptCookies", accept);
		}
	}
}