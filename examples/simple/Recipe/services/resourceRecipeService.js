(function () {
    angular.module('recipe').factory('resourceRecipeService', ["$resource", function ($resource) {

        var resource = $resource('api/Recipes/', { id: '@id' });
        return {
            getRecipe: function (recipeId) {

                return resource.get({ id: recipeId }).$promise;
            },
            getRecipes: function () {
                return resource.query().$promise;
            }
        }
    }]);

})();