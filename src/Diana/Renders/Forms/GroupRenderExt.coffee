class GroupRenderExt extends SpecificElementRender
    createElement: (def, renderizer) ->
        ret = document.createElement('fieldset')
        def.obj_label = document.createElement('legend')
        def.component = ret
        $(ret).append(def.obj_label) 
            
        def.setLabel(def.label) if def.label
        
        #Informa o form que será necessário inicializar o grupo
        def.getParent().addGroupRender(this)
        
        def.specificRender = this
        @element = def
        @component = ret
        renderizer.addContainer(def)
        ret
        
        
    beforeStartChildren: (def, renderizer) ->
        
            
    defineContainerWidths: (def, renderizer) ->
        
    defineContainerHeights: (def, renderizer) ->
    
    ajustRight: (element, maxRight, extra) ->        
          
            
    
        