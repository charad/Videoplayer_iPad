//--------------------------------------------------------------------------
//
//  View.as
//
//  Extended class description & notes.
//
//  (c) 2011 - Marlon BVBA (arnor.dhaenens[at]marlon.be)
//
//--------------------------------------------------------------------------
package be.marlon.arnor.videoplayer.view
{
	import be.marlon.arnor.basicvideoplayer.events.ViewEvent;
	import be.marlon.arnor.basicvideoplayer.model.data.FileData;
	import be.marlon.arnor.basicvideoplayer.views.components.PreloaderComponent;
	
	import flash.display.Sprite;
	import flash.events.Event;

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
	 * @since May 5, 2011
	 */
	public class ViewVideoPlayer extends Sprite
	{
		//----------------------------------
		//  Properties
		//----------------------------------
		private var _preloader:PreloaderComponent;
		
		
		//----------------------------------
		//  Getters & setters
		//----------------------------------
		
		
		
		//----------------------------------
		//  Constructor
		//----------------------------------
		
		/**
		 * Constructor function.
		 */
		public function ViewVideoPlayer()
		{
			super();
		}
		
		//----------------------------------
		//  Public methods
		//----------------------------------
		/**
		 * Create a preloader
		 * Add it to the view
		 **/
		public function addPreloaderToView():void
		{
			this._preloader = new PreloaderComponent(this.stage.stageWidth, this.stage.stageHeight);
			this.addChild(this._preloader);
			
			this._preloader.addEventListener(ViewEvent.REMOVE_OBJECT, handleRemovingOfObject);
		}
		
		/**
		 * Update the percentage
		 * of the loaded file
		 **/
		public function updatePercentageLoadedFile(fileData:FileData):void
		{
			this._preloader.updatePreloader(fileData);
		}
		
		/**
		 * Remove preloader after loading is complete
		 **/
		public function handleLoadingComplete():void
		{
			this._preloader.hidePreloader();
		}
		
		
		//----------------------------------
		//  Private methods
		//----------------------------------
		
		//----------------------------------
		//  Private event handlers
		//----------------------------------
		
		/**
		 * Handle the removing of an object
		 **/
		private function handleRemovingOfObject(evt:ViewEvent):void
		{
			evt.stopPropagation();
			
			this.removeChild(this._preloader);
			this._preloader = null;
		}
		
	}
}