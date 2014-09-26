(function () {
    angular.module('recipe')
    .controller('recipeCtrl', ['$scope', 'simpleRecipeService', function ($scope, recipeService) {
        $scope.recipe = recipeService.getRecipe(1);
    }]);
})(); 