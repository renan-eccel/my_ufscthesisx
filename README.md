ufscthesis
=================

Modelo Canônico de TCC, Monografia,  Dissertação, Tese ou Relatório de Pós--Doutorado da UFSC com
abnTeX2. Originado de endereço https://github.com/AdrianoRuseler/abntex2-ufsc com o nome
`abntex2-ufsc`, este projeto foi renomeado para `ufscthesis`.

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
\usepackage{setup/ufscthesis}
```

Se você inverter a ordem de inclusão, as citações bibliográficas não irão funcionar. O modelo
disponibilizado pela Biblioteca Universitária da UFSC no presente momento da criação deste trabalho
é baseado na versão da classe `abntex 0.8.2`, portanto como considerado muito antiga, tratou-se de
buscar um modelo de seja baseado na última versão do `abntex2 1.9.6`, no qual trata este trabalho.


#### Normas da UFSC para trabalhos acadêmicos

1. [Geral](http://portal.bu.ufsc.br/normalizacao/)
1. [Capa](http://www.bu.ufsc.br/design/Guia_Rapido_Diagramacao_Trabalhos_Academicos.pdf)
1. [Normas em docx](http://www.bu.ufsc.br/design/TemplateTrabalhoAcademico.docx)
1. [Dados da ficha](http://ficha.bu.ufsc.br/)
1. [Ficha de identificação da obra](http://portal.bu.ufsc.br/servicos/ficha-de-identificacao-da-obra/)


#### Site da Biblioteca abnTeX2

1. [abnTeX2](http://www.abntex.net.br/)
1. https://github.com/abntex/abntex2


#### Instalação

Para poder utilizar a classe é necessário instalar o pacote abnTeX2 na sua
distribuição LaTeX, as configurações específicas para cada sistema, podem ser
encontradas no link abaixo.

1. [abntex2 CTAN](http://www.ctan.org/pkg/abntex2)
1. [abnTeX2 Instalação](https://github.com/abntex/abntex2/wiki/Instalacao)

Depois no diretório do seu projeto faça um clone dos arquivos do repositório.

```bash
git clone --recursive https://github.com/evandrocoan/ufscthesis
```


#### Uso

A ideia desse projeto é fazer com que você utilize a classe abnTeX2, mas com customizações voltadas
para as teses da UFSC, fazendo com que o seu uso seja idêntico ao uso direto da classe abnTeX2.

A documentação dessa classe pode ser encontrada aqui:

[Documentação](https://www.ctan.org/pkg/abntex2)

Também é possível encontrar modelos de documentos que utilizam a classe para tomar como base:

[Modelos abnTeX2](https://www.ctan.org/pkg/abntex2)



