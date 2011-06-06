//--------------------------------------------------------------------------
//
//  FileModel.as
//
//  Extended class description & notes.
//
//  (c) 2011 - Marlon BVBA (arnor.dhaenens[at]marlon.be)
//
//--------------------------------------------------------------------------
package be.marlon.arnor.videoplayer.model
{	
	import be.marlon.arnor.basicvideoplayer.events.FileEvent;
	import be.marlon.arnor.basicvideoplayer.model.data.FileData;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MediaEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.media.CameraRoll;
	import flash.net.FileFilter;
	import flash.net.FileReference;

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
	public class FileModel extends EventDispatcher
	{
		//----------------------------------
		//  Properties
		//----------------------------------
		private var _file:File;
		private var _fileRef:FileReference;
		private var _filter:FileFilter;
		private var _camera:CameraRoll;
		
		
		//----------------------------------
		//  Getters & setters
		//----------------------------------
		
		
		
		//----------------------------------
		//  Constructor
		//----------------------------------
		
		/**
		 * Constructor function.
		 */
		public function FileModel(target:IEventDispatcher=null)
		{
			super(target);
			
			init();
		}
		
		//----------------------------------
		//  Public methods
		//----------------------------------
		/**
		 * Browse for a file
		 **/
		public function browseForFile():void
		{
			_fileRef.browse([_filter]);
			//_file.browseForOpen("open file", [_filter]);
			//this._camera.browseForImage();
			
		}
		
		
		//----------------------------------
		//  Private methods
		//----------------------------------
		/**
		 * Initialize
		 **/
		private function init():void
		{
			/*this._file = new File();
			this._file.addEventListener(Event.SELECT, handleFileSelect);
			this._file.addEventListener(ProgressEvent.PROGRESS, handleFileLoadProgress);
			this._file.addEventListener(Event.COMPLETE, handleFileLoadComplete);
			this._file.addEventListener(Event.CANCEL, handleFileSelectionCancel);*/
			
			this._fileRef = new File();
			this._fileRef.addEventListener(Event.SELECT, handleFileSelect);
			this._fileRef.addEventListener(ProgressEvent.PROGRESS, handleFileLoadProgress);
			this._fileRef.addEventListener(Event.COMPLETE, handleFileLoadComplete);
			this._fileRef.addEventListener(Event.CANCEL, handleFileSelectionCancel);
			
			this._filter = new FileFilter("Browse for video", "*.flv;*.f4v;*.mp4;");
		}
		
		//----------------------------------
		//  Private event handlers
		//----------------------------------
		/**
		 * Handle the selection of the file
		 **/
		private function handleFileSelect(evt:Event):void
		{			
			//this._file.load();
			this._fileRef.load();
			
			dispatchEvent(new FileEvent(FileEvent.FILE_SELECTED));
			dispatchEvent(new FileEvent(FileEvent.FILE_BEGIN_LOADING));
		}
		
		/**
		 * Handle file selection cancel
		 **/
		private function handleFileSelectionCancel(evt:Event):void
		{
			dispatchEvent(new FileEvent(FileEvent.FILE_CANCEL));
		}
		
		/**
		 * Handle the loading progress of the file
		 **/
		private function handleFileLoadProgress(evt:ProgressEvent):void
		{			
			var fileData:FileData = new FileData();
			fileData.bytesLoaded = evt.bytesLoaded;
			fileData.bytesTotal = evt.bytesTotal;
			
			//trace(fileData.bytesLoaded / fileData.bytesTotal);
			
			dispatchEvent(new FileEvent(FileEvent.FILE_LOADING, fileData));
		}
		
		/**
		 * Handle completion of the file load
		 **/
		private function handleFileLoadComplete(evt:Event):void
		{
			trace("file complete loaded");
			
			var fileData:FileData = new FileData();
			fileData.fileURL = evt.target.url;
			
			dispatchEvent(new FileEvent(FileEvent.FILE_LOADING_COMPLETE, fileData));
		}
		
		/**
		 * Handle media select event
		 **/
		private function handleMediaSelectEvent(evt:MediaEvent):void
		{
			MonsterDebugger.trace(this, evt.target);
		}
		
	}
}