(function() {
    angular.module('recipe').factory('simpleRecipeService',
        ['recipeValue', 'recipeValues', function (recipeValue, recipeValues) {
        
        return {
            getRecipe : function(recipeId) {
                return recipeValue;
            },
            getRecipes : function() {
                return recipeValues;
            }
        }
    }]);

})();