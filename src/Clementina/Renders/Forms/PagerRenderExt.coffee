class PagerRenderExt extends PagerRender
    startElement: (def, renderizer) ->
        super(def, renderizer)
  
    afterAllStart: (def, renderizer) ->
        if def.style=='horizontal'
            $('#' + def.id).tabs({ 
                heightStyle: "fill" }            
            )
        else
            $('#' + def.id).accordion({ 
                heightStyle: "fill" }            
            )
        
        for child in def.children
            if def.style=='horizontal'
                 $(child.component).removeClass('ui-tabs-panel')
                 $(child.component).css('height','initial')
            else
                $(child.component).removeClass('ui-accordion-content')
                $(child.component).css('height','initial')
        
    beforeRealignChildren: (def, renderizer) ->
        if def.style=='horizontal'
            $('#' + def.id).tabs('destroy')
        else
            $('#' + def.id).accordion('destroy')
         
        
    
    afterAllRealign: (def, renderizer) ->
        @startElement(def, renderizer)
        @afterAllStart(def, renderizer)
            
    activate: ( event, ui, def ) ->
        def.start(this)