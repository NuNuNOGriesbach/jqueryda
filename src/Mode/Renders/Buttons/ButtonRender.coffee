class ButtonRender extends SpecificElementRender
    constructor: (def) ->
        super(def)
        @inputType = 'button'
    
    createElement: (def, renderizer) ->
        ret = document.createElement('div')        
        def.obj_field = document.createElement('input')
        
        def.obj_field.type = @inputType
                
        def.setValue(def.value)
                
        $(def.obj_field).addClass('input')
        
        $(ret).append(def.obj_field)
        $(ret).addClass('button')
               
        def.specificRender = this
        ret
        
    #atribui eventos ao elemento renderizado    
    bindEvent: (sender, def, eventName, functionName, container, sendList, serverEvent ) ->
        self=this
        $(def.obj_field).on(eventName, (e)->
            functionExec = functionName + '("' + sendList + '", "'+container+'","'+serverEvent+'",def,self,sender);';
            try
                #console.log(sender)
                eval (functionExec)
            catch e
                alert('Execute ' + functionName + ': ' + e);
            
        )