class zRender
    constructor: (@render, @sender) ->
        if !(jQuery?)
            console?.log('jQuery não está presente')
        render.parent = this
        sender.parent = this
        @_configureDefaults()
   
    _configureDefaults: ()->
        @config = {}
        @config.jquerydaPath = '/js/jqueryda/'
        
    _parse: (commands) ->
                    
        for command, elements of commands            
            test = command * 1
            if isNaN(test)
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
        
    process: (commands) ->
        @_parse(commands)

$.fn.getClientRects = (i) -> 
    i = @.get(0).getClientRects()[0]

jqueryda=null
config=null
messageManager=null
$ ->
    jqueryda = new zRender(new Render(), new Sender())
    jqueryda.start()
    messageManager = new MessageManager(jqueryda)
    jqueryda.messageManager = messageManager
    config = jqueryda.config