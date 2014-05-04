class GroupRender extends FormRender
    createElement: (def, renderizer) ->
        ret = document.createElement('fieldset')
        def.obj_label = document.createElement('legend')
        def.component = ret
        $(ret).append(def.obj_label) 
        
        if(def.align and def.align=='left')
            $(ret).addClass('groupLeft')
        else
            $(ret).addClass('group')
            
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
    
    ajustRight: (element, maxRight, extra) ->        
          
            
    
        