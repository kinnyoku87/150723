package UU.show {
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.events.AccelerometerEvent;
	import flash.events.ActivityEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.media.Video;
	import flash.sensors.Accelerometer;
	
	import org.agony2d.Agony;
	import org.agony2d.core.Adapter;
	import org.agony2d.events.ATouchEvent;
	import org.agony2d.flashApi.FusionUU;
	import org.agony2d.flashApi.ImageUU;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.flashApi.core.BranchUU;
	import org.agony2d.flashApi.flash.RawSpriteUU;

	public class ShowA_StateUU extends StateUU
	{
		override public function onEnter() : void {
			var img_A:ImageUU;
			var i:int;
			var l:int;
			
			// static
			i = 0;
			l = _staticViewData.length;
			while(i<l){
				this.____doCreateImg(_staticViewData[i++], this.getFusion());
			}
			// top
			i = 0;
			l = _topViewData.length;
			while(i<l){
				_rotateList.push(this.____doCreatePivotImg(_topViewData[i++], this.getFusion()));
			}
			// chip
			i = 0;
			l = _chipViewData.length;
			while(i<l){
				_rotateList.push(this.____doCreatePivotImg(_chipViewData[i++], this.getFusion()));
			}
			// bottom
			i = 0;
			l = _bottomViewData.length;
			while(i<l){
				_rotateList.push(this.____doCreatePivotImg(_bottomViewData[i++], this.getFusion()));
			}
			
			// manual A
			_manualFN_A = new FusionUU;
			this.getFusion().addNode(_manualFN_A);
//			_manualFN_A.alpha = 0.0;
			i = 0;
			l = _manualView_A_Data.length;
			while(i<l){
				_manualListA.push(this.____doCreatePivotImg(_manualView_A_Data[i++], _manualFN_A));
			}
			
			// manual B
			_manualFN_B = new FusionUU;
			this.getFusion().addNode(_manualFN_B);
//			_manualFN_B.alpha = 0.0;
			i = 0;
			l = _manualView_B_Data.length;
			while(i<l){
				img_A = this.____doCreatePivotImg(_manualView_B_Data[i++], _manualFN_B);
				img_A.pivotX = img_A.getWidth() * .5;
				img_A.pivotY = img_A.getHeight() * .5;
				img_A.rotation = 90;
				_manualListB.push(img_A);
			}
			
//			trace(Accelerometer.isSupported);
			if(Accelerometer.isSupported){
				_acce = new Accelerometer;
				_acce.addEventListener(AccelerometerEvent.UPDATE, ____onAcceUpdate);
			}
			
//			this.getRoot().getAdapter().getStage().addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideo);
		}
		
		private var stageVideo:StageVideo;
		
		private function onStageVideo(e:StageVideoAvailabilityEvent):void {
			trace(e.availability);
			
			stageVideo = this.getRoot().getAdapter().getStage().stageVideos[0];
			
			trace(Camera.isSupported);
			if(Camera.isSupported){
				var video:Video;
				var camera:Camera;
				var rawSprite:RawSpriteUU;
				var w:int;
				var h:int;
				var rect_A:Rectangle;
				var adapter:Adapter;
				
				adapter = this.getRoot().getAdapter();
				
				rawSprite = new RawSpriteUU;
				rawSprite.rotation = 90;
				rawSprite.x = this.getRoot().getAdapter().rootWidth;
				this.getFusion().addNodeAt(rawSprite, 0);
				
//				if(stageVideo){
//					stageVideo.viewPort = rect_A = new Rectangle(0, 0, this.getRoot().getAdapter().rawScreenWidth, this.getRoot().getAdapter().rawScreenHeight);
//					trace(rect_A);
//				}
				
				camera = Camera.getCamera();
				if(camera){
					camera.setMode(this.getRoot().getAdapter().rawScreenHeight, this.getRoot().getAdapter().rawScreenWidth, 12);
//					camera.setMode(320, 240, 12);
					camera.setQuality(0, 10);
					camera.addEventListener(ActivityEvent.ACTIVITY, activityHandler);
					
//					stageVideo.addEventListener(StageVideoEvent.RENDER_STATE, onRenderState);
//					stageVideo.attachCamera(camera);
					
					video = new Video(adapter.rootHeight, adapter.rootWidth);
//					video = new Video(320, 240);
					video.attachCamera(camera);
					rawSprite.addChild(video);
					trace(rawSprite.getWidth() * adapter.getFinalRatio(), rawSprite.getHeight() * adapter.getFinalRatio());
				}
				
			}
		}
		
		private function activityHandler(event:ActivityEvent):void {
			trace("activityHandler: " + event);
		}
		
		private function onRenderState(e:StageVideoEvent):void{
			trace("onRenderState: " + e.status);
		}
		
		private const NORMAL:int = 0;
		private const TO_LEFT:int = 1;
		private const TO_RIGHT:int = 2;
		
		private var _orientationFlag:int = -1;
		
		private var _acce:Accelerometer;
		
		private var _manualListA:Array = [];
		private var _manualListB:Array = [];
		private var _rotateList:Array = [];
		private var _manualFN_A:FusionUU;
		private var _manualFN_B:FusionUU;
		
		
		private var _staticViewData:Array = 
		[
			["chip/BJ.png", 0, 0,   0],
			["chip/toumingdi.png", 0, 0,   0],
			["chip/arc.png", 101, 645],
			["chip/arc.png", 101, 645 + 158 * 1,   0],
			["chip/arc.png", 101, 645 + 158 * 2,   0],
			["chip/arc.png", 101, 645 + 158 * 3,   0],
			["chip/arc.png", 101, 645 + 158 * 4,   0],
		];
		private var _topViewData:Array = 
		[
			["top/a.png", 105, 85,   0],
			["top/b.png", 395, 85,   0],
			["top/c.png", 685, 85,   0],
			["top/d.png", 975, 85,   0],
		];
		private var _chipViewData:Array = 
		[
			["chip/N-2.PNG", 110, 650,   0],
			["chip/N-1.PNG", 325, 625,   0],
			["chip/icon_0005_.png", 540, 645,   0],
			["chip/N+1.PNG", 755, 625,   0],
			["chip/N+2.PNG", 970, 650,   0],
			
//			["chip/icon_0006-sel.png", 780, 660 + 158,   0],
			["chip/icon_0006-sel.png", 960, 680 + 158,   0],
			["chip/+.png", 970, 650 + 158,   0],
			
			["chip/icon_0009_WB.png", 105,           690 + 158 * 2,   0],
			["chip/_0004_light.png",  105 + 170 * 1, 625 + 158 * 2,   0],
			["chip/_0005_.png",       105 + 170 * 2, 610 + 158 * 2,   0],
			["chip/_0003_sun.png",    105 + 170 * 3, 610 + 158 * 2,   0],
			["chip/_0002_cloud.png",  105 + 170 * 4, 620 + 158 * 2,   0],
			["chip/duli.png",         955,           640 + 158 * 2,   0],
			
//			["chip/icon_0011_ISO.png", 105,           680 + 158 * 3,   0],
			["chip/icon_0011_ISO.png", 960,           680 + 158 * 3,   0],
			["chip/N100.PNG",          105 + 120 * 1, 635 + 158 * 3,   0],
			["chip/N200.PNG",          105 + 120 * 2, 620 + 158 * 3,   0],
			["chip/N400.PNG",          105 + 120 * 3, 610 + 158 * 3,   0],
			["chip/N600.PNG",          105 + 120 * 4, 610 + 158 * 3,   0],
			["chip/N800.PNG",          105 + 120 * 5, 615 + 158 * 3,   0],
			["chip/N1600.PNG",         105 + 120 * 6, 630 + 158 * 3,   0],
			["chip/N3200.PNG",         105 + 120 * 7, 645 + 158 * 3,   0],
			
			["chip/auto.png",          110,           650 + 158 * 4,   0],
			["chip/_0001_icon.png",    325,           620 + 158 * 4,   0],
			["chip/icon_0012_sel.png", 540,           645 + 158 * 4,   0],
			["chip/house.png",         755,           620 + 158 * 4,   0],
			["chip/_0011_.png",        970,           650 + 158 * 4,   0],
			
			["chip/reset.png", 540, 1435],
			
			["chip/value_makeup.PNG",  110,           1600,   0],
			["chip/value_speedy.PNG",  325,           1600,   0],
			["chip/value_balance.PNG", 540,           1600,   0],
			["chip/value_ISO.PNG",     755,           1600,   0],
			["chip/value_focus.PNG",   970,           1600,   0]
			
		];
		private var _bottomViewData:Array = 
		[
			["bottom/aa.png", 132, 1920 - 132],
			["bottom/bb.png", 336, 1920 - 132],
			["bottom/cc.png", 540, 1920 - 132],
			["bottom/dd.png", 1080 - 132, 1920 - 132]
		];
		private var _manualView_A_Data:Array = 
		[
			["chip/word_makeup.PNG", 915,        720 + 158 * 0,   0],
//			["chip/word_speedy.PNG", 915,        720 + 158 * 1,   0],
			["chip/word_speedy.PNG", 135,        725 + 158 * 1,   -20],
			["chip/word_bai.PNG",    915,        720 + 158 * 2,   0],
//			["chip/word_ISO.PNG",    915,        720 + 158 * 3,   0],
			["chip/word_ISO.PNG",    85,        715 + 158 * 3,   -20],
			["chip/word_focus.PNG",  915,        720 + 158 * 4,   0]
		];
		private var _manualView_B_Data:Array = 
		[
			["chip/word_makeup02.PNG", 1035,        700 + 158 * 0,   0],
//			["chip/word_speedy02.PNG", 1035,        700 + 158 * 1,   0],
			["chip/word_speedy02.PNG", 55,        700 + 158 * 1,   0],
			["chip/word_bai02.PNG",    1035,        700 + 158 * 2,   0],
//			["chip/word_ISO02.PNG",    1035,        700 + 158 * 3,   0],
			["chip/word_ISO02.PNG",    55,        700 + 158 * 3,   0],
			["chip/word_focus02.PNG",  1035,        700 + 158 * 4,   0]
		];
		
		private function ____doCreateImg( AY:Array, branch:BranchUU ) : ImageUU {
			var img:ImageUU;
			
			img = new ImageUU(true);
			img.textureId = AY[0];
			branch.addNode(img);
			img.x = AY[1];
			img.y = AY[2];
//			img.rotation = AY[3];
//			img.addEventListener(ATouchEvent.CLICK, onClick);
			return img;
		}
		
		private function ____doCreatePivotImg( AY:Array, branch:BranchUU ) : ImageUU {
			var img:ImageUU;
			
			img = new ImageUU(true);
			img.textureId = AY[0];
			img.pivotX = img.getWidth() * .5;
			img.pivotY = img.getHeight() * .5
			branch.addNode(img);
			img.x = AY[1];
			img.y = AY[2];
//			img.rotation = AY[3];
			//			img.addEventListener(ATouchEvent.CLICsK, onClick);
			return img;
		}
		
		private function onClick(e:ATouchEvent):void{
			var img:ImageUU;
			
			img = e.target as ImageUU;
			Agony.getLog().simplify(img.textureId);
		}
		
		private function ____onAcceUpdate(e:AccelerometerEvent) : void {
			var flag_A:int;
			var i:int;
			var l:int;
			var img_A:ImageUU;
			
//			Agony.getLog().simplify("{0}, {1}, {3}", e.accelerationX, e.accelerationY, e.accelerationZ);
			
			if(e.accelerationX <= -0.60){
				flag_A = TO_RIGHT;
			}
			else if(e.accelerationX >= 0.60){
				flag_A = TO_LEFT;
			}
			else {
				flag_A = NORMAL;
			}
			if(_orientationFlag == flag_A) {
				return;
			}
			_orientationFlag = flag_A;
			Agony.getLog().simplify(_orientationFlag);
			
			l = _rotateList.length;
			if(_orientationFlag == NORMAL) {
				while(i<l){
					img_A = _rotateList[i++];
					TweenLite.to(img_A, 0.5, {rotation:0, ease:Linear.easeOut});
				}
				_manualFN_B.alpha = 1.0;
				TweenLite.to(_manualFN_B, 0.25, {alpha:0.0, ease:Linear.easeOut});
				_manualFN_A.alpha = 0.0;
				TweenLite.to(_manualFN_A, 0.25, {alpha:1.0, delay:0.3, ease:Linear.easeOut});
			}
			else if(_orientationFlag == TO_LEFT) {
				while(i<l){
					img_A = _rotateList[i++];
					TweenLite.to(img_A, 0.5, {rotation:90, ease:Linear.easeOut});
					
				}
				
				_manualFN_A.alpha = 1.0;
				TweenLite.to(_manualFN_A, 0.25, {alpha:0.0, ease:Linear.easeOut});
				_manualFN_B.alpha = 0.0;
				TweenLite.to(_manualFN_B, 0.25, {alpha:1.0, delay:0.2, ease:Linear.easeOut});
				
				i = 0;
				l = _manualListB.length;
				while(i<l){
					img_A = _manualListB[i++];
					img_A.rotation = 90;
				}
			}
			else if(_orientationFlag == TO_RIGHT) {
				while(i<l){
					img_A = _rotateList[i++];
					TweenLite.to(img_A, 0.5, {rotation:-90, ease:Linear.easeOut});
					
				}
				
				_manualFN_A.alpha = 1.0;
				TweenLite.to(_manualFN_A, 0.25, {alpha:0.0, ease:Linear.easeOut});
				_manualFN_B.alpha = 0.0;
				TweenLite.to(_manualFN_B, 0.25, {alpha:1.0, delay:0.2, ease:Linear.easeOut});
				
				i = 0;
				l = _manualListB.length;
				while(i<l){
					img_A = _manualListB[i++];
					img_A.rotation = -90;
				}
			}
		}
	}
}