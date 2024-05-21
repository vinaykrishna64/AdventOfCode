clear all
clc
filename = 'input.txt';
S = readlines(filename);
S = S.erase(["contains ",")"]);
S = S.split(" (");
ingredients = [];
allergens = [];
for iidx = 1:length(S)
    ingredients = [ingredients; S(iidx,1).split(" ")];
    allergens = [allergens; S(iidx,2).split(", ")];
end
ingredients = unique(ingredients);
allergens = unique(allergens);
for idx = 1:numel(ingredients)
    ing_count(idx) = 0;
    for jdx = 1:length(S)
        ing_count(idx) = ing_count(idx) + sum(strcmp(split(S(jdx,1)," "),ingredients(idx)));
    end
end

allergens = sort(allergens);
[allergen_ing] = part_1(ingredients,allergens,S);

fprintf('part 1 = %14d \n',sum(ing_count(sum(ingredients == allergen_ing,2) == 0)))

fprintf('part 2 = %s \n',allergen_ing.join(","))
function [allergen_ing] = part_1(ingredients,allergens,S)
   % collect ingredients which might have the specifc allergen
    allergen_ing_map = struct();
    for idx = 1:numel(allergens)
        ing = [];
        for jdx = 1:length(S)
            if any(strcmp(split(S(jdx,2),", "),allergens(idx)))
                if numel(ing)
                    ing = intersect(split(S(jdx,1)," "),ing);
                else
                    ing = split(S(jdx,1)," ");
                end
            end
        end
        allergen_ing_map.(allergens(idx)) =  ing;
    end
    % correct until each alergen has an unique ingredient
    for idx = 1:numel(allergens)
        for jdx = 1:numel(allergens)
            if numel(allergen_ing_map.(allergens(idx))) ~= 1
                if idx ~= jdx
                    allergen_ing_map.(allergens(idx)) = setdiff(allergen_ing_map.(allergens(idx)),allergen_ing_map.(allergens(jdx)));
                end
            end
        end
    end
    allergen_ing = [];
    for idx = 1:numel(allergens)
        allergen_ing = [allergen_ing, allergen_ing_map.(allergens(idx))];
    end
end