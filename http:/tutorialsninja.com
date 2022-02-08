import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By


class TestSelenium(unittest.TestCase):

    def test_add_to_shopping_cart(self) -> None:
        """Добавление в корзину"""
        driver = webdriver.Chrome(executable_path='./chromedriver')

        driver.get('http://tutorialsninja.com/demo/')
        driver.maximize_window()

        search_field = driver.find_element(By.NAME, "search")
        search_field.send_keys("iphone")
        search_field.send_keys(Keys.RETURN)

        add_to_cart_button = driver.find_element(By.XPATH, '//*[@id="content"]/div[3]/div/div/div[2]/div[2]/button[1]')
        add_to_cart_button.click()

        shopping_cart_link = driver.find_element(By.LINK_TEXT, 'Shopping Cart')
        shopping_cart_link.click()

        self.assertTrue("product 11")
        driver.close()

    def test_removing(self) -> None:
        """Удаление из корзины"""
        driver = webdriver.Chrome(executable_path='./chromedriver')

        driver.get('http://tutorialsninja.com/demo/')
        driver.maximize_window()

        search_field = driver.find_element(By.NAME, "search")
        search_field.send_keys("iphone")
        search_field.send_keys(Keys.RETURN)

        add_to_cart_button = driver.find_element(By.XPATH, '//*[@id="content"]/div[3]/div/div/div[2]/div[2]/button[1]')
        add_to_cart_button.click()

        shopping_cart_link = driver.find_element(By.LINK_TEXT, 'Shopping Cart')
        shopping_cart_link.click()


        remove_button = driver.find_element(By.XPATH, '//*[@id="content"]/form/div/table/tbody/tr/td['
                                                     '4]/div/span/button[2]')
        remove_button.click()

        driver.close()


