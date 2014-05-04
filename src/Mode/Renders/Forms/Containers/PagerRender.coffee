class PagerRender extends FormRender
    createElement: (def, renderizer) ->
        if def.style == 'vertical'
            return @_createElementVertical(def, renderizer)
            
        ret = document.createElement('div')
        def.obj_pager = document.createElement('ul')
        def.component = ret
        $(ret).append(def.obj_pager) 

        $(ret).addClass('pager')
        
        #Informa o form que será necessário inicializar o grupo
        def.getParent().addPagerRender(this)
        
        def.specificRender = this
        renderizer.addContainer(def)
        @element = def 
        
        ret
    
    _createElementVertical: (def, renderizer) ->
        ret = document.createElement('div')
        def.obj_pager = ret
        def.component = ret
        
        $(ret).addClass('pager')
        
        #Informa o form que será necessário inicializar o grupo
        def.getParent().addPagerRender(this)
        
        def.specificRender = this
        renderizer.addContainer(def)
        @element = def
        
        ret
    
    addPage: (def, renderizer) ->
        if def.parent.style == 'vertical'
            return @_addPageVertical(def, renderizer)
            
        tabButton =  document.createElement('li')
        link = document.createElement('a')
        $(link).attr('href', '#' + def.id).html(def.label)
        $(tabButton).append(link)
        $(@element.obj_pager).append(tabButton)
        
    _addPageVertical: (def, renderizer) ->
                    
        tabButton =  document.createElement('h3')     
        $(tabButton).html(def.label)
        $(@element.obj_pager).append(tabButton)
        
    defineContainerWidths: (def, renderizer) ->
        for page in @element.children            
            page.setWidth('100%')    
        
        