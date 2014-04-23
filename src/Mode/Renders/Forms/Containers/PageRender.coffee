class PageRender extends FormRender
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
               
        def.specificRender = this
        @element = def
        
        @component = ret
        $(@component).addClass('page')
        
        def.parent.specificRender.addPage(def, renderizer)
        renderizer.addContainer(def)
        ret
        
    beforeStartChildren: (def, renderizer) ->
        def.setWidth(def.width) if def.width
        
        
    defineContainerWidths: (def, renderizer) ->
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        
        groups = groupRenders.length
        for group in groupRenders           
           group.element.setWidth(100 + "%")
           margin = group.element.getLeft() - group.element.parent.getLeft()
           newSize = group.element.getRealWidth() - margin
           group.element.setWidth(newSize)
            
        pagers = pagerRenders.length   
        for pager in pagerRenders
            pager.element.setWidth(94.42 + "%")