Vimos um Exemplo de um teste usando o framework Capybara, e estudamos os comandos, agora vamos falar sobre boas práticas, muitas das vezes executamos o nosso teste falha e não sabemos porque falhou eu fiz tudo certo, mas por algum motivo desconhecido e falhou. 

Um exemplo de um teste fraco é quando usamos um jquery ou javascript para dar um clique, isso geralmente acontece quando a aplicação não é boa e não responde ao click do capybara, quando colocamos um javascript ou jquery pra ser executado, temos que ter muito cuidado, pois quando você usa eles não existe nenhuma espera desses elementos, ou seja tem uma probabilidade muito grande de ele falhar.

1) SCRIPT FRACO: 
page.execute_script "$('button:contains(#{button})').click()"

2) SCRIPT MAIS ROBUSTO
find("button", text: button)
page.execute_script "$('button:contains(#{button})').click()"

3) MELHOR CASO
element = find("button", text: button)
page.execute_script ("arguments[0].click()", element.native)

No primeiro caso quando você executa o Jquery ele vai executar o comando, mas não vai esperar o elemento carregar na tela, isso vai deixar seu teste super fraco a falhas. No segundo caso usamos o find antes de executar o jquery e o find vai esperar um determinado tempo. No terceiro caso que é o melhor você usa a espera do capybara e reutiliza o elemento dentro do seu script, o que torna o melhor caso.
