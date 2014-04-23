class PageRenderExt extends PageRender

    beforeStartChildren: (def, renderizer) ->
        def.setWidth(def.width) if def.width
        
    