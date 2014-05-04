class PagerRenderExt extends PagerRender
    startElement: (def, renderizer) ->
        super(def, renderizer)
        
  
    afterAllStart: (def, renderizer) ->
        $('#' + def.id).tabs({ 
            heightStyle: "fill" }            
        )
        
        for child in def.children
            $(child.component).removeClass('ui-tabs-panel')
        
    beforeRealignChildren: (def, renderizer) ->
        $('#' + def.id).tabs('destroy')
        
         
        
    
    afterAllRealign: (def, renderizer) ->
        @startElement(def, renderizer)
        @afterAllStart(def, renderizer)
            
    activate: ( event, ui, def ) ->
        def.start(this)