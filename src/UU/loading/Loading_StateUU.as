package UU.loading {
	import org.agony2d.events.AEvent;
	import org.agony2d.flashApi.StateUU;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.ZipBundle;
	import org.agony2d.resource.handlers.TextureUU_BundleHandler;
	
	public class Loading_StateUU extends StateUU {
		
		override public function onEnter() : void {
			this.resA = new ResMachine("common/");
			
			// image
			this.resA.addBundle(new ZipBundle("top.zip"), new TextureUU_BundleHandler);
			this.resA.addBundle(new ZipBundle("chip.zip"), new TextureUU_BundleHandler);
			this.resA.addBundle(new ZipBundle("bottom.zip"), new TextureUU_BundleHandler);
			
			this.resA.addEventListener(AEvent.COMPLETE, onComplete);
		}
		
		public var resA:ResMachine;
		
		private function onComplete(e:AEvent):void {
			var AY:Array;
			var i:int;
			var l:int;
			
			this.resA.removeAllListeners();
			this.getFusion().kill();
			
			AY = this.getArg(0);
			l = AY.length;
			while (i < l) {
				this.getRoot().getView(AY[i++]).activate();
			}
		}
	}
}