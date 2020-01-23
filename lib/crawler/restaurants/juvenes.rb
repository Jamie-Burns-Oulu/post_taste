require_relative '../utils/Restaurant'

class Juvenes
    def initialize(driver)
        @driver = driver
        @list_of_restaurants = []
    end
    def get_restaurants()
        open_connection()
        element = @driver.find_elements(css: 'div#LEFT div.restaurant-list restaurant-component')
        element.each do |res|
            res_info_path = 'div.RestaurantListItem'
            res_info = res.find_elements(css: res_info_path)
            for restaurant in res_info do
                if restaurant
                    full_name = restaurant.find_element(css: 'div.RestaurantAddress a').text
                    if full_name.include? 'Restaurant'
                        name = full_name['Restaurant'.length..-1].strip
                        name = name.split('|').first.strip
                        res_object = Restaurant.new(name)
                        menu_list = restaurant.find_elements(css: 'div.RestaurantMenus lunch-menu-component ')
                        for menu in menu_list do
                            if menu
                                menu_list = menu.find_elements(css: 'meal-options-list-component')
                                for menu_list_item in menu_list
                                    menu_food_item_list = menu_list_item.find_elements(css: 'div.MenuItem')
                                    for food_item in menu_food_item_list do
                                        if food_item.text.strip.length > 1
                                            menu_food_item = food_item.text.strip
                                            res_object.add_menu(menu_food_item)
                                        end
                                    end
                                end
                            end
                        end 
                        @list_of_restaurants.push(res_object)
                    end
                end
            end
        end
        return @list_of_restaurants     
    end

    private

    def open_connection()
        @driver.get('https://www.juvenes.fi/oulu/en')

    end
end