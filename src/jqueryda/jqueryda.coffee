class zRender
    constructor: (@render, @sender) ->
        if !(jQuery?)
            console?.log('jQuery não está presente')
        render.parent = this
        sender.parent = this
    
    _parse: (commands) ->
        for command, elements of commands
            if (command * 1) != 'NaN'
                @execute command, elements
            else
                @_parse(elements)
        @
    
    _configureHumanSizes: () ->
        @render.configureFontSizes()
    
    execute: (command, elements) ->
        executerName = command + 'Command'
        eval 'var executerInstance = new ' + executerName + '(this)'        
        executerInstance.execute(elements)
    
    
    
    start: ->
        @_configureHumanSizes()
        @_parse(commands) if commands

$.fn.getClientRects = (i) -> 
    i = @.get(0).getClientRects()[0]

z=null
$ ->
    z = new zRender(new Render(), new Sender())
    z.start()