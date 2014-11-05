package air.extensions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.util.Log;

/**
 * Warning, this doesn't work on all Android devices.
 */
public class ClearCookiesByDomainFunction implements FREFunction {

    private static String TAG = "ClearCookiesByDomainFunction";
    
	@Override
	public FREObject call(FREContext context, FREObject[] passedArgs) {

		FREObject result = null;
		
		String domain;
        try
        {
        	domain = passedArgs[0].getAsString();
        }
        catch (Exception e)
        {
    		return null;
        }

		CookieManager cookieManager = CookieManager.getInstance();
	    String cookiestring = cookieManager.getCookie(domain);
	    String[] cookies =  cookiestring.split(";");
        String newCookie = "";
	    for (int i=0; i<cookies.length; i++) {
	        String[] cookieparts = cookies[i].split("=");
	        cookieManager.setCookie(domain, cookieparts[0].trim()+"=; Expires=Wed, 31 Dec 2025 23:59:59 GMT");
	    }
	    cookieManager.setCookie(domain, newCookie);

		return result;
	}
}
