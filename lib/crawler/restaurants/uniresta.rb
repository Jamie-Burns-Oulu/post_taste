require_relative '../utils/Restaurant'
require 'date'


class Uniresta
    def initialize(driver)
        @driver = driver
        @weekday = get_weekday()
        @menu_list = []
        @kastari_lunchlist_holder = '1'
        @vanilla_lunchlist_holder = '5'
    end
    def get_restaurants()
        open_connection()
        kastari = get_kastari_menus()
        #vanilla = get_vanilla_menus()
        return [kastari]
    end

    private

    def get_kastari_menus()
        kastari_menus = @driver.find_elements(css: "div.lunchlist-holder#{@kastari_lunchlist_holder} div##{@weekday} .food-list p")
        kastari = Restaurant.new('Kastari')
        if kastari_menus.length
            kastari_menus = kastari_menus[1..] #remove first element
            for menu_item in kastari_menus do
                kastari.add_menu(menu_item.text.strip)
            end
        end
        return kastari
    end
    
    def get_vanilla_menus()
        # Sketchy
        vanilla_menus = @driver.find_elements(css: "div.lunchlist-holder#{@vanilla_lunchlist_holder} div##{@weekday} .food-list p")
        vanilla = Restaurant.new('Vanilla')
        vanilla_menus = vanilla_menus[0..-1] #remove last element
        for menu_item in vanilla_menus do
            vanilla.add_menu(menu_item.text.strip)
        end
        return vanilla
    end
    
    def get_weekday()
        weekdays_fin = ['su', 'mo', 'ti', 'ke', 'to', 'pe', 'la'] # ruby starts weekdays from sunday
        today = Date.today.wday
        return weekdays_fin[today]
    end
    def open_connection()
        @driver.get('https://www.uniresta.fi/en/ajax-lunchlist/')
    end
end

