fs = require 'node-fs'
jade = require 'jade'

# TODO: Remove Angular ?
class Intro extends Controller
    constructor: -> # (newProjectFactory, importProjectService, recentProjectsService) ->
        
        @template = jade.compile fs.readFileSync('./views/intro.jade')
            
        $('.main').html @template({title:"Angular Module Graph Generator"})