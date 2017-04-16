from selenium import webdriver
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support.expected_conditions import presence_of_element_located, staleness_of,\
        visibility_of_any_elements_located
from selenium.webdriver.common.by import By


driver = webdriver.Chrome(executable_path="/home/reiload/drivers/chromedriver32")
driver.get('https://orangehrm-demo-6x.orangehrmlive.com/auth/login')
driver.maximize_window()

def SelectorWait(driver, locator):
    return WebDriverWait(driver, 45).until(presence_of_element_located((By.CSS_SELECTOR, locator)))

def SelectorWait2(driver, locator):
    return WebDriverWait(driver, 45).until(visibility_of_any_elements_located((By.CSS_SELECTOR, locator)))

driver.find_element_by_id("txtUsername").clear()
driver.find_element_by_id("txtUsername").send_keys("admin")
driver.find_element_by_id("txtPassword").clear()
driver.find_element_by_id("txtPassword").send_keys("admin")
driver.find_element_by_id("btnLogin").click()

SelectorWait(driver, "iframe[id*=\"noncoreIframe\"]")
driver.switch_to.default_content()
driver.switch_to.frame("noncoreIframe")

test1 = SelectorWait(driver, ".collapsible-header.waves-effect.waves-orange")
test1.click()

test2 = driver.find_element(By.CSS_SELECTOR, "#menu_admin_UserManagement a")
test2.click()

test3 = driver.find_element(By.CSS_SELECTOR, "#menu_admin_viewSystemUsers > span.left-menu-title")
test3.click()

driver.switch_to.default_content()
SelectorWait2(driver, "td[class*=\"edit_item tooltipped\"]")
test4 = SelectorWait(driver, ".btn-floating > i:nth-child(1)")
test4.click()
