package air.extensions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.util.Log;

public class SetAcceptCookiesFunction implements FREFunction {

    private static String TAG = "SetAcceptCookiesFunction";
    
	@Override
	public FREObject call(FREContext context, FREObject[] passedArgs) {

		Boolean accept;
        try
        {
        	accept = passedArgs[0].getAsBool();
        }
        catch (Exception e)
        {
    		return null;
        }

		CookieManager cookieManager = CookieManager.getInstance();
		cookieManager.setAcceptCookie(accept);

		return null;
	}
}
