# capybara_tips
Mostrando os comandos do Selenium/Capybara Framework.



Given(/^que esteja na home do site Orangehrm$/) do
  visit "https://orangehrm-demo-6x.orangehrmlive.com/auth/login"
end

When(/^logar como administrador$/) do
  fill_in('txtUsername', :with => 'admin')
  fill_in('txtPassword', :with => 'admin')
  click_button('btnLogin')
end

Then(/^poderei adicionar usuario$/) do

  # espero a pagina carregar esperando o iframe.
  iframe = find("iframe")
  page.driver.browser.switch_to.default_content

  # Voce pode usar a opção mais comum no selenium que eh switch_to
  # page.driver.browser.switch_to.frame 'noncoreIframe'
  # Estou usando a opcao within_frame, que apos o bloco de codigo
  # volta a o frame padrao.

  within_frame('noncoreIframe'){

    # Nao funciou click no Admin, pois o texto tem em outros lugares.
    # click_on 'Admin'

    # Trouxe todos os elementos css, e fiz o click no primeiro
    test1 = all(:css, ".collapsible-header.waves-effect.waves-orange")
    test1[0].click

    # De forma reduzida podemos fazer no capybara.
    # first(:css, ".collapsible-header.waves-effect.waves-orange").click
    # No entanto prefiro procura o elemento e depois dar o click,
    # acho que facilita muito a manutencao assim.

    test2 = find('#menu_admin_UserManagement a')
    test2.click

    test3 = find('#menu_admin_viewSystemUsers > span.left-menu-title')
    test3.click

  }

  # se eu colocar o comando all dentro do within_frame vai falhar,
  # pois ele nao faz mais parte do iframe acima.
  all("td[class*=\"edit_item tooltipped\"]")

  test4 = find(".btn-floating > i:nth-child(1)")
  test4.click

  sleep 10 # Para ver o menu adicionar usuario

end
