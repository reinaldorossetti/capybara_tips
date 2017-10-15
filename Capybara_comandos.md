## Capybara Navegando entre páginas.

```ruby
# Visitar a página desejada.
visit "https://orangehrm-demo-6x.orangehrmlive.com/auth/login"

# Podemos verificar se está na página correta com a função have_current_path.
expect(page).to have_current_path(Urls[target], url: true)
# url: true -> ele compara a url toda, sem isso ele compara uma parte.

# Podemos deixar o env.rb já a url padrão configurada.
Capybara.app_host = "https://orangehrm-demo-6x.orangehrmlive.com"

# Visitar a sub-url /auth/login.
visit "/auth/login"

```

## Capybara Actions (Ações).

```ruby
# Faz o clique no link com o texto "Save".
click_link 'Save'

# Faz o clique no Botão com o texto "awesome".
click_button 'awesome'

# Faz o clique no Botão ou Link com testo "Save".
click_link_or_button 'Save'

# Preenche o texto com "Content" no campo "Name".
fill_in 'Name', with: 'Content'

# Seleciona o Checkbox
check 'Content'
# Remove a Seleção o Checkbox
uncheck 'Content'

# Selecionar o Radio button
choose 'Content'

# Seleciona a opção pela Texto "Label".
select 'Option', from: 'Label'

# Inserir um arquivo.
attach_file Rails.root.join('spec/fixture/some_file.png')
```
```
# Procura o elemento via CSS e dar o clique.
## CSS Selector => #btn_login

find("#btn_login").click

# Procura o elemento via CSS e dar o clique no texto.
find('.clickable-text', :text => 'Click me').click

# enviando dados
element.send_keys "foo"                     #=> value: 'foo'
# enviando um enter
element.send_keys :enter
element.send_keys "tet", :left, "s"   #=> value: 'test'
element.send_keys [:control, 'a'], :space   #=> value: ' ' - assuming ctrl-a selects all contents

# ou 

find('.myselector_name>input').native.send_keys(:return)

```

## Capybara Finders (Usando a Busca do elemento no Capybara).

```ruby
# Procura todos os elementos via xpath.
all(:xpath, '//a')

# Procura todos os elementos via css.
all(:css, 'a')

# Procura todos os elementos via css, e selecionar somente o primerio.
all(:css, 'a')[1]

# Procura o primeiro elemento que encontrar via xpath.
first(:xpath, '//a')

# Procura o primeiro elemento que encontrar via css.
first(:css, 'a')

# Procura o elemento elemento via xpath que tem o atributo id. 
find('//textarea[@id="additional_newline"]')

# Procura o elemento elemento via xpath que tem o atributo id e o checked. 
find(:xpath, "//input[@id='form_pets_dog']")['checked']
# => true

# Procura o elemento via css e ativa o focus sobre o elemento.
find(:css, '#with_focus_event').trigger(:focus)
find(:css,'.wrapper').hover

# Procura o elemento e traz o valor.
find_field("test_field").value
# => 'blah'

# Procura o elemento e traz a tag do elemento.
find_by_id('red').tag_name
# => 'a'

# Procura o elemento invisível pelo atributo id. 
find_by_id("hidden_via_ancestor", visible: false)

# Procura o butão pelo nome e traz o atributo value(texto).
find_button('What an Awesome')[:value]
# => 'awesome'

# Procura o elemento link pelo nome e traz o texto.
find_link('abo').text
# => 'labore'

# Procura o elemento link pelo nome e traz o href(caminho do link).
find_link('other')[:href]
# => '/some_uri'

# Procura todos os elementos com a tag a, e faz um for para trazer o href dos elementos. 
all('a').each { |a| a[:href] }

# Procura um elemento pela class bar(.) dentro do elemento ID foo(#). 
find('#foo').find('.bar')

```

**Note:** O comando find irá esperar por um elemento aparecer na página, o padrão de espera é dois segundos podendo ser alterado. Se o elemento não aparecer, ele gerar uma mensagem de erro.

**Nota:** Em XPath a expressão // significa algo muito específico, e pode não ser o que você pensa. Contrariamente à crença comum, // significa "em qualquer parte do documento" e não "em qualquer lugar no contexto atual".


## Capybara Scoped Finder `within`

```ruby
within(search_form) do
  fill_in 'Name', with: 'iOS 7'
  click_button 'Search'
end

def search_form
  '.search_form'
end

within_fieldset("villain_fieldset") do
  # ...
end

within_table("some_table") do
  # ...
end
# Execute um bloco de código em um determinado iframe/frame pelo nome ou o índice do quadro fornecido. Fora do bloco ele volta para o contexto inicial da página (função usada <b>within_frame</b>).
# within_frame('some_frame') do CODE end
# within_frame 0 do CODE end
  def check_balance
    visit('/')

    within_frame('main'){
      fill_in 'korisnik', :with => 'foo'
      fill_in 'lozinka', :with => 'bar'
      click_button 'Potvrda unosa'
    }

    within_frame('header'){
      click_on 'Stanje' 
    }
  end

# Iframe dentro de iframe podemos fazer assim.
within_frame 0 do
  within_frame 0 do
    within_frame 0 do
      # Code
    end
  end
end


# sem o within_frame, podemos fazer com a função switch_to.

 def check_balance
    visit('/')
    # Vai trocar do contexto inicial para o frame header.
    page.driver.browser.switch_to.frame 'header'
    click_on 'Stanje' 

    # Vai trocar o frame header para o contexto inicial da página.
    page.driver.browser.switch_to.default_content
    
    # Vai trocar do contexto inicial para o frame main. 
    page.driver.browser.switch_to.frame 'main'
    # Vai trocar do frame Pai main para o subframe subframe_main. 
    page.driver.browser.switch_to.frame 'subframe_main'
    fill_in 'korisnik', :with => 'foo'
    fill_in 'lozinka', :with => 'bar'
    click_button 'Potvrda unosa'
  end

# Uma coisa legal que podemos fazer procurar o iframe, para depois mudar com o switch_to.
facebok_iframe_name = find(:xpath, "//*[@id='fb-button-explore']/span/iframe")[:name]
page.driver.browser.switch_to.frame facebok_iframe_name 

```

## Capybara Common

```ruby
visit("http://google.com")

page.current_url

# Imprime o titulo da página.
puts page.title

# Verifica se o titulo corresponde ao valor "my title".
page.has_title? "my title"

# Verifica se o titulo "my not found title" não existe mais.
page.has_no_title? "my not found title"

# Execute the given script, not returning a result. This is useful for scripts that return
# complex objects, such as jQuery statements. +execute_script+ should be used over
# +evaluate_script+ whenever possible.
#
page.execute_script("$('#change').text('Funky Doodle')")

# Evaluate the given JavaScript and return the result. Be careful when using this with
# scripts that return complex objects, such as jQuery statements. +execute_script+ might
# be a better alternative.
#
page.evaluate_script("1+3")
# => 4

using_wait_time 6 do
  # ... Changed Capybara.default_wait_time in this block scope.
end
```

## Usando o Capybara com o RSpec

A biblioteca do RSpec 2+ é supportado adicionando ao arquivo env.rb o require 'capybara/rspec'. O RSpec não é padrão no Capybara puro, ou seja você tem que adicionar a biblioteca 'capybara/rspec'.


```ruby
expect(page).to have_content("Some Content")
expect(page).to have_no_content("Some Content")

# True if there is a anchor tag with text matching regex
expect(page).to have_xpath("//a")
expect(page).to have_xpath("//a",:href => "google.com")
expect(page).to have_xpath("//a[@href => 'google.com']")
expect(page).to have_xpath("//a[contains(.,'some string')]")
expect(page).to have_xpath("//p//a", :text => /re[dab]i/i, :count => 1)

 # can take both xpath and css as input and can take arguments similar to both have_css and have_xpath
 expect(page).to have_selector(:xpath, "//p/h1")
 expect(page).to have_selector(:css, "p a#post_edit_path")

 expect(page).to have_css("input#post_title")
 expect(page).to have_css("input#post_title", :value => "Capybara cheatsheet")

 # True if there are 3 input tags in response
 expect(page).to have_css("input", :count => 3)

 # True if there or fewer or equal to 3 input tags
 expect(page).to have_css("input", :maximum => 3)

 # True if there are minimum of 3 input tags
 expect(page).to have_css("input", :minimum => 3)

 # True if there 1 to 3 input tags
 expect(page).to have_css("input", :between => 1..3)

 # True if there is a anchor tag with text hello
 expect(page).to have_css("p a", :text => "hello")
 expect(page).to have_css("p a", :text => /[hH]ello(.+)/i)

# For making capybara to take css as default selector
Capybara.default_selector = :css

# checks for the presence of the input tag
expect(page).to have_selector("input")

# checks for input tag with value
expect(page).to have_selector("input", :value =>"Post Title")

expect(page).to have_no_selector("input")

# For making capybara to take css as default selector
Capybara.default_selector = :xpath
# checks for the presence of the input tag
expect(page).to have_selector("//input")

# checks for input tag with value
expect(page).to have_selector("//input", :value =>"Post Title")

# checks for presence of a input field named FirstName in a form
expect(page).to have_field("FirstName")

expect(page).to have_field("FirstName", :value => "Rambo")
expect(page).to have_field("FirstName", :with => "Rambo")

expect(page).to have_link("Foo")
expect(page).to have_link("Foo", :href=>"googl.com")
expect(page).to have_no_link("Foo", :href=>"google.com")

# Verifica se tem o css selector, que tem o campo com visibilidade igual a falso. 
expect(page).to have_selector('#selector_id', visible: false)

```

Note: When you require 'capybara/rspec' proxy methods are installed to work around name collisions between Capybara::DSL methods all/within and the identically named built-in RSpec matchers. If you opt not to require 'capybara/rspec' you can install the proxy methods by requiring 'capybara/rspec/matcher_proxies' after requiring RSpec and 'capybara/dsl'

## Capybara Matchers (Assert)
```ruby
page.assert_selector('p#foo', :count => 4)
page.assert_selector('li', :text => 'Horse', :visible => true)
page.has_css?('li', :text => 'Horse', :visible => true)
page.has_xpath?('.//li', :text => 'Horse', :visible => true)
page.has_selector?('li', :text => 'Horse', :visible => true)
page.has_field?('Name', :with => 'Jonas')
```

## Capybara Browser functions.

```ruby
# Para mudar para uma outra janela, ou seja  mudar de contexto de uma janela inicial para a última aberta, 
# Precisamos encontrar a ultima janela com a função window_handles.last e mudar para a atual com a função switch_to.
popup = page.driver.browser.window_handles.last
page.driver.browser.switch_to.window(popup)
# Podemos voltar para a primeira janela.
main = page.driver.browser.window_handles.first
page.driver.browser.switch_to.window(main)
```

## Capybara Configurações.
```
# Mudando a espera máxima de 2 segundos para 30 segundos.

Capybara.default_max_wait_time = 30

# Segunda forma de setar várias configurações.
Capybara.configure do |config|
  config.run_server = false
  config.app_host   = 'http://www.google.com'
  config.default_max_wait_time = 30
  config.default_selector = :css
end
```
## Tratamento de erro com 'rspec/retry'.
```ruby
RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true
  # Try twice (retry once)
  config.default_retry_count = 2
  # Only retry when Selenium raises Net::ReadTimeout
  config.exceptions_to_retry = [Net::ReadTimeout]
  Capybara.javascript_driver = :webkit
end
```

## Colocando o mouse sobre o elemento, temos algumas formas mostradas abaixo:
### Forma mais simples é usando a função "hover", pra isso precisamos habilitar o natives_events na instância do browser.
```ruby

# configurando o native_events como true.
Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.native_events = true
  Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile)
end

# agora somente usar o hover, para simular o mouse sobre o elemento.
find('.some_class').hover

```
### A segunda forma é trigger/ativar o evento mouseover, nesse caso não precisamos do native_events, mas precisamos habilitar o webkit.

```ruby
RSpec.configure do |config|
  # ...
  Capybara.javascript_driver = :webkit
end

# ativando o mouseover.
page.find('#element').trigger(:mouseover)
# também podemos trigger o mouseenter
page.find('#element').trigger(:mouseenter)

**O uso da "page" nas versões novas não é necessaria.
```

# Fontes:
http://www.rubydoc.info/github/jnicklas/capybara/Capybara.configure
https://github.com/teamcapybara/capybara/blob/master/lib/capybara.rb
https://github.com/teamcapybara/capybara/blob/master/README.md

