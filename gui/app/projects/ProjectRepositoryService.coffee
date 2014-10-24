class ProjectRepository extends Service
    
    constructor: ->
        
        # TODO: Load recent projects
        @projects = [
            new Project('Temp')
            new Project('Example - Complex', {
                files: '[D:\\Documents\\GitHub\\AngularDependencyGraph\\examples\\complex\\**\\*.js]'
            })
        ]

    getProjects: -> @projects.slice()