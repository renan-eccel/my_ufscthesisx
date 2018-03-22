ufscthesisx
=================

Modelo Canônico de TCC, Monografia,  Dissertação, Tese ou Relatório de Pós--Doutorado da UFSC com
abnTeX2. Originado de endereço https://github.com/AdrianoRuseler/abntex2-ufsc com o nome
`abntex2-ufsc`, este projeto foi renomeado para `ufscthesisx`.

Esse projeto não está vinculado a nenhum órgão da UFSC.

Esta não é uma classe LaTeX, mas um pacote. Para usá-lo, você deve utilizar a classe
`abnTeX2` como classe do seu documento e então incluir `ufscthesisx.sty` como um pacote LaTeX na
seguinte ordem:
```latex
\PassOptionsToPackage{style=abnt,backref=true,backend=biber,citecounter=true}{biblatex}
\AfterClass{memoir}
{
    \RequirePackage{biblatex}
}
\documentclass[
10pt, %Padrão UFSC para versão final
a5paper, %Padrão UFSC para versão final
% 12pt, %Pode usar tamanho 12pt para defesa
% a4paper, %Pode usar a4 para defesa
twoside, % Impressão nos dois lados da folha
chapter=TITLE, % Título de capítulos em caixa alta
section=TITLE  % Título de seções em caixa alta
]{abntex2}

\usepackage{setup/ufscthesisx}
```

Se você inverter a ordem de inclusão, as citações bibliográficas não irão funcionar. 

<!--O modelo disponibilizado pela Biblioteca Universitária da UFSC no presente momento da criação deste trabalho
é baseado na versão da classe `abntex 0.8.2`, portanto como considerado muito antiga, tratou-se de
buscar um modelo de seja baseado na última versão do `abntex2 1.9.6`, no qual trata este trabalho.
 -->

Está disponibilizado, além o pacote `ufscthesisx.sty`, um *template* (arquivo `main.tex` e outros) 
para que possa escrever seu trabalho.



# Instalação

## Instalar `LaTeX` e `abnTeX2` 

Para poder utilizar a classe é necessário ter uma distribuição atual do LaTeX, incluindo o pacote abnTeX2. As
configurações específicas para cada sistema, podem ser encontradas no link abaixo para o pacote `abnTeX2`:



1. [abntex2 CTAN](http://www.ctan.org/pkg/abntex2)
1. [abnTeX2 Instalação](https://github.com/abntex/abntex2/wiki/Instalacao)



## Baixando diretamente

Caso queria, pode baixar diretamente o arquivo `zip` clique 
[aqui](https://github.com/UFSC/ufscthesisx/releases/download/v1.0/ufscthesisx.zip) e descompacte o arquivo.


## Utilizando `git`

No diretório do seu projeto faça um clone (recursivo) dos arquivos do repositório:
```bash
git clone --recursive https://github.com/ufsc/ufscthesisx
```

Este repositório já contém um exemplo de tese com uso avançado de conceitos e LaTeX. Se você tive
interesse em utilizar esse *template*, você somente precisa preencher corretamente os seus dados como
nome do orientador, coorientador, seu nome, nome da sua instituição, do seu curso, departamento,
etc.

Para isso abra o arquivo `settings.tex` no diretório principal e altere os dados fictícios para os
corretos. O arquivo `main.tex` é o arquivo principal do *template* utilizado, ele trata de
carregar todos os pacotes necessários e incluir os arquivos LaTeX que contém as partes da sua
monografia.


## Utilizando Overleaf

Se você quiser, pode utilizar o [Overleaf](www.overleaf.com), um sistema de editoração *online* de textos em LaTeX. 
Se você já tiver uma conta no Overleaf pode fazer o *upload* do arquivo `.zip` baixado acima ou então faça o *upload* automaticamente com a 
última versa clicando [aqui](http://overleaf.com/docs?snip_uri=https://github.com/UFSC/ufscthesisx/releases/download/v1.0.1/ufscthesisx.zip)


# Uso

A ideia é fazer com que você utilize a classe abnTeX2, mas com customizações voltadas
para as normas de trabalhos acadêmicos da UFSC, fazendo com que o seu uso seja idêntico ao uso direto da classe abnTeX2.

A documentação dessa classe pode ser encontrada nos link a seguir e também é possível encontrar
modelos de documentos que utilizam a classe para tomar como base:

1. [Documentação e Modelos abnTeX2](https://www.ctan.org/pkg/abntex2)

Entretanto, apesar das instruções iniciais do projeto serem para utilizar diretamente a classe
`abntex2`, existem algumas incompatibilidades com outros pacotes do LaTeX que precisam ser corrigidos. Para isso
você pode utilizar você pode incluir o arquivo `setup.tex` que faz as correções do `abntex2`:

```latex
\input{setup/setup}
\documentclass[
10pt, %Padrão UFSC para versão final
a5paper, %Padrão UFSC para versão final
% 12pt, %Pode usar tamanho 12pt para defesa
% a4paper, %Pode usar a4 para defesa
twoside, % Impressão nos dois lados da folha
chapter=TITLE, % Título de capítulos em caixa alta
section=TITLE  % Título de seções em caixa alta
]{abntex2}
\usepackage{setup/ufscthesisx}
```

Uma maneira  de utilizar esse *template*, caso você seja usuário de `git`, é fazer o clone dele como um submodule de sua tese,
e em seu arquivo principal incluir o seguinte cabeçalho para carregar os pacotes básicos:
```latex
% You need to run `pdfTeX` 5 times on the following order: 1. `pdfTeX`, 2. `biber`, 3. `pdfTeX` 4.
% `pdfTeX` 5. `pdfTeX` 6. `biber` 7. `pdfTeX`, when the bibliography includes a cyclic reference to
% another bibliography, so we need a last pass to fix the bibliography undefined references.

\input{ufscthesisx/setup/setup}

\documentclass[
10pt, %Padrão UFSC para versão final
a5paper, %Padrão UFSC para versão final
% 12pt, %Pode usar tamanho 12pt para defesa
% a4paper, %Pode usar a4 para defesa
twoside, % Impressão nos dois lados da folha
chapter=TITLE, % Título de capítulos em caixa alta
section=TITLE  % Título de seções em caixa alta
]{abntex2}

% Load the UFSC thesis settings
\usepackage{ufscthesisx/setup/ufscthesisx}

% Load all required basic packages
\input{ufscthesisx/setup/utilities/basic}
\input{ufscthesisx/setup/utilities/commands}

% Bad boxes settings and programming environments
\input{ufscthesisx/setup/utilities/badboxes}
\input{ufscthesisx/setup/utilities/programming}

% Input a empty list of commands when on debug mode
\input{ufscthesisx/setup/utilities/commands_list}
```

Você também pode copiar o arquivo de configuração `settings.tex` para o seu diretório principal da
sua tese e então inclui-lo. Também deve utilizar `references.bib` :
```latex
% Altere o arquivo settings.tex para incluir suas configurações.
\input{settings}

% Utilize ou altere o arquivo 'aftertext/references.bib' para incluir sua bibliografia.
\addbibresource{aftertext/references.bib}
```



##  Normas da UFSC para trabalhos acadêmicos
Na UFSC, a Biblioteca Central disponibiliza um site específico para as normas e foi com base nessas informações que este projeto foi feito.
1. [Geral](http://portal.bu.ufsc.br/normalizacao/)
1. [Normas de Citação](http://www.bu.ufsc.br/design/Citacao1.htm)
1. [Normas em docx](http://www.bu.ufsc.br/design/TemplateTrabalhoAcademico.docx)
1. [Capa](http://www.bu.ufsc.br/design/Guia_Rapido_Diagramacao_Trabalhos_Academicos.pdf)
1. [Dados da ficha](http://ficha.bu.ufsc.br/)
1. [Ficha de identificação da obra](http://portal.bu.ufsc.br/servicos/ficha-de-identificacao-da-obra/)


## Site da abnTeX2

1. [abnTeX2](http://www.abntex.net.br/)
1. https://github.com/abntex/abntex2
1. https://github.com/abntex/biblatex-abnt




# Mudanças

Para ver as mudanças, acesse o histórico do `git` no endereço:

1. https://github.com/ufsc/ufscthesisx/commits/master

Ou clone este repositório e execute seguinte comando do cliente git:

```bash
git log https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History
```

# Licença

```
Copyright (c) 2012-2014 by abnTeX2 group at http://abntex2.googlecode.com/
Copyright (c) 2014-2015 Mateus Dubiela Oliveira
Copyright (c) 2015-2016 Adriano Ruseler
Copyright (c) 2017-2018 Evandro Coan, Luiz Rafael dos Santos

É concedida permissão, gratuitamente, a qualquer pessoa que obtenha uma cópia deste modelo e
software e arquivos de documentação associados (o "Software"), para ter estes arquivos com os
direitos de uso, cópia, modificação, mesclagem, publicar, distribuir, e permitir que as pessoas a
quem o Software seja fornecido tenham estes mesmos direitos, ambos sujeitos às seguintes condições:

O aviso de direitos autorais acima e este aviso de permissão devem ser incluídos em todas as cópias
ou partes substanciais do Software.

Os arquivos `chapters/intro.tex`, `chapters/chapter_1.tex` e `setup/ufscthesisx.sty` estão
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




