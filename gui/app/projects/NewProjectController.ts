/// <reference path="../../../typings/angularjs/angular.d.ts"/>
/// <reference path="../../../typings/sweetalert/sweetalert.d.ts"/>
/// <reference path="./ProjectModel.ts"/>
/// <reference path="./ProjectRepositoryService.ts"/>

var ﻿fs = require('node-fs');
import { Project } from "./ProjectModel";
import { ProjectRepositoryService } from "./ProjectRepositoryService";

class NewProjectController {

    constructor(
        $scope: any,
        mainViewService,
        projectRepositoryService: IProjectRepository)
    {

        $scope.createProject = (isValid) => {

            var newProject = new Project($scope.newName);

            if (fs.existsSync(newProject.modelPath)
             || fs.existsSync(newProject.configPath))
            {
                sweetAlert({
                    title: 'Cannot create project',
                    text: "Folder [#{newProject.path}] exists and could be overwritten.\nUse [Import] to open existing project."
                });
            }

            mainViewService.set('pages/intro.jade');
            // TODO: Navigate directly to the new project options

            projectRepositoryService.add(newProject);
            $scope.newName = '';
        }

        $scope.goBack = () => mainViewService.back();

        console.log('>> [New Project] loaded');
    }
}

angular.module('app')
.controller('NewProjectController', NewProjectController);
