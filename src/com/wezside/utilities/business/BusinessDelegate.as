package com.wezside.utilities.business
{
	import com.wezside.utilities.business.rpc.IService;

	/**
	 * Ideally this class should be project specific as we wouldn't always use an HTTPService.   
	 * But because we use it most of the time we include it in the framework.
	 * 
	 * <p>
	 * <b>Example:</b>
	 *  	var delegate:BusinessDelegate = new BusinessDelegate( this, ServicesConfig.LOGIN );
	 *		delegate.delegateService( UserVO( event.data ) );
	 * </p> 
	 * 
	 * @author Wesley.Swanepoel
	 * @version .326
	 */
	
	public class BusinessDelegate
	{
		
		private var service:IService; 
		
		
		public function BusinessDelegate( responder:IResponder, service:IService )
		{
			this.service = service;
			service.responder = responder;
		}
		
		
		public function delegateService( params:Object = null, operationID:String = "" ) : void
		{
			service.send( params, operationID );
		}
		
		public function kill():void
		{
			service.kill();
			service = null;
		}
	}
}