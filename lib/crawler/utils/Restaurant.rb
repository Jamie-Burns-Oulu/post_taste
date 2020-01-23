class Restaurant
    def initialize(name)
        @restaurant = name
        @menus = []
    end
    def get_restaurant_name
        return @restaurant
    end
    def add_menu(menu)
        @menus.push(menu)
    end
    def get_menus
        return @menus
    end
end