class PagerRenderExt extends PagerRender
    startElement: (def, renderizer) ->
        super(def, renderizer)
        
  
    afterAllStart: (def, renderizer) ->
        $('#' + def.id).tabs({ 
            heightStyle: "fill" }            
        )
        
        for child in def.children
            $(child.component).removeClass('ui-tabs-panel')
        
        
    activate: ( event, ui, def ) ->
        def.start(this)