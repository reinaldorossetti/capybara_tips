require "selenium-webdriver"
require "rspec"

# Passo o caminho do driver, se ele tiver no path nao precisa.
Selenium::WebDriver::Chrome.driver_path = "/home/reiload/drivers/chromedriver32"
# cria a instancia do driver, para poder usar as funcoes do selenium.
@driver = Selenium::WebDriver.for :chrome
# pega a url da pagina.
@base_url = "https://orangehrm-demo-6x.orangehrmlive.com/"
# uma espera implicita no browser de 30s.
@driver.manage.timeouts.implicit_wait = 30
# maximiza a tela
@driver.manage.window.maximize

# espera dinamica em ruby.
wait = Selenium::WebDriver::Wait.new(timeout: 20) # seconds

# Nosso teste.
# carrega a url
@driver.get(@base_url + "/auth/login")
# limpa o campo antes de enviar o comando.
@driver.find_element(:id, "txtUsername").clear
# envia para o campo o nome do usuario.
@driver.find_element(:id, "txtUsername").send_keys "admin"
# limpa o campo antes de enviar o comando.
@driver.find_element(:id, "txtPassword").clear
# envia para o campo o password e depois da o click no botao.
@driver.find_element(:id, "txtPassword").send_keys "admin"
@driver.find_element(:id, "btnLogin").click

# faco uma espera dinamica se o iframe esta na pagina.
test1 = wait.until{@driver.find_element(:css, "iframe[id*=\"noncoreIframe\"]")}
# mudo para o iframe correto.
@driver.switch_to.frame("noncoreIframe")


### Como boa pratica procuro o elemento primeiro jah coma a espera dinamica.
### Depois dou o click no elemento.

test1 = wait.until{@driver.find_element(:css, ".collapsible-header.waves-effect.waves-orange")}
puts test1
test1.click

test2 = wait.until{@driver.find_element(:css, "#menu_admin_UserManagement a")}
puts test2
test2.click

test3 = wait.until{@driver.find_element(:css, "#menu_admin_viewSystemUsers > span.left-menu-title")}
puts test3
test3.click

# espera todos os elementos edit na tela, pra nao deixa uma espera fixa aqui.
wait.until{ @driver.find_elements(:css, "td[class*=\"edit_item tooltipped\"]")}
# Muda para o iframe principal novamente.
@driver.switch_to.default_content
test4 = wait.until{ @driver.find_element(:css, ".btn-floating > i:nth-child(1)")}
puts test4
test4.click
sleep(7) # somente pra ver o menu abrir.
