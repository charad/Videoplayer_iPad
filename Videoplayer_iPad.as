//--------------------------------------------------------------------------
//
//  VideoPlayer_iPad.as
//
//  Extended class description & notes.
//
//  (c) 2011 - Marlon BVBA (arnor.dhaenens[at]marlon.be)
//
//--------------------------------------------------------------------------
package 
{
	//----------------------------------
	//  Import statements
	//----------------------------------
	
	import be.marlon.arnor.basicvideoplayer.controller.BasicVideoplayer;
	import be.marlon.arnor.basicvideoplayer.events.FileEvent;
	import be.marlon.arnor.basicvideoplayer.events.ViewEvent;
	import be.marlon.arnor.videoplayer.model.BrowseVideoModel;
	import be.marlon.arnor.videoplayer.model.FileModel;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	
	//----------------------------------
	//  Class
	//----------------------------------
	
	/**
	 * Class description.
	 *
	 * @author charad (arnor.dhaenens[at]marlon.be)
	 * @since May 10, 2011
	 */
	public class Videoplayer_iPad extends Sprite
	{
		//----------------------------------
		//  Properties
		//----------------------------------
		private var _basicVideo:BasicVideoplayer;
		private var _fileModel:FileModel;
		private var _browseVideoModel:BrowseVideoModel;
		
		
		//----------------------------------
		//  Getters & setters
		//----------------------------------
		
		
		
		//----------------------------------
		//  Constructor
		//----------------------------------
		
		/**
		 * Constructor function.
		 */
		public function Videoplayer_iPad() 
		{
			super();
			
			// support autoOrients
			setStage();
			
			NativeApplication.nativeApplication.autoExit = true;
			
			init();
		}
		
		//----------------------------------
		//  Public methods
		//----------------------------------
		
		
		
		//----------------------------------
		//  Private methods
		//----------------------------------
		/**
		 * Initialize application
		 **/
		private function init():void
		{
			if(this.stage.orientation == StageOrientation.ROTATED_LEFT || this.stage.orientation == StageOrientation.ROTATED_RIGHT)
			{
				this.stage.stageWidth = this.stage.fullScreenWidth;
				this.stage.stageHeight = this.stage.fullScreenHeight;
			}
			else if(this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN)
			{
				this.stage.stageWidth = this.stage.fullScreenHeight;
				this.stage.stageHeight = this.stage.fullScreenWidth;
			}
			
			setBackground();
			
			//create basic video player
			this._basicVideo = new BasicVideoplayer(null, true, false, true);
			this._basicVideo.addEventListener(ViewEvent.BROWSE_FOR_FILE, handleBrowseForFile);
			this._basicVideo.addEventListener(Event.ADDED_TO_STAGE, handleBasicVideoAddedToStage);
			this.addChild(this._basicVideo);
			
			//file
			this._fileModel = new FileModel();
			
			//set video browse
			this._browseVideoModel = new BrowseVideoModel();
			
			//add event listeners to the stage
			//listen to the orientation of the device
			this.stage.addEventListener(Event.RESIZE, handleStageResize);
			this.stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, handleStageOrientationChange);
			this.stage.addEventListener(MouseEvent.CLICK, handleStageClick);
		}
		
		/**
		 * 
		 * Set the stage
		 * 
		 * set the align mode to TOP_LEFT
		 * set the scale mode to NO_SCALE
		 * 
		 **/
		private function setStage():void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		/**
		 * Setting the background
		 * 
		 * Fill it with black color
		 **/
		private function setBackground():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 1);
			var size:Number = Math.max(this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.drawRect(0,0, size, size);
			this.graphics.endFill();
		}
		
		//----------------------------------
		//  Private event handlers
		//----------------------------------
		/**
		 * Handle Basic Video Player added to stage
		 **/
		private function handleBasicVideoAddedToStage(evt:Event):void
		{
			this._basicVideo.init();
			
			this._basicVideo.openNewVideo("assets/videos/_Green Lantern_ Trailer HD.flv");
		}
		
		/**
		 * Handles the stage resizing
		 **/
		private function handleStageResize(evt:Event):void
		{			
			//set the background
			setBackground();
			
			this._basicVideo.toggleScreen();
		}
		
		/**
		 * Handle change in Stage Orientation
		 **/
		private function handleStageOrientationChange(evt:StageOrientationEvent):void
		{
			this._basicVideo.handleOrientation();
			setBackground();
		}
		
		/**
		 * Handle Stage Click
		 **/
		private function handleStageClick(evt:MouseEvent):void
		{
			if(evt.target.toString() == "[object View]" || evt.target.toString() == "[object Stage]")
				this._basicVideo.toggleControls();
		}
		
		/**
		 * Handle browsing for file
		 **/
		private function handleBrowseForFile(evt:ViewEvent):void
		{
			this._browseVideoModel.browseForVideo();
			
			this._fileModel.browseForFile();
		}
		
		/**
		 * Handle File Selected
		 **/
		private function handleFileSelected(evt:FileEvent):void
		{
			trace("file selected");
		}	
	}
}