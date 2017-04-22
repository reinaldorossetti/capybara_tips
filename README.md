
# capybara_tips

Mostrando os comandos do Capybara Framework e fazendo uma pequena comparação. Esse projetinho veio atráves de um colega do grupo do QA Ninja, ele me pediu uma ajuda, e já tinha feito uma lista de comandos do Capybara para lembrete Capybara_comandos.md que está no nosso projeto, mas nem sempre a gente sabe como usa o comando certo para determinada ocasião, quando usado de forma errada vai com certerza emitir uma mensagem de erro, colocamos alguns no final.

```
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
```

Erros comuns que podem ocorrer:

>> Messagem de frame errado:
expected to find frame nil at least 1 time but there were no matches (Capybara::ExpectationNotMet)
      ./features/step_definitions/cadastro_usuario.rb:19:in `/^poderei adicionar usuario$/'
      features/specifications/cadastro_usuario.feature:10:in `Entao poderei adicionar usuario'


>> acessou a pagina, mas o objeto nao está mais na tela, ele elemento foi usado uma vez,
e foi morto, tem que espera o elemento ser carregado novamente.
 TypeError: can't access dead object (Selenium::WebDriver::Error::UnknownError)
      ./features/step_definitions/cadastro_usuario.rb:44:in `block (2 levels) in <top (required)>'

>> usando o find quando existe varios elementos vai dar o erro abaixo:
      Ambiguous match, found 50 elements matching css "td[class*=\"edit_item tooltipped\"]" (Capybara::Ambiguous)
