fs     = require 'fs'
{exec} = require 'child_process'

appFiles  = []
applicationModeFiles  = []

inArray = []
test = []

listFiles = (path, inArray, pseudoOrder) ->
    
    files = fs.readdirSync path
        
    for file in files
        fullName = path + '/' + file

        if file.search('.coffee') > -1                
            inArray.push(fullName)
            
    for file in files
        fullName = path + '/' + file

        if fs.statSync(fullName).isDirectory()
            listFiles(fullName, inArray)
            
    inArray
                



compile = (appFiles, basePath, appName, extraCompilerOption) ->
  appContents = new Array remaining = appFiles.length
  for file, index in appFiles then do (file, index) ->
    console.log appName, file
    fs.readFile "#{file}", 'utf8', (err, fileContents) ->
      throw err if err
      appContents[index] = fileContents
      process() if --remaining is 0
  process = ->
    fs.writeFile appName + '.coffee', appContents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec 'coffee -b -o ./lib/ ' + extraCompilerOption + ' --compile ' + appName + '.coffee', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        
        fs.unlink '' + appName + '.coffee', (err) ->
          throw err if err
          console.log appName + ' preparado.'

task 'build', 'Gera os arquivos js do jqeryda, em modo de Aplicação e desenho em modo debug', ->
    listFiles('src/jqueryda', appFiles)
    listFiles('src/Mode', appFiles)
    compile(appFiles, 'src/', 'jqueryda','')
    
    appFiles = []
    listFiles('src/Clementina', appFiles)    
    compile(appFiles, 'src/Clementina/', 'jquerydaClementina','')
    
    appFiles = []
    listFiles('src/Diana', appFiles)    
    compile(appFiles, 'src/Diana/', 'jquerydaDiana','')
  
 
task 'find', 'lista os arquivos coffescript', ->
    listFiles('src/zRender', appFiles)
    listFiles('src/Mode', appFiles)
    console.log(test)
    