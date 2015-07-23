package initializers {
	import flash.display.Stage;
	
	import UU.loading.Loading_StateUU;
	import UU.show.ShowA_StateUU;
	
	import org.agony2d.Agony;
	import org.agony2d.core.Adapter;
	import org.agony2d.core.IInitializer;
	import org.agony2d.flashApi.UUFacade;
	import org.agony2d.resource.ResMachine;
	import org.agony2d.resource.converters.AtlasAssetConvert;
	
public class Initializer150723_A implements IInitializer {
	
	public function onInit( stage:Stage ) : void {
		var adapter:Adapter;
		
		adapter = Agony.createAdapter(stage, false);
		
		ResMachine.activate(AtlasAssetConvert);
		
		UUFacade.registerView("loading", Loading_StateUU);
		UUFacade.registerView("showA",   ShowA_StateUU);
		
		UUFacade.createRoot(adapter).getView("loading").activate([["showA"]]);
	}
}
}