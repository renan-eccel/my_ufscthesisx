ufscthesisx
=================

Modelo Canônico de TCC, Monografia,  Dissertação, Tese ou Relatório de Pós--Doutorado da UFSC com
abnTeX2. Originado de endereço https://github.com/AdrianoRuseler/abntex2-ufsc com o nome
`abntex2-ufsc`, este projeto foi renomeado para `ufscthesisx`.

Entretanto, diferente do original e do modelos disponível pela Biblioteca Universitária UFSC, este
modelo não é uma classe latex, mas um pacote. Portanto para usá-lo, você deve utilizar a classe
`abntex2` como classe do seu documento e então incluir este trabalho como um pacote latex na
seguinte ordem:
```latex
\documentclass[
10pt,
a5paper,
twoside, % Impressão nos dois lados da folha
chapter=TITLE, % Título de capítulos em caixa alta
section=TITLE  % Título de seções em caixa alta
]{abntex2}

\usepackage[alf]{abntex2cite}
\usepackage{setup/ufscthesisx}
```

Se você inverter a ordem de inclusão, as citações bibliográficas não irão funcionar. O modelo
disponibilizado pela Biblioteca Universitária da UFSC no presente momento da criação deste trabalho
é baseado na versão da classe `abntex 0.8.2`, portanto como considerado muito antiga, tratou-se de
buscar um modelo de seja baseado na última versão do `abntex2 1.9.6`, no qual trata este trabalho.



# Instalação

Para poder utilizar a classe é necessário instalar uma longa lista de pacotes além do pacote abnTeX2
na sua distribuição LaTeX, as configurações específicas para cada sistema, podem ser encontradas no
link abaixo para o pacote `abnTeX2`:

1. [abntex2 CTAN](http://www.ctan.org/pkg/abntex2)
1. [abnTeX2 Instalação](https://github.com/abntex/abntex2/wiki/Instalacao)

Depois no diretório do seu projeto faça um clone dos arquivos do repositório:
```bash
git clone --recursive https://github.com/evandrocoan/ufscthesisx
```

Este repositório já contém um exemplo de tese com uso avançado de conceitos e latex. Se você tive
interesse em utilizar esse template, você somente precisa preencher corretamente os seus dados como
nome do orientador, coorientador, seu nome, nome da sua instituição, do seu curso, departamento,
etc.

Para isso abra o arquivo `settings.tex` no diretório principal e altere os dados fictícios para os
corretos. O arquivo `modelo-ufsc-main.tex` é o arquivo principal do template utilizado, ele trata de
carregar todos os pacotes necessários e incluir os arquivos latex que contém as partes da sua
monografia.



# Uso

A ideia desse projeto é fazer com que você utilize a classe abnTeX2, mas com customizações voltadas
para as teses da UFSC, fazendo com que o seu uso seja idêntico ao uso direto da classe abnTeX2.

A documentação dessa classe pode ser encontrada nos link a seguir e também é possível encontrar
modelos de documentos que utilizam a classe para tomar como base:

1. [Documentação e Modelos abnTeX2](https://www.ctan.org/pkg/abntex2)


#### Normas da UFSC para trabalhos acadêmicos

1. [Geral](http://portal.bu.ufsc.br/normalizacao/)
1. [Capa](http://www.bu.ufsc.br/design/Guia_Rapido_Diagramacao_Trabalhos_Academicos.pdf)
1. [Normas em docx](http://www.bu.ufsc.br/design/TemplateTrabalhoAcademico.docx)
1. [Dados da ficha](http://ficha.bu.ufsc.br/)
1. [Ficha de identificação da obra](http://portal.bu.ufsc.br/servicos/ficha-de-identificacao-da-obra/)


#### Site da Biblioteca abnTeX2

1. [abnTeX2](http://www.abntex.net.br/)
1. https://github.com/abntex/abntex2



# Mudanças

Para ver as mudanças, acesse o histórico do git no endereço:

1. https://github.com/evandrocoan/ufscthesisx/commits/master

Ou clone reste repositório e execute seguinte comando do cliente git:

1. `git log`
1. https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History


# Licença

```
Copyright (c) 2012-2014 by abnTeX2 group at http://abntex2.googlecode.com/
Copyright (c) 2014-2015 Mateus Dubiela Oliveira
Copyright (c) 2015-2016 Adriano Ruseler
Copyright (c) 2017 Evandro Coan

É concedida permissão, gratuitamente, a qualquer pessoa que obtenha uma cópia deste modelo e
software e arquivos de documentação associados (o "Software"), para ter estes arquivos com os
direitos de uso, cópia, modificação, mesclagem, publicar, distribuir, e permitir que as pessoas a
quem o Software seja fornecido tenham estes mesmos direitos, ambos sujeitos às seguintes condições:

O aviso de direitos autorais acima e este aviso de permissão devem ser incluídos em todas as cópias
ou partes substanciais do Software.

Os arquivos `chapters/chapter_1.tex`, `chapters/chapter_2.tex` e `setup/ufscthesisx.sty` estão
licenciados sobre a licença LPPL (The Latex Project License). Portanto você deve respeitar essa
licença para esses arquivos ao invés dessa. Entretanto a condição a seguir continuará valendo sobre
esses arquivos licenciados pela licença LPPL:

OS ARQUIVOS NESTE REPOSITÓRIO SÃO FORNECIDOS "NO ESTADO EM QUE SE ENCONTRAM", SEM GARANTIA DE
QUALQUER TIPO, EXPRESSA OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO ÀS GARANTIAS DE
COMERCIALIZAÇÃO, APTIDÃO PARA UM PROPÓSITO ESPECÍFICO E NÃO INFRACÇÃO. EM NENHUMA CIRCUNSTÂNCIA, OS
AUTORES OU TITULARES DE DIREITOS AUTORAIS SERÃO RESPONSÁVEIS POR QUALQUER RECLAMAÇÃO, DANOS OU OUTRA
RESPONSABILIDADE, SEJA EM AÇÃO DE CONTRATO, DELITO OU DE OUTRA FORMA, DECORRENTE, DESTE OU
RELACIONADO COM DOS ARQUIVOS DESTE REPOSITÓRIO OU O USO OU OUTRAS NEGOCIAÇÕES NO MODELO E SOFTWARE.
```




