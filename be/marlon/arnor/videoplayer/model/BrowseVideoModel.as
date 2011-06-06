//--------------------------------------------------------------------------
//
//  BrowseVideoModel.as
//
//  Extended class description & notes.
//
//  (c) 2011 - Marlon BVBA (arnor.dhaenens[at]marlon.be)
//
//--------------------------------------------------------------------------
package be.marlon.arnor.videoplayer.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.CameraRoll;

	//----------------------------------
	//  Import statements
	//----------------------------------
	
	
	
	//----------------------------------
	//  Class
	//----------------------------------
	
	/**
	 * Class description.
	 *
	 * @author charad (arnor.dhaenens[at]marlon.be)
	 * @since May 10, 2011
	 */
	public class BrowseVideoModel extends EventDispatcher
	{
		//----------------------------------
		//  Properties
		//----------------------------------
		
		
		
		//----------------------------------
		//  Getters & setters
		//----------------------------------
		
		
		
		//----------------------------------
		//  Constructor
		//----------------------------------
		
		/**
		 * Constructor function.
		 */
		public function BrowseVideoModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		//----------------------------------
		//  Public methods
		//----------------------------------
		public function browseForVideo():void
		{
			if(CameraRoll.supportsBrowseForImage)
			{
				var video:CameraRoll = new CameraRoll();
				video.browseForImage();
				
			}
		}
		
		
		//----------------------------------
		//  Private methods
		//----------------------------------
		
		
		//----------------------------------
		//  Private event handlers
		//----------------------------------
		
		
	}
}